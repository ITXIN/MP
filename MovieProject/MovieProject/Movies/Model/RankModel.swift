//
//  RankModel.swift
//  MovieProject
//
//  Created by Bert on 16/8/25.
//  Copyright © 2016年 Bert. All rights reserved.
//

//热搜
import UIKit
class RankModel: NSObject {

    var title = String()
    var tags  = String()
    var play_count  = String()
    var category_id  = String()
    var image  = String()
    var mark  = String()
    var label  = String()
    var sub_title  = String()
    var id   = String()
    var Description  = String()
    var videos  = NSArray()

//    "tags": "9.6分",
//    "play_count": "459.2万",
//    "videos": [],
//    "image": "http://i0.letvimg.com/lc04_sarrs/201604/21/17/20/c43c266b74be4277bc4363277cd001be.jpg",
//    "category_id": 2,
//    "mark": "9.6分",
//    "label": "电影",
//    "sub_title": "",
//    "id": "24759",
//    "title": "肖申克的救赎",
//    "source": "nets",
//    "description": "希望让人得到自由",
    
    init(Dictionary dic: [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?,forUndefinedKey key: String)
    {
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
