//
//  BulletView.swift
//  MovieProject
//
//  Created by Bert on 16/9/14.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
import SnapKit
enum MoveStatus:NSInteger
{
    case Start,Enter,End
}

let  Padding:CGFloat = 10
let  IconWidth:CGFloat = 40
class BulletView: UIView {

    var trajector:NSInteger? //弹道
    lazy var lbCommentLab:UILabel =
        {
            let lab = UILabel()
            lab.textAlignment = NSTextAlignment.center
            lab.textColor = UIColor.white
            lab.font = UIFont.systemFont(ofSize: 14)
            return lab
    }()
    
    lazy var iconImageView:UIImageView =
        {
            let imageView = UIImageView()
            
            return imageView
    }()
    
    typealias MoveStatusBlcok = (_ movestatus: MoveStatus)->Void //弹幕状态回调
    var moveStatusBlcok:MoveStatusBlcok?
    
    convenience init(comment:String)
    {
        self.init()
  
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor.red
        let attrDic = [NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        let width = (comment as NSString).size(attributes: attrDic).width
        
        let width1 = CGFloat(width)+2*Padding+IconWidth
        self.bounds = CGRect(x: 0, y: 0, width: width1, height: 30)
        self.trajector = 0
       self.lbCommentLab.text = comment
        self.addSubview(self.lbCommentLab)
        lbCommentLab.frame = CGRect(x: Padding+IconWidth, y: 0, width: width, height: 30)
        
        self.addSubview(self.iconImageView)
        self.iconImageView.frame = CGRect(x: 0, y: -(IconWidth-30)/2, width: IconWidth, height: IconWidth)
        iconImageView.layer.cornerRadius = IconWidth/2
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.image = UIImage.init(named: "bullet")
        
    }
    
    func startAnimation()
    {
        let duration:CGFloat = 4.0
        let wholeWidth = SCREEN_WIDTH + self.bounds.width
        
        if self.moveStatusBlcok != nil {
            moveStatusBlcok?(MoveStatus.Start)
        }
       
        let speed = wholeWidth/duration
        let enterDuration = self.bounds.width/speed
        self.perform(#selector(self.enterScreen), with: nil, afterDelay: TimeInterval(enterDuration))
        
        var frame  = self.frame
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            frame.origin.x -= wholeWidth
            self.frame = frame
        }) { (Bool) in
            self.removeFromSuperview()
            if self.moveStatusBlcok != nil {
                self.moveStatusBlcok!(MoveStatus.End)
            }
        }
    }
    
    func enterScreen() {
        if self.moveStatusBlcok != nil {
            moveStatusBlcok!(MoveStatus.Enter)
        }
    }
    
    func stopAnimation() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.layer.removeAllAnimations()
        self.removeFromSuperview()
    }

}
