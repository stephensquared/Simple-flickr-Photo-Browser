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
    
    
    //@IBOutlet weak var photoDetailImageView: RemoteImageView!
    
    //@IBOutlet var scrollView: UIScrollView!
    
    var photo: FlickrPhoto?
    
    
    @IBOutlet weak var photoDetailImageView: RemoteImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoTitleLabel.text = photo?.title!
        
       // scrollView = UIScrollView()
        photoDetailImageView.imageURL = photo?.MediumPhotoUrlString()
        photoDetailImageView.contentMode = .scaleAspectFit
        //

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set up the correct aspect ratio
//        let photoDetailImageView = RemoteImageView()
//        photoDetailImageView.imageURL = photo?.MediumPhotoUrlString()
//        photoDetailImageView.contentMode = .scaleAspectFit
//        
//        var size = photoDetailImageView.frame.size
//        size.height = size.height / size.width * scrollView.frame.width
//        size.width = scrollView.frame.width
//        photoDetailImageView.frame.size = size
//        
//        scrollView.addSubview(photoDetailImageView)
        //scrollView.contentSize = size
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
