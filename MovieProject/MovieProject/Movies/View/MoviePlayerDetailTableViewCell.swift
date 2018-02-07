//
//  MoviePlayerDetailTableViewCell.swift
//  MovieProject
//
//  Created by Bert on 16/8/25.
//  Copyright © 2016年 Bert. All rights reserved.
//

import SnapKit

class MoviePlayerDetailTableViewCell: UITableViewCell {
    var recommentCountImageView:UIImageView = UIImageView()
    var recommentLab = UILabel()//评论个数
    
//    var category_nameLab = UILabel()//类别
//    var markLab = UILabel()//分数
    var descriptionLab = UILabel()//简介
    var titleLab  = UILabel()//电影名
//    var tagsLab = UILabel()//演员
//    var subTitleLab = UILabel()//副标题
    var showDesBtn = UIButton()//显示隐藏简介按钮
    let leftMar = 10
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(recommentCountImageView)
        self.contentView.addSubview(recommentLab)
        self.contentView.addSubview(descriptionLab)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(showDesBtn)
        
        
        //        movieImageView.backgroundColor = UIColor.redColor()
        //        markLab.backgroundColor = UIColor.purpleColor()
//                descriptionLab.backgroundColor = UIColor.greenColor()
        //        tagsLab.backgroundColor = UIColor.brownColor()
//                titleLab.backgroundColor = UIColor.redColor()
        //        subTitleLab.backgroundColor = UIColor.cyanColor()
        //        tagsLab.backgroundColor = UIColor.purpleColor()
        //
        
        recommentCountImageView.image = UIImage.init(named: "recommentCount")
        
        
//        showDesBtn.backgroundColor = UIColor.purpleColor()
        
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)

        showDesBtn.setImage(UIImage.init(named: "success.png"), for: UIControlState())
//        showDesBtn.setTitle("showDes", forState: UIControlState.Normal)
       
        descriptionLab.numberOfLines = 0
        descriptionLab.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLab.font = UIFont.systemFont(ofSize: 13)
        descriptionLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)
      
        let topHeight:CGFloat = 25.0
        recommentCountImageView.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(10)
            make.left.equalTo(leftMar)
            make.size.equalTo(CGSize(width: 25, height: topHeight))
        }
        recommentLab.snp.makeConstraints { (make) in
            make.left.equalTo(recommentCountImageView.snp.right).offset(10)
            make.centerY.equalTo(recommentCountImageView.snp.centerY).offset(-2)
            make.size.equalTo(CGSize(width: 100, height: topHeight))
        }

        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
        }
        showDesBtn.setImage(UIImage.init(named: "down"), for: UIControlState())
         showDesBtn.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
        }
        descriptionLab.isHidden = true
        descriptionLab.snp.makeConstraints { (make) in
            make.top.equalTo(showDesBtn.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 1))
        }

    }
    
    func setupDetailModel(_ model:RecommendModel,isShowDes:Bool) {

        titleLab.text = model.title
        recommentLab.text = "100"
        if isShowDes {
            let categoryName = model.Description as String
            let size = MPHelperProject.getSizeWithStr(categoryName, fontSize: 13, constraintWidth: SCREEN_WIDTH-CGFloat(2*leftMar), constraintHeight: 1000)
            print("--------size \(size)")

            descriptionLab.text = categoryName
            descriptionLab.isHidden = !isShowDes
            descriptionLab.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLab.snp.bottom).offset(10)
                make.left.equalTo(leftMar)
                make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: size.height+20))
            }
            showDesBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(descriptionLab.snp.bottom).offset(10)
                make.left.equalTo(leftMar)
                make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
            }
            showDesBtn.setImage(UIImage.init(named: "up"), for: UIControlState())

        }else
        {
            showDesBtn.setImage(UIImage.init(named: "down"), for: UIControlState())
            descriptionLab.isHidden = !isShowDes
            showDesBtn.snp.remakeConstraints { (make) in
                make.top.equalTo(titleLab.snp.bottom).offset(10)
                make.left.equalTo(10)
                make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
            }
            descriptionLab.snp.remakeConstraints { (make) in
                make.top.equalTo(showDesBtn.snp.bottom).offset(10)
                make.left.equalTo(10)
                make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 1))
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
