//
//  UIImageDownload.swift
//  Gallery App
//
//  Created by Apple on 8/19/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation

import UIKit

class UIImageViewAsync : UIImageView {
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func getDataFromUrl(url:String, completion: @escaping ((_ data: NSData?) -> Void)) {
        let urlString = URL(string: url)
        self.setImageWith(urlString!)
    }
    
    func downloadImage(url:String){
        getDataFromUrl(url: url) { data in
            DispatchQueue.main.async() {
                self.contentMode = UIViewContentMode.scaleAspectFill
                self.image = UIImage(data: data! as Data)
            }
        }
    }

}
