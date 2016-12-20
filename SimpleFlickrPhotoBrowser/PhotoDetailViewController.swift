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

    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoDetailImageView: RemoteImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoDetailTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var photoDetailTopConstraint: NSLayoutConstraint!
    
    var photo: FlickrPhoto?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoTitleLabel.text = photo?.title!
        photoDetailImageView.imageURL = photo?.MediumPhotoUrlString()
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set up the correct aspect ratio for the initial view of the photo.
        setZoomScaleForPhoto(size: view.bounds.size)
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhotoDetailViewController: UIScrollViewDelegate {
    
    /// This method returns an ImageView which will be scaled when the scroll view is pinched.
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoDetailImageView
    }
    
}
