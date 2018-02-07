//
//  LoginViewController.swift
//  MovieProject
//
//  Created by Bert on 16/8/24.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,LoginViewDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let loginView = LoginView.init(frame: self.view.bounds)
        loginView.loginDelegate = self
        self.view.addSubview(loginView)
        self.setupHeaderView()
        
    }
    
    func setupHeaderView() {
        let headerImageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 130))
        headerImageView.image = UIImage.init(named: "loginHeader")
        self.view.addSubview(headerImageView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.setImage(UIImage.init(named: "leftBack"), for: UIControlState())
        backBtn.tag = 1000
        self.view.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        backBtn.addTarget(self, action: #selector(self.backBtnClick(_:)), for: UIControlEvents.touchUpInside)
    }
    
    func loginClick(_ sender: UIButton) {
        print("--------login \(sender.currentTitle)")
        let titleStr = (sender.currentTitle! as String) + "登录成功"
        let alerView = UIAlertController.init(title: titleStr, message: nil, preferredStyle:UIAlertControllerStyle.alert)
      
        self.present(alerView, animated: true) {
            self.dismiss(animated: true, completion: {
                self.dismiss(animated: true, completion: nil)
                UserDefaults.standard.set(true, forKey: USER_LOG_STATE_KEY)
                let imagNameArr = ["weixin","weibo","qq"]
                let image = UIImage.init(named: imagNameArr[sender.tag - 2000])
                 let imageData = UIImageJPEGRepresentation(image!, 100)
                UserDefaults.standard.set(imageData, forKey: USER_ICON_KEY)
                UserDefaults.standard.synchronize()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_LOG_NOTIFICATION), object: nil, userInfo:nil)
                
                
                
            })
        }
        
    }
    
    func backBtnClick(_ sender:UIButton)  {
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
