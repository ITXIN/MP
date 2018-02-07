//
//  MPAlertHVD.swift
//  MovieProject
//
//  Created by Bert on 16/9/28.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
import SnapKit
class MPAlertHVD: UIView {
    
    lazy var overlayView:UIControl =
        {
            var _overlayView:UIControl = UIControl()
            let window = UIApplication.shared.delegate?.window
            let windowBounds = window??.bounds
            _overlayView = UIControl.init(frame: windowBounds!)
            
            if (_overlayView.frame.size.height < 100)
            {
                
                _overlayView = UIControl.init(frame: UIScreen.main.bounds)
            }
            _overlayView.backgroundColor = UIColor.red

          
            return _overlayView
    }()
    
    
    
    fileprivate static var __once: () = {
        Inner.instance = MPAlertHVD()
    }()
    
    //单例
    class var shared: MPAlertHVD {
        _ = MPAlertHVD.__once
        return Inner.instance!
    }
    struct Inner {
        static var instance: MPAlertHVD?
        static var token: Int = 0
    }
    
    class func alertHVD() {
        self.shared.alertHVD()
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.alertHVD()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func alertHVD ()
    {
        
        
        let bgView = UIView.init(frame: UIScreen.main.bounds)
        bgView.alpha = 0.5
        bgView.backgroundColor = UIColor.black
        self.addSubview(bgView)
        self.frame = bgView.frame
       
        let  alertView = MPAlertView.init(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        self.addSubview(alertView)
        alertView.snp.makeConstraints { (make) in
            make.center.equalTo(self);
        }
        alertView.backgroundColor = UIColor.cyan
        
      self.backgroundColor = UIColor.red
        
        
        
    }
    
 
    
    
}
