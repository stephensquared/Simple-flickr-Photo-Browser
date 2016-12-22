//
//  FlickrApi.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/9/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import Siesta
import SwiftyJSON

let FlickrApi = _FlickrApi()

class _FlickrApi {
    
    // MARK: - Configuration Properties
    /// Flickr API Key registered to Stephen Stephens.
    let flickrApiKey = "d1cc6605bd33e5045a8b26a7b2493bf7"
    let photosPerPage = 79
    var searchString = ""
    // Make a shared service instance for the Flickr REST API
    private let flickrApiService = Service(baseURL: "https://api.flickr.com")
    
    // MARK: - Initialization
    //** Initialize and configure the service. */
    fileprivate init() {
        #if DEBUG
            // This sets up logging of Siesta network calls.
            // Messages are output to the Target Output Window.
            LogCategory.enabled = [.network]
            
            // For more info about how Siesta decides whether to make a network call,
            // and when it broadcasts state updates to the app:
            //LogCategory.enabled = LogCategory.common
            
            // For the gory details of what Siesta’s up to:
            //LogCategory.enabled = LogCategory.detailed
        #endif
        // Global service configuration
        flickrApiService.configure {
            // By default, Siesta parses JSON using Foundation JSONSerialization.
            // This transformer wraps that with SwiftyJSON.
            $0.pipeline[.parsing].add(SwiftyJSONTransformer, contentTypes: ["*/json"])
            // Custom transformers can change any response into any other — in this case, replacing the default error
            $0.pipeline[.cleanup].add(FlickrErrorMessageExtractor())
            // Set the default timeout
            $0.expirationTime  = 10
        }
        
        // This transformer will take any resource that accesses a service/rest/ object.
        // It will then pass the JSON to the struct’s initializer.
        flickrApiService.configureTransformer("/services/rest/") {
            try FlickrOuterJsonWrapper(json: $0.content)
        }
    }
    
    // MARK: Resources
    // A Resource is a local cache of a RESTful resource from the API. It holds the data for the resource as well as status details about the network requests related to it.
    var interestingPhotos: Resource {
        return flickrApiService
            .resource("/services/rest/")
            .withParam("method", "flickr.interestingness.getList")
            .withParam("api_key", flickrApiKey)
            .withParam("format", "json")
            .withParam("nojsoncallback","?")
            .withParam("per_page", String(photosPerPage))
    }
    var searchPhotos: Resource {
        return flickrApiService
            .resource("/services/rest/")
            .withParam("method", "flickr.photos.search")
            .withParam("api_key", flickrApiKey)
            .withParam("format", "json")
            .withParam("nojsoncallback","?")
            .withParam("per_page", String(photosPerPage))
            .withParam("text", searchString)
    }
}
