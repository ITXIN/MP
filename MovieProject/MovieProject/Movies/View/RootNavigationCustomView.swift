//
//  RootNavigationCutomView.swift
//  MovieProject
//
//  Created by Bert on 16/8/31.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
/// 首页导航栏
protocol RootNavigationCustomViewDelegate:NSObjectProtocol {
    func rootNavigationBtnClick(_ sender:UIButton)
    
}
enum NavigationCategory : NSInteger{
    case menu = 1000,search,history,downLoad
}

class RootNavigationCustomView: UIView {
    
    var rootNavigateDelegate:RootNavigationCustomViewDelegate!
    let searchTextField = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: frame.width, height: frame.height))
        }
        bgView.backgroundColor = RGBA(220, G: 50, B: 55, A: 1)
        
        
        let leftBtn = UIButton.init(type: UIButtonType.custom)
        leftBtn.setImage(UIImage.init(named: "menu"), for: UIControlState())
        leftBtn.tag = 1000
        bgView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        leftBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        
        bgView.addSubview(searchTextField)
        searchTextField.placeholder = "请输入影片名称"
        searchTextField.backgroundColor = RGBA(195, G: 39, B: 48, A: 1)
        let searImageView = UIImageView.init(image: UIImage.init(named: "searchImage"))
        searImageView.frame = CGRect(x: 5, y: 0, width: 30, height: 30)
        
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0,width: 35, height: 30)
        leftView.addSubview(searImageView)
        
        searchTextField.font = UIFont.systemFont(ofSize: 14)
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = UITextFieldViewMode.unlessEditing
        searchTextField.layer.cornerRadius = 5
        
        searchTextField.textColor = UIColor.white
        searchTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        
        let searchBtn = UIButton.init(type: UIButtonType.custom)
        bgView.addSubview(searchBtn)
        searchBtn.tag = 1001
        searchBtn.backgroundColor = UIColor.clear
        searchBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        
        let rightBtn = UIButton.init(type: UIButtonType.custom)
        rightBtn.setImage(UIImage.init(named: "download"), for: UIControlState())
        rightBtn.tag = 1003
        bgView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        rightBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        let historyBtn = UIButton.init(type: UIButtonType.custom)
        historyBtn.setImage(UIImage.init(named: "history"), for: UIControlState())
        historyBtn.tag = 1002
        bgView.addSubview(historyBtn)
        historyBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.right.equalTo(rightBtn.snp.left).offset(-10)
            make.size.equalTo(CGSize(width: 32,height: 32))
        }
        historyBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.left.equalTo(leftBtn.snp.right).offset(10)
            make.right.equalTo(historyBtn.snp.left).offset(-10)
            make.height.equalTo(32)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.left.equalTo(leftBtn.snp.right).offset(10)
            make.right.equalTo(historyBtn.snp.left).offset(-10)
            make.height.equalTo(32)
        }


    }
    
    func btnClick(_ sender:UIButton)  {
        if sender.tag == 1001 {
            UIView.animate(withDuration: 0.3, animations: { 
                self.searchTextField.alpha = 0.8
                }, completion: { (Bool) in
                self.searchTextField.alpha = 1
            })
        }
        
        if sender.tag == 1000 {
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                print("--------shown )")
                DispatchQueue.main.async(execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        sender.transform=CGAffineTransform(rotationAngle: CGFloat(M_PI)/2.0);
                    })
                    self.viewWithTag(1001)?.isHidden = true
                    self.viewWithTag(1002)?.isHidden = true
                    self.viewWithTag(1003)?.isHidden = true
                    self.searchTextField.isHidden = true
                })
                
            }else
            {
                print("--------hidden ")
                DispatchQueue.main.async(execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        sender.transform=CGAffineTransform(rotationAngle: CGFloat(-M_PI)*2.0);
                    })
                    self.viewWithTag(1001)?.isHidden = false
                    self.viewWithTag(1002)?.isHidden = false
                    self.viewWithTag(1003)?.isHidden = false
                    self.searchTextField.isHidden = false
                })
                
            }
        }
        
        
        if (rootNavigateDelegate != nil)
        {
            rootNavigateDelegate.rootNavigationBtnClick(sender)
        }
        
    }
    
    func hiddenNavigationViewWithAnimation()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: -self.frame.height, width: SCREEN_WIDTH, height: self.frame.height)
        }) 
    }
    func showNavigationViewWithAnimation()
    {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.frame.height)
        }) 
    }
    
    func hiddenHeaderView() {
        self.viewWithTag(1001)?.isHidden = false
        self.viewWithTag(1002)?.isHidden = false
        self.viewWithTag(1003)?.isHidden = false
        self.searchTextField.isHidden = false
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
