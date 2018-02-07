//
//  SearchModel.swift
//  MovieProject
//
//  Created by Bert on 16/8/18.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    var title = String()
    var global_id  = String()
    var keyword  = String()
    
   
    init(Dictionary dic: [String : AnyObject]) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?,forUndefinedKey key: String)
    {
      
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
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
