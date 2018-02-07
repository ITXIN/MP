//
//  SearchNavigationCustomView.swift
//  MovieProject
//
//  Created by Bert on 16/8/18.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
protocol SearchNavigationCustomViewDelegate:NSObjectProtocol {
    func searchNavigationCancelBtnClick(_ sender:UIButton)//取消按钮
    func searchNavigationTextFiled(_ keyWords:String) //搜索框
    
    
}
class SearchNavigationCustomView: UIView ,UITextFieldDelegate{

    let searchTextField = UITextField()
    var searchNavigationDelegate:SearchNavigationCustomViewDelegate!
    var currentKeyStr = NSString()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: frame.width, height: frame.height))
        }
        bgView.backgroundColor =  RGBA(220, G: 50, B: 55, A: 1)
        
        bgView.addSubview(searchTextField)
        searchTextField.placeholder = "请输入影片名,导演或演员"
        searchTextField.backgroundColor =  RGBA(195, G: 39, B: 48, A: 1)
        searchTextField.font = UIFont.systemFont(ofSize: 14)
        let searImageView = UIImageView.init(image: UIImage.init(named: "searchImage"))
        searImageView.frame = CGRect(x: 5, y: 0, width: 30, height: 30)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0,width: 35, height: 30)
        leftView.addSubview(searImageView)
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = UITextFieldViewMode.always
        searchTextField.clearButtonMode = UITextFieldViewMode.whileEditing

        
        searchTextField.layer.cornerRadius = 5
        searchTextField.textColor = UIColor.white
        searchTextField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        searchTextField.addTarget(self, action: #selector(self.textChange(_:)), for: UIControlEvents.editingChanged)
        searchTextField.tintColor = UIColor.white
        searchTextField.delegate = self
        searchTextField.textAlignment = NSTextAlignment.left
        
  
        let cancelBtn = UIButton.init(type: UIButtonType.custom)
        cancelBtn.setTitle("取消", for:  UIControlState())
        cancelBtn.tag = 1003
        cancelBtn.setTitleColor(UIColor.white, for: UIControlState())
        cancelBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        bgView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 50,height: 32))
        }
        cancelBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(8)
            make.left.equalTo(10)
            make.right.equalTo(cancelBtn.snp.left).offset(-10)
            make.height.equalTo(32)
        }

    }
    
    func btnClick(_ sender:UIButton)  {
        self.searchTextField.endEditing(true)
        if (searchNavigationDelegate != nil)
        {
            searchNavigationDelegate.searchNavigationCancelBtnClick(sender)
        }
    }
    
    func textChange(_ textField: UITextField) {
        print("--------textchang \(self.searchTextField.text) \(textField.text)")
        currentKeyStr = textField.text! as NSString
        if currentKeyStr.length == 0 {
            searchTextField.placeholder = "请输入影片名,导演或演员"
        }else
        {
            searchTextField.placeholder = ""
        }
        self.searchTextField.becomeFirstResponder()

        
        if (searchNavigationDelegate != nil)
        {
            searchNavigationDelegate.searchNavigationTextFiled(textField.text! as String)
        }
    }
    
    //UITextFiledDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("--------textFieldDidBeginEditing \(textField.text)")
       
        if currentKeyStr.length == 0 {
            searchTextField.placeholder = "请输入影片名,导演或演员"
        }else
        {
            searchTextField.placeholder = ""
        }
        self.searchTextField.becomeFirstResponder()


    }
//
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        print("--------textFieldDidEndEditing \(textField.text)")
//       
//    }
//    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        print("--------shouldChangeCharactersInRange \(string),\(self.searchTextField.text) \(range) \(textField.text)")
////        if range.length != 1 {
////            keyWords.appendString(string)
////        }else{
////            keyWords.deleteCharactersInRange(range)
////        }
////        searchTextField.text?.stringByReplacingCharactersInRange(0, withString: string)
//        keyWords.stringByReplacingCharactersInRange(range, withString: string)
//        
//        print("--------key \(keyWords.length) \(keyWords)")
//        if (searchNavigationDelegate != nil)
//        {
//            searchNavigationDelegate.searchNavigationTextFiled(keyWords as String)
//        }
//        return true
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
