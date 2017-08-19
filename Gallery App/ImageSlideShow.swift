//
//  ImageSlideShow.swift
//  Gallery App
//
//  Created by Apple on 8/19/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ImageSlideShow: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var imageList:[UIImageView]?
    var maxImages:Int?
    var imageIndex: NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //maxImages = imageList?.count
        imgView.clipsToBounds = true
        
        //print("imageIndex",imageIndex,imageList?.count)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(_:))) // put : at the end of method name
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(_:))) // put : at the end of method name
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        imgView.image = (imageList?[imageIndex].image)
    }

    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right :
                imageIndex -= 1                             // decrease index first
                print("User swiped right")
                if imageIndex <= 0 {                         // check if index is in range
                    imageIndex = maxImages! - 1
                }
                print("User swiped right")
                imgView.image = (imageList?[imageIndex].image)
                
            case UISwipeGestureRecognizerDirection.left:
                imageIndex += 1                             // increase index first
                print("User swiped Left")
                if imageIndex >= maxImages! {                 // check if index is in range
                    imageIndex = 0
                }
                imgView.image = (imageList?[imageIndex].image)
                
            default:
                break //stops the code/codes nothing.
                
                
            }
            
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
