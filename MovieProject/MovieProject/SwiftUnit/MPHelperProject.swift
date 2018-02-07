//
//  MPHelperProject.swift
//  MovieProject
//
//  Created by Bert on 16/8/24.
//  Copyright © 2016年 Bert. All rights reserved.
//


import UIKit
class MPHelperProject: NSObject {

    class func getSizeWithStr(_ str: String, fontSize: CGFloat, constraintWidth: CGFloat, constraintHeight: CGFloat)->CGSize
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let contraint = CGSize(width: constraintWidth, height: constraintHeight)
        let attibutes = [NSFontAttributeName:font]
        let rect = NSString(string:str).boundingRect(with: contraint, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attibutes, context: nil)
        return CGSize(width: rect.size.width+5, height: rect.size.height)
    }
    
}
