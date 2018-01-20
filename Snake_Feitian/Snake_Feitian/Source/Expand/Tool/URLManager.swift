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
    // MARK: 店铺管理
    // =================================
    
    // 店铺列表，新增店铺
    static func Feitian_branch() -> String {
        return self.apiPath(apiName: "/branch")
    }
    
    // 删除店铺，详情，修改店铺
    static func Feitian_branch(branchId: Int) -> String {
        return self.apiPath(apiName: "/branch/\(branchId)")
    }
    
    // =================================
    // MARK: 顾客管理
    // =================================
    
    // 添加跟进客户
    static func feitian_customer() -> String {
        return self.apiPath(apiName: "/customer")
    }
    
    // 给某个客户添加跟进者
    static func feitian_customerFollower() -> String {
        return self.apiPath(apiName: "/customer/follower")
    }
    
    // 获取某个员工跟进的客户
    static func feitian_customerUser(userId: Int) -> String {
        return self.apiPath(apiName: "/customer/user/\(userId)")
    }
    
    // 更多客户信息
    static func feitian_customerUser(userId: Int, customerId: Int) -> String {
        return self.apiPath(apiName: "/customer/user/\(userId)/more-detail/\(customerId)")
    }
    
    // 获取客户详情
    static func feitian_customer(customerId: Int) -> String {
        return self.apiPath(apiName: "/customer/\(customerId)")
    }
    
    // =================================
    // MARK: 售后管理
    // =================================
    
    // 获取售后列表
    static func feitian_followUp_user(userId: Int) -> String {
        return self.apiPath(apiName: "/follow-up/user/\(userId)")
    }
    
    // 获取某个售后详情, 处理售后详情
    static func feitian_followUp(followUpId: Int) -> String {
        return self.apiPath(apiName: "/follow-up/\(followUpId)")
    }
    
    // =================================
    // MARK: 消息
    // =================================
    
    // 获取工作消息
    static func feitian_message() -> String {
        return self.apiPath(apiName: "/message")
    }
    
    // 获取某一条消息详情
    static func feitian_message(messageId: Int) -> String {
        return self.apiPath(apiName: "/message/\(messageId)")
    }
    
    // =================================
    // MARK:  客户身体状况管理
    // =================================
    
    // 记录某个客户身体状况
    static func feitian_physicalStatus() -> String {
        return self.apiPath(apiName: "/physical-status")
    }
    
    // 获取某个客户身体状况列表
    static func feitian_physicalStatusCustomer(customerId: Int) -> String {
        return self.apiPath(apiName: "/physical-status/customer/\(customerId)")
    }
    
    // 删除某个身体状况记录, 修改某个身体状况记录
    static func feitian_physicalStatus(physicalStatusId: Int) -> String {
        return self.apiPath(apiName: "/physical-status/\(physicalStatusId)")
    }
    
    // =================================
    // MARK: 用户管理
    // =================================
    
    // 登录
    static func feitian_userLogin() -> String {
        return self.apiPath(apiName: "/user/login")
    }
    
    // 验证token是否有效
    static func feitian_userVerifyToken() -> String {
        return self.apiPath(apiName: "/user/verifyToken")
    }
    
    static func feitian_userPassword() -> String {
        return self.apiPath(apiName: "/user/password")
    }
    
    
    
//    账号：
    //    Jack:总经理，id=1
    //    James:经理助理，id=6
    //    Wade:店长，id=5
    // 获取用户列表, 注册用户
    static func feitian_user() -> String {
        return self.apiPath(apiName: "/user")
    }
    
    // 删除用户, 员工详情, 修改用户
    static func feitian_user(userId: Int) -> String {
        return self.apiPath(apiName: "/user/\(userId)")
    }
    
    // 根据店铺id获取店铺员工
    static func feitian_userBranch(branchId: Int) -> String {
        return self.apiPath(apiName: "/user/branch/\(branchId)")
    }
    
    // 获取branchId为-1,role为0的用户
    static func feitian_userBranchIdMinus1() -> String {
        return self.apiPath(apiName: "/user/branchIdMinus1")
    }
    
    // 获取跟进某个客户的员工
    static func feitian_userCustomer(customerId: Int) -> String {
        return self.apiPath(apiName: "/user/customer/\(customerId)")
    }
    
    // 获取某个店铺没有跟进某个客户的其他员工
    static func feitian_userBranchCustomer(branchId: Int, customerId: Int) -> String {
        return self.apiPath(apiName: "/user/branch/\(branchId)/customer/\(customerId)")
    }
    
    // =================================
    // MARK: 产品管理
    // =================================

    // 根据产品类别id获取产品列表
    static func feitian_product() -> String {
        return self.apiPath(apiName: "/product")
    }
    
    // 给客户添加在用产品
    static func feitian_productCustomer() -> String {
        return self.apiPath(apiName: "/product/customer")
    }
    
    // 获取客户在用产品
    static func feitian_productCustomer(customerId: Int) -> String {
        return self.apiPath(apiName: "/product/customer/\(customerId)")
    }
    
    // 获取产品类别列表
    static func feitian_productSeries() -> String {
        return self.apiPath(apiName: "/product/series")
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
