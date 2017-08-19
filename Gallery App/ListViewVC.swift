//
//  ListViewVC.swift
//  Gallery App
//
//  Created by Rahul on 8/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ListViewVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var imageDataFromAPI = [FlickrData]()
    var imageArray: [UIImageView] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.global(qos: .userInitiated).async {
            FlickrData.getPhotoFromFlickrAPI(completionHandler: { (photosArray: [FlickrData]?, error: Error?) in
                if error == nil {
                    self.imageDataFromAPI = photosArray!
                    self.tableView.reloadData()
                    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageSlideShow" {
            let destinationVC = segue.destination as! ImageSlideShow
            if let cell = sender as? ListViewCell, let indexPath = tableView.indexPath(for: cell) {
                destinationVC.imageList = imageArray
                destinationVC.imageIndex = indexPath.row
                destinationVC.maxImages = tableView.visibleCells.count
            }
        }
    }

    func getAllCells() -> [UIImageView] {
        var imageView = [UIImageView]()
        for i in 0...tableView.numberOfSections-1{
            for j in 0...tableView.numberOfRows(inSection: i)-1{
                if let cell = tableView.cellForRow(at: IndexPath(row: j, section: i)) as? ListViewCell {
                    imageView.append(cell.imgView)
                }
            }
        }
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ListViewVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataFromAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        
        cell.imgView.downloadImage(url: imageDataFromAPI[indexPath.row].imageUrl!)
        cell.title?.text = imageDataFromAPI[indexPath.row].imageTitle
        cell.date?.text =  getTimeStampDate(CLong(imageDataFromAPI[indexPath.row].date!)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        if let currentCell = tableView.cellForRow(at: indexPath!)! as? ListViewCell {
            self.imageArray = getAllCells()
            self.performSegue(withIdentifier: "ImageSlideShow", sender: currentCell)
        }
    }
}

extension UIViewController {
    
    func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
        
        UIGraphicsBeginImageContext( newSize )
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysTemplate)
    }
    
    func getTimeStampDate(_ timeStamp: CLong) -> String{
        let dateFormat = Double(timeStamp)
        let date = Date(timeIntervalSince1970: dateFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "dd-MMM-YYYY"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

}
