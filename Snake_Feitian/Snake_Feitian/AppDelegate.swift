//
//  AppDelegate.swift
//  Snake_Feitian
//
//  Created by Snake on 2018/1/1.
//  Copyright © 2018年 Snake. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var loginVC: LoginViewController!
    
    var mainVC: MainViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置tarbarItem
        self.setTabbarItem()
        
        //设置监听
        self.addNotification()
        
        //判断登录状态
        self.checkLoginStatus()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // =================================
    // MARK:
    // =================================
    
    
    func setTabbarItem() {
        
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)], for: .normal)
        //
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)], for: .selected)
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkLoginStatus), name: K_LOGIN_CHECK_STATUS, object: nil)
    }
    
    // =================================
    // MARK:
    // =================================
    
    @objc func checkLoginStatus() {
        
        if SessionManager.share.isLogin == true {
            jumpToMainViewController()
            
            NotificationCenter.default.removeObserver(self, name: K_LOGIN_CHECK_STATUS, object: nil)
            
        } else {
            jumpToLoginViewController()
        }
    }
    
    func jumpToLoginViewController() {
        loginVC = LoginViewController()
        self.setWindowRootViewController(vc: loginVC)
    }
    
    func jumpToMainViewController() {
        mainVC = MainViewController()
        self.setWindowRootViewController(vc: mainVC)
    }
    
    func setWindowRootViewController(vc: UIViewController) {
        
        if window == nil {
            self.window = UIWindow.init(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.clear
        }
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }
}
