//
//  BaseTableViewCell.swift
//  FoodDetect
//
//  Created by dev on 2017/12/1.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellUI(result: JSON) {
        
    }
    
}
