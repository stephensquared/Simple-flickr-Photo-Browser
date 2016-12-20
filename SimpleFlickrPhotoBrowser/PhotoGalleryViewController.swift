//
//  PhotoGalleryViewController.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import UIKit
import Siesta


class PhotoGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ResourceObserver {
    
    // MARK: - UI Items
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var searchTextBar: UITextField!
    
    @IBAction func searchButtonTouched(_ sender: Any) {
        
        // Don't do a search unless the search string has > 0 characters.
        if searchTextBar.text?.characters.count == 0 {
            return
        } else {
            photoRetrievalIsFromSearch = true
            
            // Re-initialize the FlickApi to search for the entered text.
            // This triggers the photoListResource didSet listener and the resource is updated.
            FlickrApi.searchString = searchTextBar.text!
            photoListResource = FlickrApi.searchPhotos
            
            scrollToTop()
        }
    }
    
    @IBAction func interestingButtonTouched(_ sender: Any) {
        photoRetrievalIsFromSearch = false
        searchTextBar.text = ""

        // Re-initialize the FlickApi to search for interesting photos.
        // This triggers the photoListResource didSet listener and the resource is updated.
        photoListResource = FlickrApi.interestingPhotos
        
        scrollToTop()
    }
    
    
    
    var photoRetrievalIsFromSearch = false
    
    /// Scrolls the UICollectionView back to the top
    func scrollToTop(){
        photoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                         at: .top,
                                         animated: true)
    }
    
    //var headerPhotoCommentView: PhotoItemCommentView?
    
    //var headerComment
    
    // MARK: - Siesta Properties and Methods for Flickr API
    
    var photoListResource: Resource? {
        didSet {
            
            oldValue?.removeObservers(ownedBy: self)
            
            // Removes any existing observers.
            // Adds self and the status overlay as observers.
            // Loads the data if needed based on the cache expiration timeout.
            photoListResource?
                .addObserver(self) // Conforms to the ResourceObserver protocol
                .addObserver(loadingStatusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    
    // Siesta has a UI helper called ResourceStatusOverlay that will provide
    // a progress indicator when the list is being fetched as well as a
    // mechanism to retry a request if it fails.
    var loadingStatusOverlay = ResourceStatusOverlay()
    
    var arrayOfPhotos: [FlickrPhoto] = [] {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    
    var testFlickrApiOuterWrapper: FlickrOuterJsonWrapper? {
        didSet {
            // TODO: Need this?
            //tableView.reloadData()
            
            
        }
    }
    
    // The resourceChanged() function will be called when the resource
    // broadcasts a change event. This usually means new data is available.
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        
        // The typedContent() function returns a type-casted value
        // for the latest result for the Resource if available.
        // The <FlickrApiOuterWrapper> type will be inferred by the typedContent method.
        //        testFlickrApiOuterWrapper = photoListResource?.typedContent()
        //
        //        // Unwrap the data from the API and populate the array
        //        if(testFlickrApiOuterWrapper != nil){
        //            arrayOfPhotos = (testFlickrApiOuterWrapper?.photos?.photoArray)!
        //        }
        
        
        // Try it a different way:
        if let flickrApiOuterWrapper: FlickrOuterJsonWrapper = photoListResource?.typedContent() {
            
            // typedContent consistently adds hundreds of null entries to this array.
            // Therefore, truncate the array to the first [photosPerPage] entries.
            let tempArrayOfPhotos = (flickrApiOuterWrapper.photos?.photoArray)!
            arrayOfPhotos = Array(tempArrayOfPhotos.prefix(FlickrApi.photosPerPage))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = SiestaTheme.darkColor
        loadingStatusOverlay.embed(in: self)
        
        // Initialize the API resource
        if !photoRetrievalIsFromSearch {
            photoListResource = FlickrApi.interestingPhotos
        } else {
            photoListResource = FlickrApi.searchPhotos
        }
        
        // TODO: Put in the search bar
        //searchBar.becomeFirstResponder()
        
        photoCollectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPhotos.count
    }
    
    // Create cells for the collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryItemCollectionViewCell", for: indexPath) as! PhotoGalleryItemCollectionViewCell
        
        // Send a photo object to the cell, where a remote image URL
        // will then be constucted using the photo information.
        cell.SetRemoteImageUrl(arrayOfPhotos[indexPath.row])
        
        return cell
    }
    
    // Implement the header view.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let photoCommentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GalleryItemCommentView", for: indexPath) as! PhotoItemCommentView
        if photoRetrievalIsFromSearch {
            photoCommentView.photoItemCommentLabel.text = "search results for \"\(FlickrApi.searchString)\""
        } else {
            photoCommentView.photoItemCommentLabel.text = "recent interesting photos"
        }
        //headerPhotoCommentView = photoCommentView
        
        return photoCommentView
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    
//    // Detect the selection of cells.
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let alert = UIAlertController(title: "didSelectItemAtIndexPath:", message: "Indexpath = \(indexPath)", preferredStyle: .alert)
//        
//        let alertAction = UIAlertAction(title: "Dismiss", style: .destructive, handler: nil)
//        alert.addAction(alertAction)
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    // dynamically change cell sizes and insets
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacingWidthTotal = CGFloat(4.0 * 4.0) // 4 spacers (for 3 columns) at 4 pixels each
        let picDimension = (self.view.frame.size.width - spacingWidthTotal) / 3.0  // Orginal = 4.0
        return CGSize(width: picDimension, height: picDimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = CGFloat(4.0) //self.view.frame.size.width / 40.0  //14.0
                return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
    
    // MARK:- Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Segue to detail photo view.
        if segue.identifier == "PhotoDetailSegueIdentifier" {
            
            // Determine the index path for the selected photo
            var indexPath:IndexPath?
            if (photoCollectionView.indexPathsForSelectedItems?.count)! > 0 {
                indexPath = photoCollectionView.indexPathsForSelectedItems?[0]
            }
            
            // Set the photo object in the detail view control before segue.
            if let detailViewController = segue.destination as? PhotoDetailViewController {
                detailViewController.photo = arrayOfPhotos[(indexPath?.row)!]
            }
        }
    }
    
}
