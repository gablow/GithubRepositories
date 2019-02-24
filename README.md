# Fetch repositories of a GitHub user

Sample app to fetch repositories of a GitHub user and display some data like title, description, forks, stars, branches and commits.

## Overview

This app uses the [GitHub REST API v3](https://developer.github.com/v3/) to retrieve the user's public repositories and display the results in a simple [UITableView][0].

To retrieve the repositories, insert a GitHub username in the search bar.
Every cell shows the title, the description and the number of forks and stars, to retrieve the remaining data it has a button in the top right side. 

- Note: The GitHub REST API has a rate limits of 60 requests per hour for unauthenticated users.


[0]:https://developer.apple.com/documentation/uikit/uitableview


## Informations

The app requires iOS 9.0, it was developed with XCode 10.1 and Swift 4.2

It uses pods to manages library dependencies. The podfile includes these libraries:

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Getting Started

1. Clone this repo
1. Go to the project folder root
1. Open the `GitRepository.xcworkspace` file
1. Add a provisioning profile to sign or launch on the simulator

## Localization

It supports english and italian language.
To change the localized strings you can edit the `Localizable.string` files.

To retrieve these strings it uses a struct like in these example:

``` swift
struct LocalizedString {

    // Generic
    
    static let searchUser = "search_user".localized
    static let emptyRepositories = "repositories_empty".localized
```
[View in Source](x-source-tag://LocalizedString)

## Upcoming

- Reintegrate to the master branch
- Logout
- Handle multipage branches 
