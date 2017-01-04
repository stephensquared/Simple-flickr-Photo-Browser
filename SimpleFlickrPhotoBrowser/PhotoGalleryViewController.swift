//
//  PhotoGalleryViewController.swift
//  SimpleFlickrPhotoBrowser
//
//  Created by Stephen Stephens on 12/12/16.
//  Copyright © 2016 Stephen Stephens. All rights reserved.
//

import UIKit
import Siesta

class PhotoGalleryViewController: UIViewController, UITextFieldDelegate, ResourceObserver {
    
    // MARK: UI Elements
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var searchTextBar: UITextField!
    var arrayOfPhotos: [FlickrPhoto] = [] {
        didSet {
            photoCollectionView.reloadData()
        }
    }
    var loadingStatusOverlay = ResourceStatusOverlay()
    var photoListResource: Resource? {
        didSet {
            oldValue?.removeObservers(ownedBy: self)
            //* Removes any existing observers, adds self and the status overlay as observers, and loads the data if needed based on the cache expiration timeout. Also, add "_ = " to explicitly tell the compiler we're not using that value directly. This silences the compiler warning message.  */
            _ = photoListResource?
                .addObserver(self) // Conforms to the ResourceObserver protocol
                .addObserver(loadingStatusOverlay, owner: self)
                .loadIfNeeded()
        }
    }
    var photoRetrievalIsFromSearch = false
    
    // MARK: - Photo Data Source Methods
    @IBAction func searchButtonTouched(_ sender: Any) {
        if let searchTextString = searchTextBar.text {
            if searchTextString.characters.count > 0 {
                photoRetrievalIsFromSearch = true
                // Re-initialize the FlickApi to search for the entered text.
                // This triggers the photoListResource didSet listener and the resource is updated.
                FlickrApi.searchString = searchTextString
                photoListResource = FlickrApi.searchPhotos
                searchTextBar.resignFirstResponder()
                scrollToTop()
            } else {
                return
            }
        } else {
            return
        }
    }
    
    @IBAction func interestingButtonTouched(_ sender: Any) {
        photoRetrievalIsFromSearch = false
        searchTextBar.text = ""
        searchTextBar.delegate = self
        // Re-initialize the FlickApi to search for interesting photos.
        // This triggers the photoListResource didSet listener and then resource is updated.
        photoListResource = FlickrApi.interestingPhotos
        scrollToTop()
    }
    
    //** Called when the resource broadcasts a change event. This usually means new data is available. */
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        // Refresh the array of photos
        if let flickrApiOuterWrapper: FlickrOuterJsonWrapper = photoListResource?.typedContent() {
            /* SwiftyJSON consistently adds hundreds of null entries when parsing typedContent and producing this array. Therefore, truncate the array to the first [photosPerPage] entries. */
            if let tempPhotos = flickrApiOuterWrapper.photos, tempPhotos.photoArray.count > 0 {
                arrayOfPhotos = Array(tempPhotos.photoArray.prefix(FlickrApi.photosPerPage))
            } else {
                // There are no photos to display
                arrayOfPhotos = []
            }
        }
    }
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextBar.text = ""
        loadingStatusOverlay.embed(in: self)
        // Initialize the API resource.
        if photoRetrievalIsFromSearch {
            photoListResource = FlickrApi.searchPhotos
        } else {
            photoListResource = FlickrApi.interestingPhotos
        }
        photoCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segue to detail photo view.
        if segue.identifier == "PhotoDetailSegueIdentifier" {
            // Determine the index path for the selected photo
            if let indexPaths = photoCollectionView.indexPathsForSelectedItems, indexPaths.count > 0 {
                // Set the photo object in the detail view control before segue.
                if let detailViewController = segue.destination as? PhotoDetailViewController {
                    detailViewController.photo = arrayOfPhotos[indexPaths[0].row]
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoGalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //** Return the total number of photos in the single section collection. */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("ArrayOfPhotos.count = \(arrayOfPhotos.count)")
        return arrayOfPhotos.count
    }
    
    //** Create cells for the collectionView */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoGalleryItemCollectionViewCell", for: indexPath) as? PhotoGalleryItemCollectionViewCell {
            // Casting worked fine so set the URL for the remote image.
            cell.SetRemoteImageUrl(arrayOfPhotos[indexPath.row])
            return cell
        } else {
            // Casting was unsuccessful. (Provide this option to avoid using forced conversion.)
            precondition(false, "Casting to PhotoGalleryItemCollectionViewCell was unsucessful.")
        }
    }
    
    //** Implement the header view. */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let photoCommentView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PhotoItemCommentView", for: indexPath) as? PhotoItemCommentView {
            // Casting worked fine.
            if photoRetrievalIsFromSearch {
                if arrayOfPhotos.count > 0 {
                    photoCommentView.photoItemCommentLabel.text = "search results for \"\(FlickrApi.searchString)\""
                } else {
                    photoCommentView.photoItemCommentLabel.text = "no results found for \"\(FlickrApi.searchString)\""
                }
                searchTextBar.text = ""
            } else {
                photoCommentView.photoItemCommentLabel.text = "recent interesting photos"
            }
            return photoCommentView
        } else {
            // Casting was unsuccessful. (Provide this option to avoid using forced conversion.)
            precondition(false, "UICollectionViewCell casting was unsucessful.")
        }
    }
    
    /** Scroll to the top of the UICollectionView. */
    func scrollToTop(){
        if arrayOfPhotos.count > 0 {
            photoCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                             at: .top,
                                             animated: true)
            // Needed to scroll and make the header text visible.
            photoCollectionView.setContentOffset(CGPoint(x: 0.00, y: 0.00), animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PhotoGalleryViewController: UICollectionViewDelegate {
    
    //** Dynamically change cell sizes and insets. */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingWidthTotal = CGFloat(4.0 * 4.0)
        let picDimension = (self.view.frame.size.width - spacingWidthTotal) / 3.0
        return CGSize(width: picDimension, height: picDimension)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotoGalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightInset = CGFloat(4.0)
        return UIEdgeInsetsMake(0, leftRightInset, 0, leftRightInset)
    }
}
