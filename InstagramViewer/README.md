
# Simple Flickr Photo Browser Project

This app allows you to view photos posted as public on the flickr website.  The app pulls from flickr's "interesting" photos and also lets you perform text searches.


# Contributors

Stephen Stephens


## Installation

It should be ready to run, with no further configuration needed. (Usually I don't put frameworks like Siesta under source control, but, for ease of use, it is included here.)


## Requirements

Built for: iOS 10.1 / iPhone 7 / Xcode 8  / Swift 3.0

This library requires a deployment target of iOS 10.1 or greater.  It does not require being run on an iPhone 7, but it was tested and optimized for that device.


## Implementation

The app utilizes the flickr API (https://www.flickr.com/services/api/) to retrieve photos and information about photos. It uses the Siesta framework (https://bustoutsolutions.github.io/siesta/) to keep track of when the last data calls were made, indicates when data is being downloaded, and generally simplify the code needed to access any RESTfull resource. SwiftyJSON (https://cocoapods.org/pods/SwiftyJSON) helps convert JSON text strings into usable Swift structs and objects. And CocoaPods is used to help manage the Siesta and SwiftyJSON frameworks.
