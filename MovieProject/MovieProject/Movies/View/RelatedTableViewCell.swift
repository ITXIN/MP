//
//  RelatedTableViewCell.swift
//  MovieProject
//
//  Created by Bert on 16/8/25.
//  Copyright © 2016年 Bert. All rights reserved.
//

import SnapKit

class RelatedTableViewCell: UITableViewCell {

//    var movieImageView:UIImageView = UIImageView()
//    var titleLab  = UILabel()//电影名

    var scrollerView = UIScrollView()
    
    let leftMar:CGFloat = 10.0
    let imageWidth:CGFloat = 100.0
    let scrollerHeight:CGFloat = 100.0
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(scrollerView)
        scrollerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 140)

    }
    
    func setupRelatedModelWithArr(_ modelArr:NSArray) {
        
        scrollerView.contentSize = CGSize(width: (imageWidth+leftMar)*CGFloat(modelArr.count),  height: 140)

        for index in 0..<modelArr.count {
            let  movieImageView = UIImageView()
            let titleLab = UILabel()
            let bgView = UIView()

            titleLab.font = UIFont.systemFont(ofSize: 13)
            titleLab.textColor = UIColor.lightGray
//            if ((modelArr[index] as AnyObject).isKind(of: RecommendModel())
              if((modelArr[index] as AnyObject).isKind(of: RecommendModel.classForCoder()))
            {
                let relateModel:RecommendModel = modelArr[index] as! RecommendModel
                let imagUrl = URL.init(string: relateModel.image as String)
                movieImageView.sd_setImage(with: imagUrl)
                titleLab.text = relateModel.title
            }else
            {
                let relateModel:RankModel = modelArr[index] as! RankModel
                let imagUrl = URL.init(string: relateModel.image as String)
                movieImageView.sd_setImage(with: imagUrl)
                titleLab.text = relateModel.title

            }
            
           

            self.scrollerView.addSubview(bgView)
            bgView.addSubview(movieImageView)
            bgView.addSubview(titleLab)
            bgView.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(0)
                make.left.equalTo((imageWidth+leftMar)*CGFloat(index))
                make.size.equalTo(CGSize(width: imageWidth, height: imageWidth+leftMar))
            }
            
            movieImageView.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(10)
                make.left.equalTo(leftMar)
                make.size.equalTo(CGSize(width: imageWidth, height: imageWidth*0.618))
            }
            
            titleLab.snp.makeConstraints { (make) in
                make.leftMargin.equalTo(movieImageView.snp.bottom).offset(10)
                make.left.equalTo(movieImageView.snp.left)
                make.size.equalTo(CGSize(width: imageWidth,height: 20))
            }
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
