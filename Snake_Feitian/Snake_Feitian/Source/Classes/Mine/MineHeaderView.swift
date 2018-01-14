//
//  MineHeaderView.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/15.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class MineHeaderView: YTNibPlaceHolderView {

    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    func updateUI(dict: NSDictionary) {
        
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2
        self.headImageView.layer.masksToBounds = true
        
        self.headImageView.backgroundColor = UIColor.red
        self.nameLabel.text = "查看个人信息"
        self.placeLabel.text = ""
        self.phoneLabel.text = ""
    }

}
