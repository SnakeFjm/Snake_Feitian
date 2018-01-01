//
//  URLManager.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

class URLManager: NSObject {

    static let baseUrl = "http://123.207.68.190:21026"
    
    static func apiPath(apiName: String) -> String {
        var result: String = self.baseUrl + "/api/v1"
        if apiName.hasPrefix("/") {
            result = result + apiName
        } else {
            result = result + "/" + apiName
        }
        return result
    }
    
    // =================================
    // MARK:
    // =================================
    
    
}
