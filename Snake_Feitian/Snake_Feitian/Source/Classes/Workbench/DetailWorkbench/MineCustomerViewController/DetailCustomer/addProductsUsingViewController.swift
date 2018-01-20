//
//  addProductsUsingViewController.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/20.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class addProductsUsingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var seriesTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var customerModel: CustomerModel!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK:
    // =================================
    
    @IBAction func confirmButtonDidTouch(_ sender: Any) {
        
    }
    
}
