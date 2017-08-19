//
//  Model.swift
//  Gallery App
//
//  Created by Apple on 8/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
typealias FlickrResponse = ([FlickrData]?, Error?) -> Void
let flickrAPI = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=086da4f63ecd480edf531e2ec0db2a83&tags=mountains&per_page=10&format=json&nojsoncallback=1"

class FlickrData: NSObject {
    
    var imagView: UIImageView?
    var imageUrl: String?
    var imageTitle: String?
    var date: String?
    
    
    init(imageUrl: String, imageTitle: String, date: String) {
        self.imageUrl = imageUrl
        self.imageTitle = imageTitle
        self.date = date
    }
    
    
    class func getPhotoFromFlickrAPI(completionHandler: @escaping FlickrResponse) {
        var imageDataFromAPI = [FlickrData]()
        let manager = AFHTTPSessionManager(baseURL: URL(string: flickrAPI))
        manager.responseSerializer = AFJSONResponseSerializer()
        
        _ = [manager.post("", parameters: nil, progress: nil, success: {
            (task, responseObject)  in
            if let dict : NSDictionary = responseObject as? NSDictionary {
                let photos = dict["photos"] as! NSDictionary
                let photoList = photos["photo"] as! NSArray
                for imgData in  photoList {
                    let imageData: NSDictionary = (imgData as? NSDictionary)!
                    let theTitle = imageData["title"] as! String
                    let farm = imageData["farm"]!
                    let server = imageData["server"]!
                    let secret = imageData["secret"]!
                    let id = imageData["id"]!
                    let imageURL = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
                    
                    getUploadDateOfPhoto(photoId: id as! String, completion: { (photoDate) in
                        let dataFromFlickr = FlickrData.init(imageUrl: imageURL, imageTitle: theTitle, date: photoDate!)
                        imageDataFromAPI.append(dataFromFlickr)
                        completionHandler(imageDataFromAPI, nil)
                    })
                }
            }
        } ,failure: {
            (task: URLSessionDataTask?, error: Error?) in
            print("error: ",error!)
            completionHandler(nil, error)
        })]
    }
    
    class func downloadImage(){
    
    }
    
    class func getUploadDateOfPhoto(photoId: String, completion: @escaping (String?) -> Void){
        let getDateAPI = "https://api.flickr.com/services/rest/?api_key=086da4f63ecd480edf531e2ec0db2a83&photo_id=\(photoId)&method=flickr.photos.getinfo&format=json&nojsoncallback=1"
        let manager = AFHTTPSessionManager(baseURL: URL(string: getDateAPI))
        manager.responseSerializer = AFJSONResponseSerializer()
        _ = [manager.post("", parameters: nil, progress: nil, success: {
            (task, responseObject)  in
            if let dict : NSDictionary = responseObject as? NSDictionary {
                let photoInfo = dict["photo"] as! NSDictionary
                let photoList = photoInfo["dateuploaded"] as! String
                completion(photoList)
            }
        } ,failure: {
            (task: URLSessionDataTask?, error: Error?) in
            completion(nil)
        })]

    }
    
    
}
