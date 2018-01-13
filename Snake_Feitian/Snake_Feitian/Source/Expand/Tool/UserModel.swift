//
//  UserModel.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/13.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

// role:0=总经理,1=经理助理,2=区域经理,3=店长,4=店员
// 总经理账号:12100000000,经理助理账号:14700000000,区域经理账号:12300000000,店长账号:14500000000,店员账号:13200000000

enum role_FeiTian: Int {
    case generalManager = 0
    case executiveAssistant = 1
    case regionalManager = 2
    case shopowner = 3
    case clerk = 4
}

class UserModel: NSObject {
    //
    var token: String = ""
    var id: Int = 0
    var name: String = ""
    var password: String = ""
    //
    var role: Int = 0
    //
    var sex: String = ""
    var contact: String = ""
    var branchId: Int = 0
    //
    var birthday: String = ""
    var address: String = ""
    var status: String = ""
    //
    var createTime: Int = 0
    var modifyTime: Int = 0
    
    //    convenience init(dict: NSMutableDictionary) {
    //        self.id = dict["id"] ?? 0 as! Int
    //    }
}
