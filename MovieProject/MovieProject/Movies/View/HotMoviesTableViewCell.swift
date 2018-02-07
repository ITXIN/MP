//
//  HotMoviesTableViewCell.swift
//  MovieProject
//
//  Created by Bert on 16/8/30.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit
class HotMoviesTableViewCell: UITableViewCell {
    var movieImageView:UIImageView = UIImageView()
    var category_nameLab = UILabel()//类别
    var markLab = UILabel()//分数
    var descriptionLab = UILabel()//简介
    var titleLab  = UILabel()//电影名
    var tagsLab = UILabel()//演员
    var subTitleLab = UILabel()//副标题
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(movieImageView)
        self.movieImageView.addSubview(category_nameLab)
        self.contentView.addSubview(markLab)
        self.contentView.addSubview(descriptionLab)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(tagsLab)
        self.contentView.addSubview(subTitleLab)
        
        //        movieImageView.backgroundColor = UIColor.redColor()
        //        markLab.backgroundColor = UIColor.purpleColor()
        //        descriptionLab.backgroundColor = UIColor.greenColor()
        //        tagsLab.backgroundColor = UIColor.brownColor()
        //        titleLab.backgroundColor = UIColor.redColor()
        //        subTitleLab.backgroundColor = UIColor.cyanColor()
        //        tagsLab.backgroundColor = UIColor.purpleColor()
        //
        
        category_nameLab.textColor = UIColor.white
        category_nameLab.textAlignment = NSTextAlignment.center
        category_nameLab.font = UIFont.systemFont(ofSize: 13)
        category_nameLab.layer.cornerRadius = 5
        category_nameLab.backgroundColor = RGBA(0, G: 0, B: 0, A: 0.7)
        
        titleLab.font = UIFont.systemFont(ofSize: 15)
        titleLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)
        
        subTitleLab.font = UIFont.systemFont(ofSize: 14)
        subTitleLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)
        
        tagsLab.font = UIFont.systemFont(ofSize: 13)
        tagsLab.textColor = RGBA(0, G: 0, B: 0, A: 0.7)
        
        
        let leftMar = 10.0
        movieImageView.snp.makeConstraints { (make) in
            
            make.left.equalTo(leftMar)
            make.size.equalTo(CGSize(width: 120,height: 120*0.618))
        }
        
        category_nameLab.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: 100,height: 20))
        }
        
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(movieImageView)
            make.left.equalTo(movieImageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
        }
        
        subTitleLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom).offset(10)
            make.left.equalTo(titleLab.snp.left)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
        }
        
        tagsLab.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLab.snp.bottom).offset(10)
            make.left.equalTo(subTitleLab.snp.left)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar)-120,height: 20))
        }
        
    }
    
    func setupHotMoviesModel(_ model:RecommendModel) {
        let imagUrl = URL.init(string: model.image as String)
        movieImageView.sd_setImage(with: imagUrl, placeholderImage: UIImage.init(named: "success.png"))
        
        let categoryName = model.category_name as String
        let size = MPHelperProject.getSizeWithStr(categoryName, fontSize: 13, constraintWidth: 50, constraintHeight: 20)
        category_nameLab.text = categoryName
        category_nameLab.snp.updateConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: size.width,height: 20))
        }
        titleLab.text = model.title
        subTitleLab.text = model.sub_title
        tagsLab.text = model.tags
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
