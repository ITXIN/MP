//
//  MoviePlayViewController.swift
//  MovieProject
//
//  Created by Bert on 16/8/24.
//  Copyright © 2016年 Bert. All rights reserved.
//
// 播放页
import UIKit
import MediaPlayer
class MoviePlayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NavigationCustomViewDelegate,UIGestureRecognizerDelegate {

    var moviePlayerVC =  MPMoviePlayerViewController()
    
    
    var detailModel:RecommendModel?
    var tableView = UITableView()
    
    var detailModelArr = NSMutableArray()//详情信息
    var rankModelArr = NSMutableArray()//rank
    var hotRecModelArr = NSMutableArray()//hot_rec
    var relatedRecModelArr = NSMutableArray()//related_rec
    var commentModelArr = NSMutableArray()//recomment
    var isShowDes = false
    var navigationView = NavigationCustomView()
    let manage = BulletManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.setuNavigationView()
        print("--------viewWillAppear )")

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //        DispatchQueue.main.async {
//        self.navigationController?.isNavigationBarHidden = true
//        self.setuNavigationView()
        print("--------viewWillDisappear )")
        
        //        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false//防止内容偏移
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(moviePlayerVC.view)

        moviePlayerVC.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 300)
        moviePlayerVC.view.frame = CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: 300)
        moviePlayerVC.moviePlayer.controlStyle = MPMovieControlStyle.default
        moviePlayerVC.moviePlayer.scalingMode = MPMovieScalingMode.aspectFill
        
        
        //设置 url http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0
        moviePlayerVC.moviePlayer.contentURL = URL.init(string: "http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0")//不知道接口
        moviePlayerVC.moviePlayer.shouldAutoplay = true
        moviePlayerVC.moviePlayer.prepareToPlay()

        
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 365, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 364), style: UITableViewStyle.plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)

//        setuNavigationView()
        
        
        self.detailModelArr.add(self.detailModel)
        
        self.requestData()
        //        MPMoviePlayerScalingModeDidChangeNotification MPMoviePlayerDidExitFullscreenNotification //播放完成
