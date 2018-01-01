//
//  YTNibPlaceHolderView.swift
//  Snake-OrderSystem
//
//  Created by Snake on 2017/11/15.
//  Copyright © 2017年 Snake. All rights reserved.
//

import UIKit

class YTNibPlaceHolderView: UIView {

    var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSubviews() {
        
        self.contentView = self.loadViewFromNib()
        
        self.addSubview(contentView)
        
        self.contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    func loadViewFromNib() -> UIView {
        
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        
        // 检测nib文件是否存在
        let path: String? = Bundle.main.path(forResource: name, ofType: "nib")
        if path == nil {
            return UIView.init()
        }
        
        let nib = UINib.init(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
        
    }
    
}
