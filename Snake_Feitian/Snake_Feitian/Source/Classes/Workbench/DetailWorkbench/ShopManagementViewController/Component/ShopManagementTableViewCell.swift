//
//  ShopManagementTableViewCell.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/20.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ShopManagementTableViewCell: BaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func updateCellUI(result: JSON) {
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2
        self.headImageView.layer.masksToBounds = true
        self.headImageView.backgroundColor = UIColor.init(red: 241/255, green: 194/255, blue: 55/255, alpha: 1)
        
        let place: String = result["name"].stringValue
        let status: String = result["status"].stringValue
        
        self.placeLabel.text = place
        self.statusLabel.text = status
        self.statusNumberLabel.text = ""
        //
        self.iconNameLabel.text = String.init(describing: place.last!)
    }
    
}
