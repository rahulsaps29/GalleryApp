//
//  GridViewVC.swift
//  Gallery App
//
//  Created by Apple on 8/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class GridViewVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    var imageDataFromAPI = [FlickrData]()
    var imageArray: [UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DispatchQueue.global(qos: .userInitiated).async {
            FlickrData.getPhotoFromFlickrAPI(completionHandler: { (photosArray: [FlickrData]?, error: Error?) in
                if error == nil {
                    self.imageDataFromAPI = photosArray!
                    self.collectionView.reloadData()
                    //self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageSlideShow" {
            let destinationVC = segue.destination as! ImageSlideShow
            if let cell = sender as? GridViewCell, let indexPath = collectionView.indexPath(for: cell) {
                destinationVC.imageList = imageArray
                destinationVC.imageIndex = indexPath.row
                destinationVC.maxImages = collectionView.visibleCells.count
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getAllCells() -> [UIImageView] {
        var cells = [UIImageView]()
        for i in 0...collectionView.numberOfSections-1 {
            for j in 0...collectionView.numberOfItems(inSection: i) - 1 {
                if let cell = collectionView.cellForItem(at: IndexPath(item: j, section: i)) as? GridViewCell {
                    cells.append(cell.imgView)
                }
            }
        }
        return cells
    }
}


extension GridViewVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataFromAPI.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! GridViewCell
        
        cell.imgView.downloadImage(url: imageDataFromAPI[indexPath.row].imageUrl!)
        cell.title?.text = imageDataFromAPI[indexPath.row].imageTitle
        cell.date?.text =  getTimeStampDate(CLong(imageDataFromAPI[indexPath.row].date!)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath = collectionView.indexPathsForSelectedItems?.first
        if let currentCell = collectionView.cellForItem(at: indexPath!) as? GridViewCell {
            self.imageArray = getAllCells()
            print("Image downloaded. Current count: \(imageArray.count)")
            self.performSegue(withIdentifier: "ImageSlideShow", sender: currentCell)
        }
    }
    
}
