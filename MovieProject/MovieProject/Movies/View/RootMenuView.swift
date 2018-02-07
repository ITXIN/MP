//
//  RootMenuView.swift
//  MovieProject
//
//  Created by Bert on 16/8/18.
//  Copyright © 2016年 Bert. All rights reserved.
//
/// 菜单视图
import UIKit
import SVProgressHUD
protocol RootMenuViewDelegate:NSObjectProtocol {
    func rootMenuBtnClick(_ sender:UIButton)
    
}
class RootMenuView: UIView,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var blurView:UIVisualEffectView?
    let iconBtn = UIButton.init(type: UIButtonType.custom)
    let loginBtn = UIButton.init(type: UIButtonType.custom)
    var menuDelegate:RootMenuViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .extraLight)
        //接着创建一个承载模糊效果的视图
        blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView!.frame.size = CGSize(width: frame.width, height: frame.height)
        
        //创建并添加vibrancy视图
        let vibrancyView = UIVisualEffectView(effect:
            UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.frame.size = CGSize(width:frame.width, height: frame.height)
        blurView!.contentView.addSubview(vibrancyView)
        blurView?.alpha = 1
        self.addSubview(blurView!)
        
        
        
        let topBgView = UIView()
        self.addSubview(topBgView)
        topBgView.backgroundColor = UIColor.white
        //        topBgView.alpha = 0.9
        topBgView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH,height: self.frame.height/2 - 30))
        }
        
        
        if let imageData =  UserDefaults.standard.object(forKey: USER_ICON_KEY)
        {
            let image = UIImage.init(data: imageData as! Data)
            iconBtn.setImage(image, for: UIControlState())
        }else
        {
            iconBtn.setImage(UIImage.init(named: "icon"), for: UIControlState())
        }
        
        iconBtn.backgroundColor = UIColor.lightGray
        
        iconBtn.tag = 1000
        iconBtn.layer.cornerRadius = 90/2
        iconBtn.layer.masksToBounds = true
        topBgView.addSubview(iconBtn)
        iconBtn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalTo(topBgView)
            make.size.equalTo(CGSize(width: 90,height: 90))
        }
        iconBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        let editIconBtn = UIButton()
        topBgView.addSubview(editIconBtn)
        editIconBtn.setTitle("编辑头像", for:  UIControlState())
        editIconBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
        editIconBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        editIconBtn.tag = 1001
        editIconBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(iconBtn.snp.bottom)
            make.left.equalTo(iconBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 90,height: 30))
        }
        editIconBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
        topBgView.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(self.btnlogInClick(_:)), for: UIControlEvents.touchUpInside)
        loginBtn.tag = 5000
        loginBtn.titleLabel?.textAlignment = NSTextAlignment.center
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        loginBtn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        loginBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        DispatchQueue.main.async(execute: {
            if (  UserDefaults.standard.object(forKey: USER_LOG_STATE_KEY) as? Bool == true)
            {
                self.loginBtn.setTitle("退出登录", for: UIControlState.normal)
            }else
            {
                self.loginBtn.setTitle("点击登录", for: UIControlState.normal)
            }
            
        })
      
