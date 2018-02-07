//
//  HotMoviesViewController.swift
//  MovieProject
//
//  Created by Bert on 16/8/26.
//  Copyright © 2016年 Bert. All rights reserved.
//

//热播页
import UIKit
import Accelerate
class HotMoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NavigationCustomViewDelegate,UIGestureRecognizerDelegate{
    
    var tableView = UITableView()
    var dataArr  = NSMutableArray()
    //    var offsetTop:CGFloat = SCREEN_WIDTH*0.618
    var topHeadView = UIImageView()
    var detailModelArr:NSMutableArray?
    var blurView =  UIVisualEffectView()
    var navigationView = NavigationCustomView()
    var topModel:RecommendModel?
    
    
    struct MyConstant {
        static let constantA = "hello world"
        static var historyY:CGFloat = 0.0
        static  var offsetTop:CGFloat = SCREEN_WIDTH*0.618
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false//防止内容偏移
        self.view.backgroundColor = UIColor.white
        //自定义导航按钮
        tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(MyConstant.offsetTop, 0, 0, 0)
        let topImageView = UIImageView.init(frame: CGRect(x: 0, y: -MyConstant.offsetTop, width: SCREEN_WIDTH, height: MyConstant.offsetTop))
        tableView.insertSubview(topImageView, at: 0)
        topHeadView = topImageView
        
        topImageView.sd_setImage(with: URL.init(string: (topModel?.image)!))

        
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect(style: .light)
        //接着创建一个承载模糊效果的视图
        blurView = UIVisualEffectView(effect: blurEffect)
        //设置模糊视图的大小（全屏）
        blurView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        
        //创建并添加vibrancy视图
//        let vibrancyView = UIVisualEffectView(effect:
//            UIVibrancyEffect(forBlurEffect: blurEffect))
//        vibrancyView.frame.size = CGSize(width: topHeadView.frame.width, height: topHeadView.frame.height)
//        blurView.contentView.addSubview(vibrancyView)
        
        topHeadView.addSubview(blurView)
        //将文本标签添加到vibrancy视图中
        // let label=UILabel(frame:CGRectMake(10,20, 300, 100))
        //                label.text = "hangge.com"
        //                label.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        //                label.textAlignment = .Center
        //                label.textColor = UIColor.whiteColor()
        //vibrancyView.contentView.addSubview(label)
        
        navigationView = NavigationCustomView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64));
        navigationView.navigationDelegate = self
        self.view.addSubview(navigationView)
        
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        
        
    }
    //NavigationDelegate
    func btnAction(_ sender: UIButton) {
    
        if sender.tag == 1000 {
            // self.navigationController?.popViewController(animated: true)
            
            _ =  self.navigationController?.popViewController(animated: true)
            
        }else
        {
            
      
            let alerView = UIAlertController.init(title: "分享成功", message: nil, preferredStyle:UIAlertControllerStyle.alert)
            self.present(alerView, animated: true, completion: nil)
            
        }
    }
    
    //scrollViewdelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        MyConstant.offsetTop = MyConstant.offsetTop + abs(scrollView.contentOffset.y)/SCREEN_HEIGHT
        let down = -(MyConstant.offsetTop*0.5) - scrollView.contentOffset.y
        if down < 0  {
            return
        }
        var frame = self.topHeadView.frame
        frame.origin.y = -(MyConstant.offsetTop + down*0.6)
        frame.size.width = SCREEN_WIDTH + down*0.5
        frame.size.height = MyConstant.offsetTop + down*0.5
        self.topHeadView.frame = frame
        if down/MyConstant.offsetTop < 0.5 {
            DispatchQueue.main.async(execute: {
                self.blurView.alpha = 0.0//必须在主线程刷新否则不显示
                print("xxx",self.blurView.alpha,frame,MyConstant.offsetTop,down)

            })
            
        }else
        {
            DispatchQueue.main.async(execute: {
                self.blurView.alpha = down/MyConstant.offsetTop
                print("ccc",self.blurView.alpha)
            })
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (MyConstant.historyY + 20 < targetContentOffset.pointee.y)
        {
            navigationView.hiddenNavigationViewWithAnimation()
        }
        else if(MyConstant.historyY-20 > targetContentOffset.pointee.y)
        {
            navigationView.showNavigationViewWithAnimation()
        }
        MyConstant.historyY = targetContentOffset.pointee.y;
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.1, animations: {
            
            MyConstant.offsetTop = SCREEN_WIDTH*0.618
            
            print("end",MyConstant.offsetTop)
            
        }) 
        
    }
    
    //UITableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArr.count-1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120*0.618+20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let idefst = "reusecell"
        let  cell  = HotMoviesTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: idefst)
        let model:RecommendModel = dataArr[(indexPath as NSIndexPath).row] as! RecommendModel
        cell.setupHotMoviesModel(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--------index ",(indexPath as NSIndexPath).row)
        
//        let modelArr:NSMutableArray =  self.allDataArr[tableViewTag-TAG] as! NSMutableArray
//        let model:RecommendModel = modelArr[indexPath.row] as! RecommendModel
//        
//        let moviePlayerVC = MoviePlayViewController()
//        moviePlayerVC.detailModel = model
//        self.navigationController?.pushViewController(moviePlayerVC, animated: true)
    }
    
}
