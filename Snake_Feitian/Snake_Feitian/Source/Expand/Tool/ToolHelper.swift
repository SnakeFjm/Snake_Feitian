//
//  ToolHelper.swift
//  FoodDetect
//
//  Created by dev on 2017/12/1.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import Foundation


// 屏幕宽度
let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width

// 屏幕高度
let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height

// 导航栏高度
let NavigationBarHeight: CGFloat = (isiPhoneX ? 84 : 64)

// tabbar高度
let TabBarHeight: CGFloat = (isiPhoneX ? 83 : 49)

// 正常tabbar高度
let TabBarNormalHeight: CGFloat = 49

// iPhoneX 屏幕高度
let iPhoneXScreenHeight: CGFloat = 812

// iPhoneX 状态栏高度
let iPhoneXStatusBarHeight: CGFloat = 44

// iPhoneX 底部高度
let iPhoneXBottomHeight: CGFloat = 34

// 是否需预留底部高度
let AdjustBottomHeight: CGFloat = (isiPhoneX ? iPhoneXBottomHeight : 0)

// 判断是否为iPhoneX
let isiPhoneX: Bool = (ScreenHeight == iPhoneXScreenHeight)



// 判断是是否为iOS11以上系统
func isSystemAfteriOS11() -> Bool {
    if #available(iOS 11.0, *) {
        return true
    }
    return false
}


// 判断字符串是否为空或者nil
func isStringEmpty(_ content: String?) -> Bool {
    if content == nil || content?.characters.count == 0 {
        return true
    }
    return false
}
