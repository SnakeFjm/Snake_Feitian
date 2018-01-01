//
//  DetailMessageViewController.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/12/7.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class DetailMessageViewController: BaseViewController {

    var titleValue: String = ""     //标题

    var dateValue: String = ""      //日期

    var contentValue: String = ""   //内容
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息详情"
        
        self.titleLabel.text = self.titleValue
        
        self.dateLabel.text = self.dateValue
        
        self.contentLabel.text = self.contentValue
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
