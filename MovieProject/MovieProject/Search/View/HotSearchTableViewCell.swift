//
//  HotSearchTableViewCell.swift
//  MovieProject
//
//  Created by Bert on 16/8/19.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

protocol HotSearchTableViewCellDelegate:NSObjectProtocol {
    func hotSearchBtnClick(_ sender:UIButton)
}

class HotSearchTableViewCell: UITableViewCell {
    
    var hotSearchDelegate:HotSearchTableViewCellDelegate!
    let btnW:NSInteger = NSInteger((SCREEN_WIDTH-20)/2)-20
    var mar:NSInteger  = 10
    
    
    var titleLab  = UILabel()//
    let clearBtn = UIButton.init(type: UIButtonType.custom)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mar = NSInteger(SCREEN_WIDTH/2)-btnW
        
        self.contentView.addSubview(titleLab)
        titleLab.textColor = UIColor.lightGray
        titleLab.font = UIFont.systemFont(ofSize: 13)
        titleLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)
        titleLab.text = "热门搜索"
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 100,height: 30))
        }
  
        self.contentView.addSubview(clearBtn)
        clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        clearBtn.setTitle("清除记录", for:  UIControlState())
        clearBtn.setTitleColor(RGBA(0, G: 0, B: 0, A: 0.7), for: UIControlState.highlighted)
        clearBtn.setTitleColor(UIColor.red, for: UIControlState())
        clearBtn.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 100,height: 30))
        }
        clearBtn.tag = 1111
        clearBtn.isHidden = true
        clearBtn.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControlEvents.touchUpInside)
    }
    
    
    
    func setupHotSearchModel(_ modelsArr:NSArray,isHistorySearch:Bool) {
        if isHistorySearch {
            titleLab.text = "搜索历史"
            clearBtn.isHidden = !isHistorySearch
        }else
        {
            titleLab.text = "热门搜索"
        }

        var row:NSInteger = 0//行
        var col = 2 //列
        
        if modelsArr.count%2 == 0 {
            row = modelsArr.count/2
            col = 2
        }else
        {
            row = modelsArr.count/2 + 1
        }

        /**
         *  此处有 bug 当不是偶数时报错
         */
        for i  in 0..<row
        {
            if i*2 + 2 > modelsArr.count {
                col = 1
            }
            
            for j in 0..<col {
                var  titleStr:String?
                if isHistorySearch {
//                    let dic  = (modelsArr[2*i+j] as AnyObject) as! NSDictionary
                    let dic  = modelsArr[2*i+j] as! NSDictionary
                    titleStr = dic[WORDS_SEARCH_HISTORY] as? String
                    
                   
                }else
                {
                    let hotSearchModel = modelsArr[2*i+j]
                    titleStr = (hotSearchModel as AnyObject).title
                }
                
                
                let keyBtn = UIButton.init(type: UIButtonType.custom)
                self.contentView.addSubview(keyBtn)
                keyBtn.titleLabel?.textAlignment = NSTextAlignment.left
//                keyBtn.backgroundColor = UIColor.cyanColor()
                keyBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
                keyBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
                
                keyBtn.setTitle(titleStr, for: UIControlState())
                keyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                keyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
                keyBtn.snp.makeConstraints { (make) in
                    make.top.equalTo((i+1)*37)
                    make.left.equalTo(10+j*(btnW+mar+10))
                    make.size.equalTo(CGSize(width: CGFloat(btnW),height: 30))
                }
                keyBtn.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControlEvents.touchUpInside)
                
            }
        }
    }
    
    
    func btnClick(_ sender:UIButton)  {
        print("-------hot search-sender \(sender.currentTitle)")
        if hotSearchDelegate != nil {
            self.hotSearchDelegate.hotSearchBtnClick(sender)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
