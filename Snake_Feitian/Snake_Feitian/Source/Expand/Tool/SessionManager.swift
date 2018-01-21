//
//  SessionManager.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

//基本信息

let K_BasicInformation = "K_BasicInformation"

let K_UserId =  "id" // id
let K_UserName = "k_name" // 名字
let K_Role = "k_role" // 角色

let K_UserModel = "K_UserModel"

//手机号
let K_LOGIN_MOBILE: String = "K_LOGIN_MOBILE"

//密码
let K_LOGIN_PASSWORD: String = "K_LOGIN_PASSWORD"

//记住密码
let K_LOGIN_NEED_REMEMBER_PWD: String = "K_LOGIN_NEED_REMEMBER_PWD"

class SessionManager: NSObject {
    
    //是否登录
    var isLogin: Bool = false
    
    //用户基本信息
    var basicInformation: NSMutableDictionary = NSMutableDictionary.init()
    //
    var userModel: UserModel!
    
    static private let _share: SessionManager = SessionManager.init()
    class var share: SessionManager {
        get {
            return _share
        }
    }
    
    //记住手机号码
    var rememberPhone: String {
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: K_LOGIN_MOBILE)
            } else {
                UserDefaults.standard.set("", forKey: K_LOGIN_MOBILE)
            }
        }
        get {
            return UserDefaults.standard.object(forKey: K_LOGIN_MOBILE) as? String ?? ""
        }
    }
    
    //记住密码
    var rememberPassword: String {
        set {
            if !newValue.isEmpty {
                UserDefaults.standard.set(newValue, forKey: K_LOGIN_PASSWORD)
            } else {
                UserDefaults.standard.set("", forKey: K_LOGIN_PASSWORD)
            }
        }
        get {
            return UserDefaults.standard.object(forKey: K_LOGIN_PASSWORD) as? String ?? ""
        }
    }
    
    //是否记住密码
    var isNeedRememberPassword: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: K_LOGIN_NEED_REMEMBER_PWD)
        }
        get {
            return UserDefaults.standard.bool(forKey: K_LOGIN_NEED_REMEMBER_PWD)
        }
    }
    
    //保存基本信息
    func saveBasicInformation(dict: NSDictionary) {
        
        self.basicInformation = NSMutableDictionary.init(dictionary: dict)
        //
        self.userModel = UserModel.init(dict: basicInformation)

        if let _ = (self.basicInformation["remark"]) as? String {
            
        } else {
            self.basicInformation["remark"] = ""
        }
        
        if let _ = (self.basicInformation["birthday"]) as? String {
            
        } else {
            self.basicInformation["birthday"] = ""
        }
        
        UserDefaults.standard.set(self.basicInformation, forKey: K_BasicInformation)
        UserDefaults.standard.synchronize()
    }
    
    //获取基本信息
    func getBasicInformation() -> [String: Any] {
        return UserDefaults.standard.dictionary(forKey: K_BasicInformation)!
    }
    
    //清除
    func cleanBasicInformation() {
        self.basicInformation = NSMutableDictionary.init()
        UserDefaults.standard.removeObject(forKey: K_BasicInformation)
        UserDefaults.standard.synchronize()
    }
    
    // 用户UserId
    var userId: Int {
        get {
            if let uid: Int = self.basicInformation.object(forKey: K_UserId) as? Int {
                return uid
            } else {
                return 0
            }
        }
    }
}


//self.basicInformation
//    id= 4
//    sex = FEMALE
//    contact = 14500000000
//    branchId = 1
//    password = e10adc3949ba59abbe56e057f20f883e
//    birthday = 1987-09-12
//    address = 广东深圳
//    createTime = 1507436449000
//    role = 4
//    modifyTime = 1507439779000
//    token = eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0IiwiaWF0IjoxNTEyNDY1NTU3LCJyb2xlIjo0fQ.DdRGGJQM5EvaUkTd2MONhtNEDSJJI79ri9hyNl5AoL8
//    name = Funny
//    status = ON



