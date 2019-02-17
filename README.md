## GitHub repositories fetcher with Swift 4.2 and Alamofire

[![Programming Language](https://img.shields.io/badge/languages-Swift_4-green.svg?style=flat)](#)

Application demo to get all the user's public repositories with stars, forks, commits and branches count.
It needs a GitHub account to the OAuth2 authentication.

#### Do not forget to change the value of the following keys:

1. ServiceEndpoints.plist
```swift
// Change with the data of your Github app
OAUTH_CLIENT_ID         
OAUTH_CLIENT_SECRET
OAUTH_REDIRECT_URI 	
```
2. AppDelegate
```swift
// Change with your schema
if ("githubrepositories" == url.scheme) 
```

#### Compatibility:

iOS 9.0

#### Upcoming:

- Error handle (NSError extension)
- Global alerts
- Handle multipage branches
- Logout