//        loginBtn.textColor = UIColor.lightGray
//        loginBtn.font = UIFont.systemFont(ofSize: 14)
//        loginBtn.textAlignment = NSTextAlignment.center
//        loginBtn.text = "点击登录"
        loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(iconBtn.snp.bottom).offset(10)
            make.centerX.equalTo(topBgView)
            make.size.equalTo(CGSize(width: 90,height: 30))
        }
        
        
        
        let btnW:CGFloat = 80.0
        
        let leftMar:CGFloat = (SCREEN_WIDTH - 3*btnW)/6
        let titleArr = ["历史","收藏","缓存"]
        let imagNameArr = ["history_Menu","collect_Menu","donwload_Menu"]
        
        
        for i  in 0..<3
        {
            
            let rightBtn = UIButton.init(type: UIButtonType.custom)
            rightBtn.setImage(UIImage.init(named: imagNameArr[i]), for: UIControlState())
            rightBtn.tag = 2000 + i
            topBgView.addSubview(rightBtn)
            rightBtn.snp.makeConstraints { (make) in
                make.top.equalTo(loginBtn.snp.bottom).offset(10)
                make.left.equalTo(CGFloat(i)*btnW + CGFloat(2*i+1)*leftMar)
                make.size.equalTo(CGSize(width: btnW,height: btnW))
            }
            rightBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
            print("--------centex \(CGFloat(2*i+1)*leftMar)")
            
            rightBtn.setTitle(titleArr[i] as String, for: UIControlState())
            rightBtn.setTitleColor(UIColor.gray, for: UIControlState())
            rightBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
            rightBtn.imageEdgeInsets = UIEdgeInsetsMake(-btnW/2, btnW/4, 0,0)
            rightBtn.titleEdgeInsets = UIEdgeInsetsMake(btnW/2, -btnW/2+10, 0,0)
            
        }
        
        let  itemsArr = ["/ 热门榜单 /","/ 精选专题 /","/ 给我好评 /","设置"]
        for i  in 0..<itemsArr.count
        {
            
            let rightBtn = UIButton.init(type: UIButtonType.custom)
            rightBtn.tag = 3000 + i
            self.addSubview(rightBtn)
            rightBtn.snp.makeConstraints { (make) in
                make.top.equalTo(topBgView.snp.bottom).offset((i+1)*20+i*35)
                make.centerX.equalTo(self)
                make.size.equalTo(CGSize(width: 200,height: 35))
            }
            rightBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
            print("--------centex \(CGFloat(2*i+1)*leftMar)")
            
            rightBtn.setTitle(itemsArr[i] as String, for: UIControlState())
            rightBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
            rightBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
            
        }
        
        let hiddenBtn = UIButton.init(type: UIButtonType.custom)
        hiddenBtn.setImage(UIImage.init(named: "hidden_Menu"), for: UIControlState())
        hiddenBtn.tag = 4000
        self.addSubview(hiddenBtn)
        hiddenBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-10)
            make.size.equalTo(CGSize(width: 100,height: 32))
        }
        hiddenBtn.addTarget(self, action: #selector(self.btnClick), for: UIControlEvents.touchUpInside)
        
    }
    
    
    func btnClick(_ sender:UIButton)  {
        
        if (menuDelegate != nil)
        {
            if sender.tag == 1001 {
                self.choiceWayPhotograph()
            }
            menuDelegate.rootMenuBtnClick(sender)
        }
    }
    
    //退出/登录登录
    func btnlogInClick(_ sender:UIButton)  {

        
//        self.window?.addSubview(MPAlertHVD())
      
        DispatchQueue.main.async(execute: {
            if (  UserDefaults.standard.object(forKey: USER_LOG_STATE_KEY) as? Bool == true)
            {
                UserDefaults.standard.set(false, forKey: USER_LOG_STATE_KEY)
                UserDefaults.standard.synchronize()
                self.loginBtn.setTitle("退出登录", for: UIControlState.normal)
            }else
            {
                self.loginBtn.setTitle("点击登录", for: UIControlState.normal)
            }
            
        })
    }
    
    //选取获取照片方式
    func choiceWayPhotograph() {
        let alertController = UIAlertController.init(title: "获取图片", message:  nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            let takePhotoAction = UIAlertAction.init(title: "拍照", style:  UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.takePhotograph()
            })
            alertController.addAction(takePhotoAction)
        }
        
        
        let takeFromeMyPhotoAction = UIAlertAction.init(title: "从相册选择", style:  UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.takeFromePhotograph()
        })
        alertController.addAction(takeFromeMyPhotoAction)
        
        let cancelAction = UIAlertAction.init(title: "取消", style:  UIAlertActionStyle.cancel, handler: { (UIAlertAction) in
            
        })
        alertController.addAction(cancelAction)
  
        let rootVC = self.menuDelegate as! MovieRootViewController
        rootVC.present(alertController, animated: true, completion: nil)
    }
    
    
    /**
     打开摄像头
     */
    func takePhotograph() {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            let mediaTypeArr:NSArray = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.camera)! as NSArray
            print("--------mdietyparr \(mediaTypeArr)")
            
            if (mediaTypeArr.contains("public.image")) {
                print("--------yes image)")
                let  pickerControl:UIImagePickerController = UIImagePickerController()
                pickerControl.sourceType = UIImagePickerControllerSourceType.camera
                pickerControl.mediaTypes = mediaTypeArr as! [String]
                pickerControl.delegate = self
                pickerControl.allowsEditing = true
                let rootVC = self.menuDelegate as! MovieRootViewController
                rootVC.present(pickerControl, animated: true, completion: nil)
            }
        }
        
        
    }
    
    /**
     从相册获取
     */
    
    func takeFromePhotograph() {
        
        let  pickerControl:UIImagePickerController = UIImagePickerController()
        pickerControl.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerControl.delegate = self
        pickerControl.allowsEditing = true
        
        let rootVC = self.menuDelegate as! MovieRootViewController
        rootVC.present(pickerControl, animated: true, completion: nil)
    }
    
    
    //    UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("--------didFinishPickingImage ")
        
        //image  为编辑后
        if let infoDic =  editingInfo
        {
            let mediaType = infoDic["UIImagePickerControllerOriginalImage"] as! UIImage
            let imageData = UIImageJPEGRepresentation(image, 100)
            UserDefaults.standard.set(imageData, forKey: USER_ICON_KEY)
            UserDefaults.standard.synchronize()
            
            DispatchQueue.main.async(execute: {
                self.iconBtn.setImage(image, for: UIControlState())
                print("--------meidetype \(mediaType)")
            })
        }
        //保存到相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("--------imagePickerControllerDidCancel )")
        picker.dismiss(animated: true, completion: nil)
    }
    

    func showMentuView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame  = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
        }, completion: { (Bool) in
        }) 
    }
    
    func hiddenMenuView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: -(SCREEN_HEIGHT-64), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
        }, completion: { (Bool) in
            
        }) 
    }
    
    //登录成功退出更新 UI
    func updatUserView(_ isLogin:Bool) {
    
        DispatchQueue.main.async(execute: {
            if (isLogin == true)
            {
                if let imageData =  UserDefaults.standard.object(forKey: USER_ICON_KEY)
                {
                    let image = UIImage.init(data: imageData as! Data)
                    self.iconBtn.setImage(image, for: UIControlState())
                }else
                {
                    self.iconBtn.setImage(UIImage.init(named: "icon"), for: UIControlState())
                }
                
                
            }else
            {
                 self.iconBtn.setImage(UIImage.init(named: "icon"), for: UIControlState())
            }
            
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
