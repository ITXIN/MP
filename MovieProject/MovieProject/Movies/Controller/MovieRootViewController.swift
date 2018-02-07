//
//  MovieRootViewController.swift
//  FGProject
//
//  Created by Bert on 16/8/22.
//  Copyright © 2016年 XL. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD
let TAG:NSInteger = 1000
import Accelerate
class MovieRootViewController: UIViewController,
    UITableViewDelegate,UITableViewDataSource,
    RootNavigationCustomViewDelegate,
    RootMenuViewDelegate ,
    ScrollPageViewDelegate,
    ListTableViewCellDelegate
{
    var tableView = UITableView()
    var indexTag:NSInteger = 0
    
    var tableViewTag:NSInteger = TAG
    //    var allDataArr = NSMutableArray()
    
    var allDataDic = NSMutableDictionary()
    
    var categoryHeight:CGFloat = 44.0
    var currentCell:ListTableViewCell?
    
    var rootNavigationView = RootNavigationCustomView.init(frame: CGRect(x: 0, y: 0,width: SCREEN_WIDTH, height: 64))
    var menuView:RootMenuView?
    lazy var shadowView:UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0,width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        view.alpha = 0.8
        view.backgroundColor = UIColor.black
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(self.hiddenShodwViewAndDontLikeView))
        view.addGestureRecognizer(tapGR)
        
        
        return view
    }()
    var dontLikeView:DontLikeView?
    
    
    
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
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false//防止内容偏移
        
        
        let titleArr = ["推荐","电影","电视剧","动漫","综艺","纪录片","直播"]
        //        self.allDataArr = NSMutableArray.init(capacity: titleArr.count)
        
        self.allDataDic = NSMutableDictionary()
        
        self.addChildVcs(titleArr.count)
        var style = SegmentStyle()
        // 缩放文字
        style.scaleTitle = true
        // 颜色渐变
        style.gradualChangeTitleColor = true
        // 显示滚动条
        style.showLine = true
        // 天使遮盖
        style.showCover = true
        // segment可以滚动
        style.scrollTitle = true
        
        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titleArr, childVcs: childViewControllers)
        view.addSubview(scroll)
        scroll.scrollPageDelegate = self
        
        indexTag = NSInteger(arc4random()%4)
        
        self.menuView = RootMenuView.init(frame: CGRect(x: 0, y: -(SCREEN_HEIGHT-64), width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64))
        self.menuView?.menuDelegate = self
        self.view.addSubview(self.menuView!)
        
        rootNavigationView.rootNavigateDelegate = self
        self.view.addSubview(rootNavigationView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginNotification(_:)), name: NSNotification.Name(rawValue: USER_LOG_NOTIFICATION), object: nil)
        
        
    }
    
    func addChildVcs(_ count:NSInteger) {
        for i in 0..<7
        {
            let childVC = UIViewController()
            childVC.view.backgroundColor = UIColor.white
            childVC.navigationController?.isNavigationBarHidden = true
            childVC.view.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64)
            addChildViewController(childVC)
            
            let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-categoryHeight), style: UITableViewStyle.plain)
            
            tableView.tag = TAG + i
            childVC.view.addSubview(tableView)
            // 顶部刷新
            let header = MJRefreshNormalHeader()
            // 底部刷新
            let footer = MJRefreshAutoNormalFooter()
            header.setRefreshingTarget(self, refreshingAction: #selector(MovieRootViewController.headerRefresh))
            // 现在的版本要用mj_header
            tableView.mj_header = header
            
            // 上拉刷新
            footer.setRefreshingTarget(self, refreshingAction: #selector(MovieRootViewController.footerRefresh))
            tableView.mj_footer = footer
            
            tableView.delegate = self
            tableView.dataSource = self
        }
        self.requestData(TAG,offset: 0)
    }
    
    
    //显示遮罩效果与点击操作
    func showShodowViewAndDontLikeView(_ topY:CGFloat) {
        self.view.insertSubview(self.shadowView, aboveSubview: self.view.superview!)
        let tempView = DontLikeView.init(frame: CGRect(x: 0, y: topY, width: SCREEN_WIDTH, height: 42))
        self.dontLikeView = tempView
        tempView.dontLikeBtn.addTarget(self, action: #selector(self.dontLikeViewBtnClick(_:)), for: UIControlEvents.touchUpInside)
        self.view.insertSubview(tempView, aboveSubview: self.view.superview!)
    }
    
    //关闭遮罩
    func hiddenShodwViewAndDontLikeView() {
        self.shadowView.removeFromSuperview()
        self.dontLikeView?.removeFromSuperview()
    }
    //不喜欢
    func dontLikeViewBtnClick(_ sender:UIButton) {
        //        let modelArr:NSMutableArray =  self.allDataArr[tableViewTag-TAG] as! NSMutableArray
        
        
        let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
        
        let indexPath = self.tableView.indexPath(for: currentCell!)
        modelArr.removeObject(at: (indexPath! as NSIndexPath).row)
        self.tableView.deleteRows(at: NSArray.init(object: indexPath!) as! [IndexPath], with: UITableViewRowAnimation.fade)
        self.hiddenShodwViewAndDontLikeView()
        return
    }
    
    //监听登录登出
    func loginNotification(_ notification:NSNotification)
    {
        print("--------监听登录 )")
        let isLogIn = UserDefaults.standard.object(forKey: USER_LOG_STATE_KEY) as! Bool
        if isLogIn == true {
            //更新 UI
            if let imageData =  UserDefaults.standard.object(forKey: USER_ICON_KEY)
            {
                let image = UIImage.init(data: imageData as! Data)
                self.menuView?.iconBtn.setImage(image, for: UIControlState())
            }
            
            self.menuView?.loginBtn.setTitle("点击退出", for: UIControlState.normal)
            
        }else
        
        {
            self.menuView?.loginBtn.setTitle("点击登录", for: UIControlState.normal)
        }
        
        
        
    }
    
    //判断是否为空
    func isDataDicNull(_ key:String) -> Bool {
        if self.allDataDic.object(forKey: key) != nil {
            return false
        }else
        {
            return true
        }
    }
    
    
    // MARK:
    // MARK: scrollPageDelegate
    func currentIndex(_ currentIndex:NSInteger)
    {
        print("--------yyyy \(currentIndex)")
        tableViewTag = NSInteger(currentIndex + TAG)
        if self.allDataDic.allKeys.count > tableViewTag - TAG
        {
            if (self.isDataDicNull(String(tableViewTag-TAG)) == false)
            {
                let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
                if modelArr.count == 0 {
                    self.requestData(tableViewTag,offset: 0)
                }
                
            }else
            {
                self.requestData(tableViewTag,offset: 0)
            }
            
        }else
        {
            self.requestData(tableViewTag,offset: 0)
        }
    }
    
    //rootNavigateDelegate
    func rootNavigationBtnClick(_ sender: UIButton) {
        print("--------rootNavigationBtnClick ",sender.tag)
        switch sender.tag {
        case 1000:
            print("--------rootNavigationBtnClick menu")
            if sender.isSelected {
                print("--------shown )")
                self.menuView!.showMentuView()
            }else
            {
                print("--------hidden ")
                self.menuView!.hiddenMenuView()
            }
            
        case 1001:
            print("--------rootNavigationBtnClick search")
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        case 1002:
            print("--------rootNavigationBtnClick history")
        case 1003:
            print("--------rootNavigationBtnClick download")
            
        default:
            print("--------rootNavigationBtnClick default")
        }
    }
    
    /// menuDelegate
    func rootMenuBtnClick(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            print("--------rootMenuBtnClick icon login")
            self.present(LoginViewController(), animated: true, completion: {
            })
        case 1001:
            print("--------rootMenuBtnClick edite icon ")
        case 2000:
            print("--------rootMenuBtnClick history")
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
            
        case 2001:
            print("--------rootMenuBtnClick collect")
            self.present(LoginViewController(), animated: true, completion: {
            })
        case 2002:
            print("--------rootMenuBtnClick download")
            
        case 3000:
            print("--------rootMenuBtnClick 热门")
        case 3001:
            print("--------rootMenuBtnClick 精选")
        case 3002:
            print("--------rootMenuBtnClick 给我好评")
        case 3003:
            print("--------rootMenuBtnClick 设置 ")
            
        case 4000:
            print("--------rootMenuBtnClick 隐藏 ")
            self.menuView!.hiddenMenuView()
            DispatchQueue.main.async(execute: {
                UIView.animate(withDuration: 0.5, animations: {
                    let btn = self.rootNavigationView.viewWithTag(1000) as! UIButton
                    btn.isSelected = !btn.isSelected
                    btn.transform=CGAffineTransform(rotationAngle: CGFloat(-M_PI)*2.0);
                })
                self.rootNavigationView.hiddenHeaderView()
            })
        default:
            print("--------rootMenuBtnClick error")
            
        }
    }
    
    /**
     ListTableViewCellDelegate
     */
    func listBtnClick(_ sender: UIButton) {
        switch sender.tag {
        case 1000:
            print("--------listBtnClick 收藏 ")
            self.present(LoginViewController(), animated: true, completion: {
            })
        case 1001:
            print("--------listBtnClick 分享 ")
        case 1002:
            print("--------listBtnClick 不喜欢")
            
            let superView = sender.superview
            let cellSuperView = superView?.superview
            let cell = (cellSuperView) as! ListTableViewCell
            currentCell = cell
            let rectInSuperview = sender.convert(sender.frame , from: cell)
            let rect2 = sender.convert(rectInSuperview, to: self.tableView.superview)
            self.showShodowViewAndDontLikeView(rect2.minY+114-42-20)
            
            
        default:
            print("--------listBtnClick error")
        }
    }
    
    /**
     请求数据
     - parameter tableViewTag:
     - parameter offset:
     */
    func requestData(_ tableViewTag:NSInteger,offset:NSInteger) {
        let url = "http://rec.chaojishipin.com/sarrs/rec"
        let params = [
            "app_id": "732",
            "appfrom": "appstore",
            "appv": "1.3.1",
            "area":"rec_0703",
            "auid":"10c89e410fc9f3ece250b84baf983e09ce8351eb",
            "lc":"10c89e410fc9f3ece250b84baf983e09ce8351eb",//关键参数
            "cid": String(tableViewTag-TAG >= 5 ? NSInteger(arc4random()%4):tableViewTag-TAG),//关键参数
        ]
        
        
        SwiftRequestManager.getDataWithUrlStr(url,parameters:NSDictionary.init(dictionary:  NSDictionary.init(dictionary: params as NSDictionary) ), succeedHandler: { (responseObject) in
            
            let dic =  (responseObject as! NSDictionary)
            let itemsArr = dic["items"] as? NSArray
            var modelArr:NSMutableArray = NSMutableArray()
            if self.allDataDic.allValues.count > tableViewTag - TAG
            {
                //              modelArr = self.allDataArr[tableViewTag-TAG] as! NSMutableArray
                
                if (self.isDataDicNull(String(tableViewTag-TAG)) == false)
                {
                    modelArr =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
                }
            }
            
            if offset == 0 {
                modelArr.removeAllObjects()
            }else
            {
                
            }
            
            for  dic in itemsArr!
            {
                let infoModel = RecommendModel(Dictionary: (dic as! NSDictionary) as! [String : AnyObject])
                modelArr.add(infoModel)
            }
            print(self.allDataDic.allValues.count, tableViewTag-TAG)
            //            if (self.allDataArr.count < tableViewTag - TAG)
            //            {
            //                for i in self.allDataArr.count..<tableViewTag - TAG
            //                {
            //                    print(i)
            //                    self.allDataArr.insert(NSNull(), at: i)
            //
            //                }
            //
            //
            //            }
            //            self.allDataArr.insert(modelArr, at: tableViewTag - TAG)
            self.allDataDic.setValue(modelArr, forKey: String(tableViewTag-TAG))
            
            let vc  = self.childViewControllers[tableViewTag-TAG]
            self.tableView = vc.view.viewWithTag(tableViewTag) as! UITableView
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
            
        }) { (error) in
            
            print("faile error: "+error.localizedDescription)
            let vc  = self.childViewControllers[tableViewTag-TAG]
            self.tableView = vc.view.viewWithTag(tableViewTag) as! UITableView
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_header.endRefreshing()
            self.tableView.reloadData()
        }
    }
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        // 结束刷新
        let vc  = self.childViewControllers[tableViewTag-TAG]
        self.tableView = vc.view.viewWithTag(tableViewTag) as! UITableView
        self.tableView.mj_header.endRefreshing()
        self.requestData(tableViewTag,offset: 0)
    }
    
    // 底部刷新
    var index = 0
    func footerRefresh(){
        print("上拉刷新")
        let vc  = self.childViewControllers[tableViewTag-TAG]
        self.tableView = vc.view.viewWithTag(tableViewTag) as! UITableView
        self.tableView.mj_footer.endRefreshing()
        self.requestData(tableViewTag,offset: 1)
    }
    
    //UITableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.allDataDic.allValues.count == 0 {
            return 1
        }
        
        if (self.isDataDicNull(String(tableViewTag-TAG)) == false)
        {
            let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
            if modelArr.count == 0 {
            }
            return modelArr.count
        }else
        {
            return 1
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if self.allDataDic.allValues.count == 0 {
            return 380
        }
        
        if (tableViewTag - TAG >= self.allDataDic.allValues.count)
        {
            return 380
        }
        //        let modelArr:NSMutableArray =  self.allDataArr[tableViewTag-TAG] as! NSMutableArray
        
        
        if (self.isDataDicNull(String(tableViewTag-TAG)) == false)
        {
            let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
            let model:RecommendModel = modelArr[(indexPath as NSIndexPath).row] as! RecommendModel
            if model.sub_title.characters.count == 0 {
                
                return 350
            }
            
        }
        
        return 380
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let idefst = "listreusecell"
        let  cell  = ListTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: idefst)
        
        if (self.isDataDicNull(String(tableViewTag-TAG)) == false)
        {
            let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
            let model:RecommendModel = modelArr[(indexPath as NSIndexPath).row] as! RecommendModel
            cell.setupRecommentModel(model)
            cell.listCellDelegate = self
            return cell
        }else
        {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let modelArr:NSMutableArray =  self.allDataArr[tableViewTag-TAG] as! NSMutableArray
        let modelArr:NSMutableArray =  self.allDataDic.object(forKey: String(tableViewTag-TAG)) as! NSMutableArray
        let model:RecommendModel = modelArr[(indexPath as NSIndexPath).row] as! RecommendModel
        
        let number = arc4random()%2
        //          let number = 1
        if number == 0 {
            let moviePlayerVC = HotMoviesViewController()
            moviePlayerVC.topModel  = model
            moviePlayerVC.dataArr = modelArr
            self.navigationController?.pushViewController(moviePlayerVC, animated: true)
        }else
        {
            let moviePlayerVC = MoviePlayViewController()
            moviePlayerVC.detailModel  = model
            self.navigationController?.pushViewController(moviePlayerVC, animated: true)
        }
    }
    
    
}
