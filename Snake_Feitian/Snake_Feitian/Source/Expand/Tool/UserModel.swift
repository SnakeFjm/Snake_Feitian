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
    //
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
    
    convenience init(dict: NSMutableDictionary) {
        self.init()
        
        if let token = dict["token"] as? String {
            self.token = token
        }
        
        if let id = dict["id"] as? Int {
            self.id = id
        }
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let password = dict["password"] as? String {
            self.password = password
        }
        
        if let role = dict["role"] as? Int {
            self.role = role
        }
        
        if let sex = dict["sex"] as? String {
            self.sex = sex
        }
        
        if let contact = dict["contact"] as? String {
            self.contact = contact
        }
        
        if let branchId = dict["branchId"] as? Int {
            self.branchId = branchId
        }
        
        if let birthday = dict["birthday"] as? String {
            self.birthday = birthday
        }
        
        if let address = dict["address"] as? String {
            self.address = address
        }
        
        if let status = dict["status"] as? String {
            self.status = status
        }
        
        if let createTime = dict["createTime"] as? Int {
            self.createTime = createTime
        }
        
        if let modifyTime = dict["modifyTime"] as? Int {
            self.modifyTime = modifyTime
        }
        
    }
    
}
