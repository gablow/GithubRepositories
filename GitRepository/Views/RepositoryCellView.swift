//
//  RepositoryCellView.swift
//  GitRepository
//
//  Created by Lorenzo Colaizzi on 11/02/2019.
//  Copyright © 2019 Lorenzo Colaizzi. All rights reserved.
//

import UIKit

protocol LoadMoreInfoButtonDelegate{
    func loadMoreInfo(at index:IndexPath)
}

class RepositoryCellView: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var commitsLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    @IBOutlet weak var branchView: UIView!
    @IBOutlet weak var commitsView: UIView!

    
    var delegate: LoadMoreInfoButtonDelegate!
    var indexPath: IndexPath!
    
    @IBAction func loadMoreInfoAction(_ sender: UIButton) {
        self.moreInfoButton.isHidden = true
        self.spinner.startAnimating()
        self.delegate?.loadMoreInfo(at: indexPath)
    }
    
}
