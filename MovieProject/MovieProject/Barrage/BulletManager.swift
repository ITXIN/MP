//
//  BulletManager.swift
//  MovieProject
//
//  Created by Bert on 16/9/14.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
import Foundation
class BulletManager: NSObject {

    typealias GenerateViewBlock = (_ bulletView: BulletView)->Void //弹幕状态回调

    var generateViewBlock:GenerateViewBlock?
    
    lazy var dataSourceArr:NSMutableArray =
        {
            var arr:NSMutableArray =
                ["弹幕1 --434----",
                 "弹幕2 --54--",
                 "弹幕3 -54",
                 "弹幕4--54----",
                 "弹幕5 --343--",
                 "弹幕7 545-",
                 "弹幕1 --434----",
                 "弹幕2 --54--",
                 "弹幕3 -54",
                 "弹幕4--54----",
                 "弹幕5 --343--",
                 "弹幕7 545-"
                 ]
            return arr
    }()
   
    lazy var bulletCommnetsArr:NSMutableArray =
        {
            var arr = NSMutableArray()
            
            return arr
    }()
    
    
    lazy var bulletViewsArr:NSMutableArray =
        {
            var arr = NSMutableArray()
            return arr
    }()
    
    var isStopAnimation  = true
    
    override init() {
        super.init()
        
        self.isStopAnimation = true
        
    }
    
   
    func stop() {
        if isStopAnimation {
            return
        }

        self.isStopAnimation = true
        for view in self.bulletViewsArr {
            (view as! BulletView).stopAnimation()
//            (view as! BulletView).removeFromSuperview()
        }
        self.bulletViewsArr.removeAllObjects()
        
    }
    
    func start() {
        if isStopAnimation == false {
            return
        }
        self.isStopAnimation = false
        
        self.bulletCommnetsArr.removeAllObjects()
        self.bulletCommnetsArr.addObjects(from: [Any](self.dataSourceArr))
        self.initBulleComment()
    }
    
    func initBulleComment() {
        let  trajectorys:NSMutableArray = ["1","2","3"]
        
        for _  in 0..<3 {
            if self.bulletCommnetsArr.count > 0 {
                let index  = NSInteger( arc4random())%NSInteger(trajectorys.count)
                let trajectory = NSInteger((trajectorys.object(at: index) as! NSString) as String)
                trajectorys.removeObject(at: index)
                
                let comment = self.bulletCommnetsArr.firstObject
                self.bulletCommnetsArr.removeObject(at: 0)
                self.createBulletView(comment as! NSString, trajectory: trajectory!)
                
            }
            
        }
        
    }
    
    func createBulletView(_ comment:NSString , trajectory:NSInteger) {
        if isStopAnimation {
            return
        }
        
        let bulletView = BulletView.init(comment: comment as String)
        bulletView.trajector = trajectory
        self.bulletViewsArr.add(bulletView)
        
        bulletView.moveStatusBlcok = {(_ movestatus: MoveStatus)in
            
            if self.isStopAnimation {
                return
            }
            switch movestatus {
            case MoveStatus.Start:
                self.bulletViewsArr.add(bulletView)
                
                break
            case MoveStatus.Enter:
                let nextCommets  = self.nextComment()
                if comment.length > 0 {
                    self.createBulletView(nextCommets, trajectory: trajectory)
                }
                
                break
            case MoveStatus.End:
                if self.bulletViewsArr.contains(bulletView) {
                    bulletView.stopAnimation()
                    self.bulletViewsArr.remove(bulletView)
                }
                
                if self.bulletViewsArr.count == 0 {
                    self.isStopAnimation = true
                    self.start()
                }
                
                break
           
                
            }
            
        }
        if self.generateViewBlock != nil  {
            generateViewBlock!(bulletView)
        }
    }
    
    func nextComment()->NSString {
        if self.bulletCommnetsArr.count == 0 {
            return ""
        }
        
        let commnet = self.bulletCommnetsArr.firstObject
        if (commnet != nil) {
            self.bulletCommnetsArr.removeObject(at: 0)
        }
        return commnet as! NSString
        
        
    }
    
    
}
