//
//  AfterSaleTableViewCell.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/20.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON

class AfterSaleTableViewCell: BaseTableViewCell {

    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateCellUI(result: JSON) {
        
    }
    
}
