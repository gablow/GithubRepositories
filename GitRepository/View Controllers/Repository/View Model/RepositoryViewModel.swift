//
//  RepositoryViewModel.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import Foundation
import UIKit

protocol RepositoryViewModelDelegate: class {
    func onUpdateUserInfo(userName: String)
    func onUpdateErrorUserInfo(error: NSError)
    func onUpdateRepository()
    func onUpdateErrorRepository(error: NSError)
    func onUpdateCell(indexPath: IndexPath)
    func onUpdateErrorCell(error: NSError)
}

class RepositoryViewModel {
    
    weak var delegate: RepositoryViewModelDelegate?
    var repositoriesDataSource: Repositories?
    var networkService = NetworkService()
    var user: User?
    var refreshing = false
    
    func fetchUserInfo(user: String) {

        let endpoint = NSURL(string: Services.valueForServiceKey(key: .GitHubUsersUrl)! + user)
        let parser = UserParser()

        self.refreshing = true
        
        self.networkRequest(endpoint: endpoint!, parser: parser) { (parsedModel, linkHeader, error) in
            // TODO: add NSError extensions
            if let _ = error {
                print(error!)
            }
            
            guard let parsedUser = parsedModel as? User else {
                self.delegate?.onUpdateErrorUserInfo(error: error!)
                return
            }
            
            self.user = parsedUser
            self.repositoriesDataSource = Repositories(repositoriesNumber: self.user!.reposNum)
            
            self.delegate?.onUpdateUserInfo(userName: self.user?.name ?? "")
            
            self.refreshing = false
        }
        
    }
    
    func fetchRepositories() {

        let pageCount = repositoriesDataSource!.pageNumber.intValue
        repositoriesDataSource!.pageNumber = NSNumber(value: pageCount + 1)
        
        self.refreshing = true

        let pageToFetch = repositoriesDataSource!.pageNumber.stringValue
        let endpoint = NSURL(string: Services.valueForServiceKey(key: .GitHubUsersUrl)! + user!.login + "/repos" + "?page=" + pageToFetch)
        let parser = RepositoriesListParser()
        
        self.networkRequest(endpoint: endpoint!, parser: parser) { (parsedModel, linkHeader, error) in
            if let _ = error {
                print(error!)
                return
            }
            
            guard let repository = parsedModel as? [Repository] else {
                print(error!)
                return
            }
            
            self.repositoriesDataSource!.repositories.append(contentsOf: repository)
            
            self.delegate?.onUpdateRepository()
            
            self.refreshing = false
        }
        
    }

    func fetchMoreInfo(index: IndexPath) {
        self.fetchBranches(index: index)
    }
    
    func fetchBranches(index: IndexPath) {
        let repositories = self.repositoriesDataSource!.repositories
        let currentRepository = repositories[index.row] as Repository
        let parser = MoreInfoParser()

        self.refreshing = true
        
        let endpoint = NSURL(string: Services.valueForServiceKey(key: .GitHubReposUrl)! + user!.login + "/" + currentRepository.name + "/branches")

        self.networkRequest(endpoint: endpoint!, parser: parser) { (parsedModel, linkHeader, error) in
            if let _ = error {
                print(error!)
                return
            }
            
            guard let parsedArray = parsedModel as? [String] else {
                print(error!)
                self.delegate?.onUpdateErrorCell(error: error!)
                return
            }

            // TODO: handle multipage branches
            
            self.repositoriesDataSource!.repositories[index.row].branches = parsedArray.count as NSNumber
            
            self.fetchCommits(index: index)
        }
        
    }
    
    func fetchCommits(index: IndexPath) {
        
        let repositories = self.repositoriesDataSource!.repositories
        let currentRepository = repositories[index.row] as Repository
        let parser = MoreInfoParser()
        
        let endpoint = NSURL(string: Services.valueForServiceKey(key: .GitHubReposUrl)! + user!.login + "/" + currentRepository.name + "/commits")

        self.networkRequest(endpoint: endpoint!, parser: parser) { (parsedModel, linkHeader, error) in
            if let _ = error {
                print(error!)
                return
            }
            
            guard let parsedArray = parsedModel as? [String] else {
                print(error!)
                self.delegate?.onUpdateErrorCell(error: error!)
                return
            }
            
            let lastPage = self.parseLinkHeader(header: linkHeader)
            let totalForPage = parsedArray.count

            if (lastPage.isEmpty) {
                self.repositoriesDataSource!.repositories[index.row].commits = parsedArray.count as NSNumber
                self.repositoriesDataSource!.repositories[index.row].complete = true

                self.delegate?.onUpdateCell(indexPath: index)
                self.refreshing = false
            }
            else {
                let lastEndPoint = endpoint!.absoluteString! + "?page="
                self.fetchAllCommits(endpoint: lastEndPoint, lastPage: lastPage, totalForPage: totalForPage, index: index)
            }
            
        }
    }
    
    func fetchAllCommits(endpoint: String, lastPage: String, totalForPage: Int, index: IndexPath) {
        
        let parser = MoreInfoParser()
        let endPointUrl = NSURL(string: endpoint + lastPage)
        
        self.networkRequest(endpoint: endPointUrl!, parser: parser) { (parsedModel, linkHeader, error) in
            if let _ = error {
                print(error!)
                return
            }
            
            guard let parsedArray = parsedModel as? [String] else {
                print(error!)
                return
            }
        
            let page = Int(lastPage)!
            let total = totalForPage * (page - 1) + parsedArray.count
            
            self.repositoriesDataSource!.repositories[index.row].commits = total as NSNumber
            self.repositoriesDataSource!.repositories[index.row].complete = true

            self.delegate?.onUpdateCell(indexPath: index)
            self.refreshing = false
        }
    }
    
    // Helper
    
    func parseLinkHeader(header: String?) -> (String) {
        guard let links = header?.components(separatedBy: ",") else {
            return ""
        }
        
        var dictionary: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            dictionary[components[1]] = cleanPath
        })
        
        if let lastPagePath = dictionary["rel=\"last\""] {
            let parsed = lastPagePath.components(separatedBy: "page=")[1]
            return parsed
        }
        else {
            return ""
        }
        
    }
    
}
