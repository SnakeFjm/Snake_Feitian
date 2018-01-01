//
//  StringMd5.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

extension String {
    func md5() -> String {
        
        let cString = self.cString(using: String.Encoding.utf8)
        let length = CUnsignedInt(
            self.lengthOfBytes(using: String.Encoding.utf8)
        )
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(
            capacity: Int(CC_MD5_DIGEST_LENGTH)
        )
        
        CC_MD5(cString!, length, result)
        
        return String(format:
            "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15])
        
        //        let str = self.cString(using: String.Encoding.utf8)
        //        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        //        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        //        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        //        let hash = NSMutableString()
        //        for i in 0 ..< digestLen {
        //            hash.appendFormat("%02x", result[i])
        //        }
        //        result.deinitialize()
        //
        //        return String(format: hash as String)
    }
}
