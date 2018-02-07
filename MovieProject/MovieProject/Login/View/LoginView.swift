//
//  LoginView.swift
//  MovieProject
//
//  Created by Bert on 16/8/24.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

protocol LoginViewDelegate:NSObjectProtocol {
     func loginClick(_ sender:UIButton)
    
}
class LoginView: UIView,UITextFieldDelegate {
    
    let titleArr = ["微信","微博","QQ"]
    var searchTextField = UITextField()
    let nextBtn = UIButton.init(type: UIButtonType.custom)
    
    var loginDelegate:LoginViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTextFiled()
        self.setupNextBtn()
        self.setuBottomView()
    }
    
    func setupTextFiled() {
        searchTextField.placeholder = "请输入手机号登录"
        searchTextField.backgroundColor =  UIColor.white
        searchTextField.font = UIFont.systemFont(ofSize: 22)
        let searImageView = UIImageView.init(image: UIImage.init(named: "phone"))
        searImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0,width: 40, height: 30)
        leftView.addSubview(searImageView)
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = UITextFieldViewMode.always
        searchTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        searchTextField.keyboardType = UIKeyboardType.numberPad
        
        searchTextField.layer.cornerRadius = 5
        searchTextField.textColor = UIColor.lightGray
        searchTextField.setValue(UIColor.lightGray, forKeyPath: "_placeholderLabel.textColor")
        searchTextField.addTarget(self, action: #selector(self.textChange(_:)), for: UIControlEvents.editingChanged)
        //        searchTextField.tintColor = UIColor.whiteColor()
        searchTextField.delegate = self
        searchTextField.textAlignment = NSTextAlignment.left
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(190)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 250, height: 50))
            
        }
        
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.backgroundColor = UIColor.lightGray
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 250, height: 1))
        }
        
        
        
    }
    
    func setupNextBtn() {
        nextBtn.setTitle("下一步", for:  UIControlState())
        nextBtn.tag = 1003
        nextBtn.setTitleColor(UIColor.white, for: UIControlState())
        nextBtn.setTitleColor(UIColor.lightText, for: UIControlState.highlighted)
        nextBtn.backgroundColor = UIColor.lightGray
        nextBtn.layer.cornerRadius = 5.0
        self.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchTextField.snp.bottom).offset(35)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 250, height: 50))
        }
        nextBtn.addTarget(self, action: #selector(self.nextBtnClick(_:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func setuBottomView() {
        
        let bottomView = UIView()
        //bottomView.backgroundColor = UIColor.yellowColor()
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 200))
        }
        
        let titleView = UIView()
        bottomView.addSubview(titleView)
//        titleView.backgroundColor = UIColor.yellowColor()
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH, height: 200-SCREEN_WIDTH/3))
        }
        
        let titleLab = UILabel()
        titleView.addSubview(titleLab)
        titleLab.text = "第三方登录"
        titleLab.textColor = UIColor.lightGray
        titleLab.textAlignment = NSTextAlignment.center
        titleLab.snp.makeConstraints { (make) in
            make.center.equalTo(titleView)
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: 120, height: 30))
        }

        let leftLineView = UIView()
        titleView.addSubview(leftLineView)
        leftLineView.backgroundColor = UIColor.lightGray
        leftLineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleView)
            make.left.equalTo(10)
            make.right.equalTo(titleLab.snp.left).offset(0)
            make.height.equalTo(1)
        }
        let rightLineView = UIView()
        titleView.addSubview(rightLineView)
        rightLineView.backgroundColor = UIColor.lightGray
        rightLineView.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleView)
            make.right.equalTo(-10)
            make.left.equalTo(titleLab.snp.right).offset(0)
            make.height.equalTo(1)
        }
        
        
        
        let btnW:CGFloat = SCREEN_WIDTH/3
        
        
        let imagNameArr = ["weixin","weibo","qq"]
        
        for i  in 0..<titleArr.count
        {
            
            let rightBtn = UIButton.init(type: UIButtonType.custom)
            rightBtn.setImage(UIImage.init(named: imagNameArr[i]), for: UIControlState())
            rightBtn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            rightBtn.tag = 2000 + i
            bottomView.addSubview(rightBtn)
            rightBtn.snp.makeConstraints { (make) in
                make.bottom.equalTo(0)
                make.left.equalTo(CGFloat(i)*btnW)
                make.size.equalTo(CGSize(width: btnW,height: btnW))
            }
            rightBtn.setTitle(titleArr[i] as String, for: UIControlState())
            rightBtn.setTitleColor(UIColor.gray, for: UIControlState())
            rightBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
            rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-btnW/2, btnW/4, 0,0)
            rightBtn.titleEdgeInsets = UIEdgeInsetsMake(btnW/2, -btnW/2+15, 0,0)
            rightBtn.addTarget(self, action:#selector(self.loginAction(_:)), for: UIControlEvents.touchUpInside)
        }
        
    }
    
    //
    func loginAction(_ sender:UIButton) {
        
        if (loginDelegate != nil) {
            
            loginDelegate?.loginClick(sender)
           
        }
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchTextField.resignFirstResponder()
    }
    
    
    //
    func nextBtnClick(_ sender:UIButton) {
        print("--------nextBtnClick )")
        
    }
    
    
    func textChange(_ textField: UITextField) {
        //        print("--------textchang \(self.searchTextField.text) \(textField.text)")
    }
    
    //UITextFiledDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tempStr:NSString =  NSString(string: textField.text!)
        let toBeStr = tempStr.replacingCharacters(in: range, with:string) as String
        if toBeStr.characters.count > 11 && range.length != 1
        {
            textField.text = (toBeStr as NSString).substring(to: 11)
            self.nextBtn.backgroundColor = RGBA(220, G: 50, B: 55, A: 1)
            self.nextBtn.isUserInteractionEnabled = true
            return false
        }
        self.nextBtn.backgroundColor = UIColor.lightGray
        self.nextBtn.isUserInteractionEnabled = false
        return true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
