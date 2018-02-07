//
//  APPFile.swift
//  MovieProject
//
//  Created by Bert on 16/8/23.
//  Copyright © 2016年 Bert. All rights reserved.
//

import Foundation
import SDWebImage
import MJRefresh
import AFNetworking
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
func RGBA(_ R:CGFloat/*红*/, G:CGFloat/*绿*/, B:CGFloat/*蓝*/, A:CGFloat/*透明*/)->UIColor {
   return UIColor(red: R/255.0, green: G/255.0, blue: B/255.0, alpha: A)
}
//字体
let MIN_MENU_FONT:CGFloat = 13.0
let  MAX_MENU_FONT:CGFloat = 15.0


//搜索历史
let TIMESTAMP_SEARCH_HISTORY = "TIMESTAMP_SEARCH_HISTORY"
let WORDS_SEARCH_HISTORY = "WORDS_SEARCH_HISTORY"
let SEARCH_HISTORY_KEY = "SEARCH_HISTORY_KEY"

//用户头像
let USER_ICON_KEY = "USER_ICON_KEY"

//用户登录成功
let USER_LOG_IN_KEY = "USER_LOG_IN_KEY"

let USER_LOG_OUT_KEY = "USER_LOG_OUT_KEY"

//登录成功和登录失败的通知
let USER_LOG_NOTIFICATION = "USER_LOG_NOTIFICATION"

let USER_LOG_STATE_KEY = "USER_LOG_STATE_KEY"


