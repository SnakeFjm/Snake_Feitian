//
//  UIViewController.swift
//  FoodDetect
//
//  Created by dev on 2017/10/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit
import MobileCoreServices
import SVProgressHUD

extension UIViewController {
    
    // =================================
    // MARK:
    // =================================
    
    // 推入控制器
    func push(_ viewController: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // 返回堆栈的某个类
    func backToClass(className: AnyClass) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController.isKind(of: className) {
                    self.navigationController?.popToViewController(viewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func back() {
        if self.qmui_isPresented() {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}



extension UIViewController: QMUIAlbumViewControllerDelegate, QMUIImagePickerViewControllerDelegate, QMUIImagePickerPreviewViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    // =================================
    // MARK: 弹窗询问相册
    // =================================
    
    // 相册
    func presentAlbumViewController() {
        
        let albumVC: QMUIAlbumViewController = QMUIAlbumViewController.init()
        albumVC.albumViewControllerDelegate = self
        albumVC.contentType = QMUIAlbumContentType.onlyPhoto
        albumVC.title = "相册"

        //
        let navController: UINavigationController = UINavigationController(rootViewController: albumVC)

        // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
        let assetsGroup: QMUIAssetsGroup? = QMUIImagePickerHelper.assetsGroupOfLastestPickerAlbum(withUserIdentify: nil)
        if assetsGroup != nil {
            let imagePicker: QMUIImagePickerViewController = self.imagePickerViewController(for: albumVC)
            imagePicker.refresh(with: assetsGroup)
            imagePicker.title = assetsGroup?.name()
            navController.pushViewController(imagePicker, animated: false)
        }

        //
        self.present(navController, animated: true, completion: nil)
    }
    
    
    // 照相
    func presentCamera() {
        let imagePicker: UIImagePickerController = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // =================================
    // MARK: QMUIAlbum ViewController Delegate
    // =================================
    
    public func imagePickerViewController(for albumViewController: QMUIAlbumViewController!) -> QMUIImagePickerViewController! {
        let imagePickerVC: QMUIImagePickerViewController = QMUIImagePickerViewController.init()
        imagePickerVC.imagePickerViewControllerDelegate = self
        imagePickerVC.maximumSelectImageCount = self.imageSelectMaximumSelectImageCount()
        return imagePickerVC
    }
    
    
    // =================================
    // MARK: QMUIImagePicker ViewController Delegate
    // =================================
    
    public func imagePickerViewController(_ imagePickerViewController: QMUIImagePickerViewController!, didFinishPickingImageWithImagesAssetArray imagesAssetArray: NSMutableArray!) {
        // 储存最近选择了图片的相册，方便下次直接进入该相册
        QMUIImagePickerHelper.updateLastestAlbum(with: imagePickerViewController.assetsGroup, ablumContentType: QMUIAlbumContentType.onlyPhoto, userIdentify: nil)
        
        self.imageSelectAssetArrayCallBack(imagesAssetArray: imagesAssetArray);
    }
    
    
    public func imagePickerPreviewViewController(for imagePickerViewController: QMUIImagePickerViewController!) -> QMUIImagePickerPreviewViewController! {
        let imagePickerPreviewVC: QMUIImagePickerPreviewViewController = QMUIImagePickerPreviewViewController.init()
        imagePickerPreviewVC.delegate = self
        imagePickerPreviewVC.maximumSelectImageCount = self.imageSelectMaximumSelectImageCount()
        return imagePickerPreviewVC
    }
    
    
    // =================================
    // MARK: UIImagePickerController Delegate
    // =================================
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType: String = info[UIImagePickerControllerMediaType] as! String
        if mediaType == (kUTTypeImage as String) {
            let orgImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imagePickerCameraCallBack(image: orgImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    /** 让调用者决定调用选择图片的上限 */
    @objc func imageSelectMaximumSelectImageCount() -> UInt {
        return 9
    }
    
    /** 拍照片的回调 */
    @objc func imagePickerCameraCallBack(image: UIImage) {
    }
    
    /** */
    @objc func imageSelectAssetArrayCallBack(imagesAssetArray: NSMutableArray) {
    }
    
    
}



extension UIViewController {
    
    // =================================
    // MARK:
    // =================================
    
    @objc func showSuccessTips(_ tips: String) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.showSuccess(withStatus: tips)
    }
    
    @objc func showErrorTips(_ tips: String) {
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.showError(withStatus: tips)
    }
    
    @objc func showLoadingTips(_ tips: String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: tips)
    }
    
    @objc func hideTips() {
        SVProgressHUD.dismiss()
    }
    
    
}


extension UIViewController {
    
}






