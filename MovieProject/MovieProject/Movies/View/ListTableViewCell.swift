//
//  ListTableViewCell.swift
//  FGProject
//
//  Created by Bert on 16/8/23.
//  Copyright © 2016年 XL. All rights reserved.
//

//import Cocoa
import SnapKit
//import SDWebImage
protocol ListTableViewCellDelegate:NSObjectProtocol {
    func listBtnClick(_ sender:UIButton)
    
}
class ListTableViewCell: UITableViewCell {

    var movieImageView:UIImageView = UIImageView()
    var category_nameLab = UILabel()//类别
    var markLab = UILabel()//分数
    var descriptionLab = UILabel()//简介
    var titleLab  = UILabel()//电影名
    var tagsLab = UILabel()//演员
    var subTitleLab = UILabel()//副标题
    var collectionBtn = UIButton.init(type: UIButtonType.custom)
    var shareBtn = UIButton.init(type: UIButtonType.custom)
    var dontLikeBtn = UIButton.init(type: UIButtonType.custom)
    
    var listCellDelegate:ListTableViewCellDelegate!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        movieImageView = UIImageView.init()
        self.contentView.addSubview(movieImageView)
        self.movieImageView.addSubview(category_nameLab)
        self.contentView.addSubview(markLab)
        self.contentView.addSubview(descriptionLab)
        self.contentView.addSubview(titleLab)
        self.contentView.addSubview(tagsLab)
        self.contentView.addSubview(subTitleLab)
        self.contentView.addSubview(collectionBtn)
        self.contentView.addSubview(shareBtn)
        self.contentView.addSubview(dontLikeBtn)
        
        
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
        


        collectionBtn.setImage(UIImage.init(named: "collect_Menu"), for: UIControlState())
        shareBtn.setImage(UIImage.init(named: "inCellShare"), for: UIControlState())
        dontLikeBtn.setImage(UIImage.init(named: "dontLike"), for: UIControlState())
        collectionBtn.tag = 1000
        shareBtn.tag = 1001
        dontLikeBtn.tag = 1002
        
        collectionBtn.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControlEvents.touchUpInside)
        shareBtn.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControlEvents.touchUpInside)
        dontLikeBtn.addTarget(self, action: #selector(self.btnClick(_:)), for: UIControlEvents.touchUpInside)
       self.setupContrainsts()
       
        
    }
    
    func btnClick(_ sender:UIButton) {
        
        if listCellDelegate != nil {
            listCellDelegate.listBtnClick(sender)
        }
    }
    
    func setupContrainsts() {
        let leftMar = 10.0

        movieImageView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: (SCREEN_WIDTH-CGFloat(2*leftMar))*0.618))
        }
        
       
        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(movieImageView.snp.bottom).offset(10)
            make.left.equalTo(movieImageView.snp.left)
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
            make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
        }
        
        collectionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(tagsLab.snp.bottom).offset(10)
            make.left.equalTo(subTitleLab.snp.left)
            make.size.equalTo(CGSize(width: 20,height: 20))
        }
        shareBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionBtn.snp.centerY)
            make.left.equalTo(collectionBtn.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 20,height: 20))
        }
        dontLikeBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(shareBtn.snp.centerY)
            make.right.equalTo(-leftMar)
            make.size.equalTo(CGSize(width: 40,height: 40))
        }
        
        
        
    }
    
    
    func setupRecommentModel(_ model:RecommendModel) {
        let imagUrl = URL.init(string: model.image)
        movieImageView.sd_setImage(with: imagUrl, placeholderImage: UIImage.init(named: "success.png"))
      
        
        let categoryName = model.category_name as String
        let size = MPHelperProject.getSizeWithStr(categoryName, fontSize: 13, constraintWidth: 50, constraintHeight: 20)
        category_nameLab.text = categoryName
        
        category_nameLab.snp.updateConstraints({ (make) in
            
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: size.width,height: 20))
            
        })
        
        if model.sub_title.characters.count == 0 {
             let leftMar = 10.0
            
            tagsLab.snp.removeConstraints()
            collectionBtn.snp.removeConstraints()
            shareBtn.snp.removeConstraints()
            dontLikeBtn.snp.removeConstraints()
            
            tagsLab.snp.updateConstraints { (make) in
                make.top.equalTo(titleLab.snp.bottom).offset(10)
                make.left.equalTo(titleLab.snp.left)
                make.size.equalTo(CGSize(width: SCREEN_WIDTH-CGFloat(2*leftMar),height: 20))
            }
            
            collectionBtn.snp.updateConstraints { (make) in
                make.top.equalTo(tagsLab.snp.bottom).offset(10)
                make.left.equalTo(titleLab.snp.left)
                make.size.equalTo(CGSize(width: 20,height: 20))
            }
            shareBtn.snp.updateConstraints { (make) in
                make.centerY.equalTo(collectionBtn.snp.centerY)
                make.left.equalTo(collectionBtn.snp.right).offset(10)
                make.size.equalTo(CGSize(width: 20,height: 20))
            }
            dontLikeBtn.snp.updateConstraints { (make) in
                make.centerY.equalTo(shareBtn.snp.centerY)
                make.right.equalTo(-leftMar)
                make.size.equalTo(CGSize(width: 40,height: 40))
            }
            
        }
        
        
        titleLab.text = model.title
        subTitleLab.text = model.sub_title
        tagsLab.text = model.tags
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
