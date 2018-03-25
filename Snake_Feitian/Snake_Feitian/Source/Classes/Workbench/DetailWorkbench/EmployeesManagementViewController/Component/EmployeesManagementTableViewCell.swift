//
//  EmployeesManagementTableViewCell.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/7.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmployeesManagementTableViewCell: BaseTableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
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
        self.headImageView.backgroundColor = UIColor.green
        
        let place: String = result["name"].stringValue
        self.nameLabel.text = place
        //
        self.iconNameLabel.text = String.init(describing: place.last!)
    }
    
}
