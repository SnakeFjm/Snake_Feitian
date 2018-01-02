//
//  HttpManager.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HttpManager: NSObject {

     static let shareManager: HttpManager = HttpManager.init()
    
    override init() {
        super.init()
        //
        self.updateHttpsSession()
    }
    
//    func headers() -> HTTPHeaders {
//        var tempHeaders: HTTPHeaders = ["Content-Type": "application/json;charset=UTF-8"]
////        tempHeaders["Authorization"] = SessionManager.share.basicInformation.object(forKey: "token") as? String
//
//        return tempHeaders
//    }
    
    //更改https信任
    func updateHttpsSession() {
        Alamofire.SessionManager.default.delegate.sessionDidReceiveChallenge = {
            (session, challenge) in
            let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            challenge.sender?.use(credential, for: challenge)
            
            return (.useCredential, credential)
        }
    }
    
    // =================================
    // MARK: Request
    // =================================
    
    func request(url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil) -> DataRequest {
        //
        //let currentHeaders: HTTPHeaders = (headers == nil) ? self.headers() : headers!
        self.printRequestInfo(url, method: method, headers: headers)
        //
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        
    }
    
    // =================================
    // MARK: POST
    // =================================
    
    func postRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url: url, method: .post, parameters: parameters, encoding: URLEncoding.init(destination: URLEncoding.Destination.httpBody))
    }
    
    func postRequest(_ url: URLConvertible, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        return self.request(url: url, method: .post, parameters: parameters, encoding: encoding)
    }
    
    // =================================
    // MARK: Get
    // =================================
    
    func getRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url: url, method: .get, parameters: parameters, encoding: URLEncoding.default)
    }
    
    //分页
    func getRequest(_ url: URLConvertible, pageNum: Int, pageSize: Int,  parameters: Parameters? = nil) -> DataRequest  {
        
        if parameters != nil {
            //
            var paramDict = parameters!
            paramDict["pageNum"] = pageNum
            paramDict["pageSize"] = pageSize
            //
            return self.request(url: url, method: .get, parameters: paramDict, encoding: URLEncoding.init(destination: .methodDependent), headers: nil)
        } else {
            //
            let paramDict: Parameters = ["pageNum" : pageNum,
                                         "pageSize" : pageSize]
            //
            return self.request(url: url, method: .get, parameters: paramDict, encoding: URLEncoding.init(destination: .methodDependent), headers: nil)
        }
    }
    
    // =================================
    // MARK: Delete
    // =================================
    
    func deleteRequest(_ url: URLConvertible, parameters: Parameters? = nil) -> DataRequest {
        return self.request(url: url, method: .delete, parameters: parameters)
    }
    
    // =================================
    // MARK: Multipart
    // =================================
    
    func multipartRequest(_ url: URLConvertible, imageData: Data, name: String, fileName: String, mimeType: String, method: HTTPMethod = .post, encodingCompletion: ((Alamofire.SessionManager.MultipartFormDataEncodingResult) -> Void)?) {
//        //
//        let headers = self.headers()
//        self.printRequestInfo(url, method: method, parameters: nil, headers: headers)
//        //
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(imageData, withName: name, fileName: fileName, mimeType: mimeType)
//        }, to: url, method: method, headers: headers, encodingCompletion: encodingCompletion)
    }
    
    // =================================
    // MARK: 打印信息
    // =================================
    
    func printRequestInfo(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders?) {
        debugPrint("==================================")
        debugPrint(method.rawValue)
        debugPrint(url)
        debugPrint("==================================")
        if headers != nil {
            for (key, value) in headers! {
                debugPrint("\(key) : \(value)")
            }
        }
        debugPrint("==================================")
        if parameters != nil {
            for (key, value) in parameters! {
                debugPrint("\(key) : \(value)")
            }
        }
        debugPrint("==================================")
    }
    
    //
    static func printResponseData(result: JSON) {
        debugPrint(result)
        debugPrint("==================================")
    }
    
    // =================================
    // MARK: 检测JSON结果是否保存错误
    // =================================
    
    // 返回 nil 则表示存在error错误
    // 否则，直接返回解析出来的JSON
    static func parseDataResponse(response: DataResponse<Any>) -> JSON? {
        //
        switch response.result {
        case .success(let obj):
            let result: JSON = JSON.init(obj)
            printResponseData(result: result)
            //
            if let code = result["code"].int, code != 0, let msg: String = result["message"].string {
                self.handlerError(code: code, msg: msg)
            } else {
                return result
            }
        case .failure(let error):
            debugPrint(error)
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }
        return nil
    }
    
    // 处理错误信息
    static func handlerError(code: Int, msg: String) {
        //
        SVProgressHUD.showError(withStatus: "\(code)\n\(msg)")
        //
        switch code {
        case 401: //token无效
            //
            SessionManager.share.cleanBasicInformation()
            //
            NotificationCenter.default.post(name: K_LOGIN_CHECK_STATUS, object: nil)
        
        default:
            break
        }

    }
    
    // =================================
    // MARK:
    // =================================
    
    // json转NSDictionay
    static func jsonToNSDictionary(result: JSON) -> NSDictionary {
        //
        let jsonString = result.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonData = jsonString?.data(using: String.Encoding.utf8)
        //
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        if dictionary != nil {
            return dictionary as! NSDictionary
        } else {
            return NSDictionary.init()
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    // 判断是否能够加载更多
    static func checkIfCanLoadMOre(currentPage: Int, result: JSON) -> Bool {
        let totalPage = result["totalPage"].intValue
        if currentPage >= totalPage - 1 {
            return false
        }
        return true
    }

}