//        [notificationCenter  addObserver:self selector:@selector(playMoviesFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerVC];
//        //播放状态改变
//        [notificationCenter  addObserver:self selector:@selector(stateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
//        //加载状态改变
//        [notificationCenter  addObserver:self selector:@selector(loadStateChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        NotificationCenter.default.addObserver(self, selector: #selector(self.change(_:)), name: NSNotification.Name.MPMoviePlayerScalingModeDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterFullscreenNotificatio), name: NSNotification.Name.MPMoviePlayerWillEnterFullscreen, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterFullscreenNotificatio), name: NSNotification.Name.MPMoviePlayerDidEnterFullscreen, object: nil)
        
        
        self.manage.generateViewBlock = {(_ bulletView: BulletView)in
            self.addBulletView(bulletView: bulletView)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    //设置导航栏
    func setuNavigationView() {
        
        navigationView.removeFromSuperview()
        navigationView = NavigationCustomView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64));
        navigationView.navigationDelegate = self
        navigationView.rightBtn.isHidden = true
        self.view.addSubview(navigationView)
    }
    
    //添加弹幕
    func addBulletView(bulletView:BulletView) {
        bulletView.frame = CGRect(x: SCREEN_WIDTH, y: CGFloat(70+bulletView.trajector!*40), width: bulletView.bounds.width, height: bulletView.bounds.height)
        bulletView.startAnimation()
        self.view.addSubview(bulletView)
    }
    
    
    //横屏
    func change(_ nsnotifi:NotificationCenter) {
//    print("change ",nsnotifi)
//        self.moviePlayerVC.view.transform = CGAffineTransformMakeRotation(CGFloat( M_PI/2))
////        moviePlayerVC.moviePlayer.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300)
//        moviePlayerVC.view.frame = self.view.bounds
    }
    func willEnterFullscreenNotificatio()  {
        print("willEnterFullscreenNotificatio ")
        
//        dispatch_async(dispatch_get_main_queue()) {
//            self.moviePlayerVC.moviePlayer.setFullscreen(true, animated: true)
//            self.view.transform = CGAffineTransformMakeRotation(CGFloat( M_PI_2))
//            self.moviePlayerVC.view.transform = CGAffineTransformMakeRotation(CGFloat( M_PI_2))
//            self.moviePlayerVC.moviePlayer.view.frame = CGRectMake(0, 0, CGRectGetHeight(self.view.frame),CGRectGetWidth(self.view.frame) )
//            
//            self.moviePlayerVC.moviePlayer.view.transform = CGAffineTransformMakeRotation(CGFloat( M_PI_2))
//            self.moviePlayerVC.view.frame = CGRectMake(0, 0, 500,300 )
//            self.moviePlayerVC.view.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2)
            
            
//            self.moviePlayerVC.view.bounds = CGRectMake(0, 0, 400, 300)
////            self.moviePlayerVC.view.center = CGPointMake(160, 320)
//            self.moviePlayerVC.view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        
            
//        }
        
//        self.moviePlayerVC.moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
    }
    
    func didEnterFullscreenNotificatio()  {
         print("didEnterFullscreenNotificatio ")
//        self.moviePlayerVC.moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
//        self.moviePlayerVC.moviePlayer.setFullscreen(true, animated: true)
//        
//        dispatch_async(dispatch_get_main_queue()) { 
//            self.moviePlayerVC.view.bounds = CGRectMake(0, 0, 500, 300)
//            //            self.moviePlayerVC.view.center = CGPointMake(160, 320)
//            self.moviePlayerVC.view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2))
//        }
        
    }
    
    
    
    
    
    
    func requestData() {
        
        let gvidDic = detailModel?.videos[0] as! NSDictionary
        let idstr = (detailModel?.id)! as String
        let url = "http://search.chaojishipin.com/sarrs/details"

        let params = ["app_id": "732",
                      "appfrom": "appstore",
                      "appv": "1.3.1",
                      "appid":"0",
                      "area":"rec_0703",
                      "cursor":"0",
                      "forward":"1",
                      "auid":"e66004b407e4ac5bc7f4b56c7c874fbd",//e66004b407e4ac5bc7f4b56c7c874fbd
                      "bd":"iPhone",
                      "ip":"-",
                      "lc":"10c89e410fc9f3ece250b84baf983e09ce8351eb",
                      "r":"1472021529993",
                      "p":"0",
                      "pl":"1000010",
                      "pl1":"0",
                      "pl2":"01",
                      "device":"chaojishipin",
                      "gvid":String(describing: gvidDic["gvid"]),
                      "id":String(idstr),
                      "hot":"1"]
        

        SwiftRequestManager.getDataWithUrlStr(url,parameters: params as NSDictionary, succeedHandler: { (responseObject) in
            let dic:NSDictionary = responseObject as! NSDictionary

            
//            print("success  \(dic)")
            if ((dic["detail"]) != nil)
            {
                //数据变为空了
//                let detailDic = dic["detail"] as! NSDictionary
//                let infoModel = RecommendModel(Dictionary: detailDic as! [String : AnyObject])
//                self.detailModelArr.add(infoModel)
                
            }else
            {
                 print("detail null")
            }
            
            
            if((dic["rank"]) != nil)
            {
                let rankDic = dic["rank"] as! NSDictionary
                
                let rankItemsArr:NSArray = rankDic["items"] as! NSArray
                
                
                
                for itemsDic in rankItemsArr
                {
                    let rankModel = RankModel(Dictionary: itemsDic as! [String : AnyObject])
                    self.rankModelArr.add(rankModel)
                }
            }else
            {
                print("rank null")
            }
            
            if((dic["related_rec"]) != nil)
            {
                let relatedDic = dic["related_rec"] as! NSDictionary
                let relatedItemsArr:NSArray = relatedDic["items"]as! NSArray
                for itemsDic in relatedItemsArr
                {
                    let rankModel = RecommendModel(Dictionary: itemsDic as! [String : AnyObject])
                    self.relatedRecModelArr.add(rankModel)
                }
            }else
            {
                
                print("related_rec null")
            }
            
            
            
            self.tableView.reloadData()
            
        }) { (error) in
            print("faile error: "+error.localizedDescription)
        }
        
    }

    //NavigationDelegate
    func btnAction(_ sender: UIButton) {
        
        if sender.tag == 1000 {
           _ = self.navigationController?.popViewController(animated: true)
        }else
        {
            
            let alertView = UIAlertView.init(title: "分享成功", message: "已经分享成功", delegate:  self, cancelButtonTitle: "关闭")
            alertView.show()
        }
        
    }
    
    //UITableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0)
        {
            return detailModelArr.count
        }else if(section == 1)
        {
            return 1
            
        }else if(section == 2)
        {     return rankModelArr.count
            
        }else if(section == 3)
        {
            return hotRecModelArr.count
        }else
        {
            return commentModelArr.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if ((indexPath as NSIndexPath).section == 0)
        {
            let model:RecommendModel = detailModelArr[(indexPath as NSIndexPath).row] as! RecommendModel
            let size = MPHelperProject.getSizeWithStr(model.Description, fontSize: 13, constraintWidth: SCREEN_WIDTH-CGFloat(2*10), constraintHeight: 1000)
            return (isShowDes == true ? size.height+20+110:110)
        }else if((indexPath as NSIndexPath).section == 1)
        {
            return 100*0.618+40
        }else if((indexPath as NSIndexPath).section == 2)
        {
           return 100*0.618+40
        }else if((indexPath as NSIndexPath).section == 3)
        {
            return 100*0.618+40
        }else
        {
           return 100*0.618+40
        }
        
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let headerView = UIView()
//        let titleLab = UILabel()
//        headerView.addSubview(titleLab)
//        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100)
//        titleLab.frame = CGRectMake(0, 0, 100, 30)
//        headerView.backgroundColor = UIColor.redColor()
//        titleLab.backgroundColor = UIColor.yellowColor()
//        titleLab.text = "headerView"
//        
//        
//        return headerView
//    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let idefst = "reusecell"
        let  cell  = ListTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: idefst)
        if ((indexPath as NSIndexPath).section == 0)
        {
            let detailIDefst = "detail"
            let  cell  = MoviePlayerDetailTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: detailIDefst)
            cell.showDesBtn.addTarget(self, action: #selector(self.showDescrip(_:)), for: UIControlEvents.touchUpInside)
            let model:RecommendModel = detailModelArr[(indexPath as NSIndexPath).row] as! RecommendModel
            cell.setupDetailModel(model,isShowDes: isShowDes)
            return cell
        }else if((indexPath as NSIndexPath).section == 1)
        {
            let relatedIDefst = "detail"
            let  cell  = RelatedTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: relatedIDefst)
            cell.setupRelatedModelWithArr(rankModelArr)
            return cell
        }else if((indexPath as NSIndexPath).section == 2)
        {
            let rankIDefst = "detail"
            let  cell  = RelatedTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: rankIDefst)
            cell.setupRelatedModelWithArr(rankModelArr)
            return cell
        }else if((indexPath as NSIndexPath).section == 3)
        {
            _ = rankModelArr[(indexPath as NSIndexPath).row] as! RankModel
            //            cell.setupRecommentModel(model)
//            cell.imageView?.sd_setImageWithURL(NSURL.init(string: model.image))
            return cell
        }else
        {
            _  = rankModelArr[(indexPath as NSIndexPath).row] as! RankModel
            //            cell.setupRecommentModel(model)
//            cell.imageView?.sd_setImageWithURL(NSURL.init(string: model.image))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--------index ",(indexPath as NSIndexPath).row)

        if (indexPath as NSIndexPath).section == 0 {
            self.showDescrip(UIButton())
        }
        
    }
    
    func showDescrip(_ sender:UIButton)  {
        print("--------click")
        isShowDes = !isShowDes

        if isShowDes {
            self.manage.start()
        }else
        {
            self.manage.stop()
        }
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        self.tableView.reloadRows(at: NSArray.init(object: indexPath) as! [IndexPath], with: UITableViewRowAnimation.fade)

        self.tableView.reloadData()
        
        
        
        
        
    }

}
