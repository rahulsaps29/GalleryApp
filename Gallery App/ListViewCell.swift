//
//  ListViewCell.swift
//  Gallery App
//
//  Created by Apple on 8/18/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageViewAsync!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.clipsToBounds = true
        
        date.textColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
