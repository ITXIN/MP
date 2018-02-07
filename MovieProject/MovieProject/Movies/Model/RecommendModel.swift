//
//  RecommendModel.swift
//  FGProject
//
//  Created by Bert on 16/8/22.
//  Copyright © 2016年 XL. All rights reserved.
//

import UIKit
/// 推荐 modle
class RecommendModel: NSObject {
    var title = String()
    var tags  = String()
    var play_count  = String()
    var category_id  = String()
    var image  = String()
    var mark  = String()
    var label  = String()
    var sub_title  = String()
    var id   = String()
    var source  = String()
    var Description  = String()
    var rec_type = String()
    var content_type  = String()
    var videos  = NSArray()
    var is_rec  = NSString()
    var category_name = String()
    
    
    init(Dictionary dic: [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?,forUndefinedKey key: String)
    {
//        if (key == "id") {
//            self.setValue(value, forUndefinedKey: "ID")
//        }
//        if (key == "description") {
//            self.setValue(value, forUndefinedKey: "Description")
//        }
//        
    }
        
    override func setValue(_ value: Any?, forKey key: String) {
        
        if (key == "description") {
            self.setValue(value, forUndefinedKey: "Description")
        }
        
        if( value is NSNumber)
        {
            let str = String(describing: value)
             super.setValue(str, forKey: key)
        }else
        {
             super.setValue(value, forKey: key)
        }
       
    }

   
}
