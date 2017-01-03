//
//  PhotoDetailViewController.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import UIKit
import Siesta

class PhotoDetailViewController: UIViewController {

    // MARK: UI Elements
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoDetailImageView: RemoteImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoDetailTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailTopConstraint: NSLayoutConstraint!
    var photo: FlickrPhoto?
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoTitleLabelString = photo?.title {
            photoTitleLabel.text = photoTitleLabelString
        } else {
            photoTitleLabel.text = ""
        }
        photoDetailImageView.imageURL = photo?.GetMediumPhotoUrlString()
        scrollView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setZoomScaleForPhoto(size: view.bounds.size)
    }
    
    //** Calulate and set the correct aspect ratio for the initial view of the photo. */
    private func setZoomScaleForPhoto(size: CGSize) {
        // viewDidLayoutSubviews sometimes calls this method with size = 0.
        if photoDetailImageView.bounds.width == 0.0 {
            return
        }
        let widthRatio = size.width / photoDetailImageView.bounds.width
        let heightRatio = size.height / photoDetailImageView.bounds.height
        let minimumScale = min(widthRatio, heightRatio)
        // The minimum scale factor that can be applied to the scroll view's content.
        scrollView.minimumZoomScale =  minimumScale
        // The current scale factor that will be applied to the scroll view's content.
        scrollView.zoomScale = minimumScale
    }
}

// MARK: - UIScrollViewDelegate
extension PhotoDetailViewController: UIScrollViewDelegate {
    //** This method returns an ImageView which will be scaled when the scroll view is pinched. */
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoDetailImageView
    }
}
