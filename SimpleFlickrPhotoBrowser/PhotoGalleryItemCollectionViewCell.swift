//
//  PhotoGalleryItemCollectionViewCell.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class PhotoGalleryItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: RemoteImageView!
    
    func SetRemoteImageUrl(_ photo: FlickrPhoto) {
        photoImageView.imageURL = photo.GetSquareThumbnailUrlString()
    }
}
