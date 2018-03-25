//
//  MineCustomerTableViewCell.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/5.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MineCustomerTableViewCell: BaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var remarkLabel: UILabel!
    
    @IBOutlet weak var latestSaleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateCellUI(result: JSON) {
        self.headImageView.layer.cornerRadius = self.headImageView.frame.size.width/2
        self.headImageView.layer.masksToBounds = true
        self.headImageView.backgroundColor = UIColor.init(red: 241/255, green: 194/255, blue: 55/255, alpha: 1)
        
        let name: String = result["name"].stringValue
        let remarkName: String = result["remarkName"].stringValue
        
        self.nameLabel.text = name
        self.remarkLabel.text = remarkName
        //
        self.iconNameLabel.text = String.init(describing: name.last!)
        
    }
    
}
