//
//  SwiftRequestManager.swift
//  FGProject
//
//  Created by Bert on 16/8/22.
//  Copyright © 2016年 XL. All rights reserved.
//

import AFNetworking
class SwiftRequestManager: NSObject {

    fileprivate static var __once: () = {
            Inner.instance = SwiftRequestManager()
        }()

    //单例
    class var shared: SwiftRequestManager {
        _ = SwiftRequestManager.__once
        return Inner.instance!
    }
    
    //block
    typealias succeedHandlerBlock = (_ responseObject:AnyObject)->Void
    typealias failedHandlerBlock = (_ error: NSError)->Void
    
    struct Inner {
        static var instance: SwiftRequestManager?
        static var token: Int = 0
    }
    class func getDataWithUrlStr(_ urlStr: String, parameters parame: NSDictionary,succeedHandler: succeedHandlerBlock!, failedHandler: failedHandlerBlock!)
    {
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json") as? Set<String>
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>
        manager.get(urlStr as String, parameters:parame, progress: { (NSProgress) in
            
            }, success: { (NSURLSessionDataTask, AnyObject) in
                
                if ((AnyObject != nil))
                {
                    let responseDic = AnyObject as! NSDictionary
                    succeedHandler?(responseDic as AnyObject)
                }else
                {
                    print("返回为空")
                }
                
        }) { (NSURLSessionDataTask, NSError) in
          
         failedHandler?(NSError as NSError)
            
        }

    }
    
}
