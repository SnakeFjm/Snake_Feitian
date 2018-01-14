//
//  BodyStatusTableViewCell.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/14.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import SwiftyJSON

class BodyStatusTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var physicalStatusLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    
    let dateFormatter = DateFormatter.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.cellView.layer.cornerRadius = 5
        self.cellView.layer.masksToBounds = true
        self.cellView.layer.borderWidth = 1
        self.cellView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func updateCellUI(result: JSON) {
        self.physicalStatusLabel.text = result["physicalStatus"].stringValue
        self.creatorLabel.text = result["creator"].stringValue
        
        self.dateFormatter.dateFormat = "yyyy-MM-hh"
        let date = result["createTime"].intValue
        let dateValue = self.dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval.init(date/1000)))
        //
        self.createTimeLabel.text = dateValue
    }
    
}
