//
//  SearchViewController.swift
//  MovieProject
//
//  Created by Bert on 16/8/18.
//  Copyright © 2016年 Bert. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,SearchNavigationCustomViewDelegate ,UITableViewDelegate,UITableViewDataSource,
 HotSearchTableViewCellDelegate{

    let searchNavigationView = SearchNavigationCustomView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
    let tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64))
    let dataArr  = NSMutableArray()

    let hotSearchDataArr = NSMutableArray()//推荐
    var isShowHistory = true
    
    var historySearchDataArr = NSMutableArray()//搜索历史
    
    var currentSearchStr = NSString()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchNavigationView.searchNavigationDelegate = self
        searchNavigationView.searchTextField.becomeFirstResponder()
        self.view.addSubview(searchNavigationView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self

        let tempVeiw = UIView.init(frame: CGRect.zero)
        tableView.tableFooterView = tempVeiw
        
        self.view.addSubview(tableView)
        self.requestHotSearchData()
    }
    
    /**
     请求搜索数据
     */
    func requestData(_ tableViewTag:NSInteger,keyWords:String) {
        let url = "http://search.chaojishipin.com/sarrs/suggest"
        let params = [
            "app_id": "732",
            "appfrom": "appstore",
            "appv": "1.3.1",
            "area":"rec_0703",
            "auid":"10c89e410fc9f3ece250b84baf983e09ce8351eb",
            "lc":"10c89e410fc9f3ece250b84baf983e09ce8351eb",//关键参数
            "q":keyWords//关键
        ]
        
        SwiftRequestManager.getDataWithUrlStr(url,parameters: params as NSDictionary, succeedHandler: { (responseObject) in
            let dic:NSDictionary = responseObject as! NSDictionary
            let itemsArr:NSArray = dic["items"] as! NSArray
            if (itemsArr.count > 0 )
            {
                self.currentSearchStr = keyWords as NSString
                self.dataArr.removeAllObjects()
                for  dic in itemsArr
                {
                    let infoModel = SearchModel(Dictionary: dic as! [String : AnyObject])
                    self.dataArr.add(infoModel)
                }
                self.saveSearchHistoryData(keyWords)
                self.tableView.reloadData()
            }
        }) { (error) in
            
            print("faile error: "+error.localizedDescription)
        }
    }
    
    /**
     请求热门搜索数据
     */
    func requestHotSearchData() {
        let url = "http://search.chaojishipin.com/sarrs/toplist"
        let params = [
            "app_id": "732",
            "appfrom": "appstore",
            "appv": "1.3.1",
            "area":"rec_0703",
            "auid":"10c89e410fc9f3ece250b84baf983e09ce8351eb",
            "lc":"10c89e410fc9f3ece250b84baf983e09ce8351eb",//关键参数
//            "q":keyWords//关键
        ]
        
        SwiftRequestManager.getDataWithUrlStr(url,parameters: params as NSDictionary, succeedHandler: { (responseObject) in
            let dic:NSDictionary = responseObject as! NSDictionary
            let itemsArr:NSArray = dic["items"] as! NSArray
            self.hotSearchDataArr.removeAllObjects()
            for  dic in itemsArr
            {
                let infoModel = SearchModel(Dictionary: dic as! [String : AnyObject])
                self.hotSearchDataArr.add(infoModel)
            }
            self.getHistroryData()
            self.tableView.reloadData()
            
        }) { (error) in
            
            print("faile error: "+error.localizedDescription)
        }
    }

    //SearchNavigationCustomViewDelegate
    func searchNavigationCancelBtnClick(_ sender: UIButton) {
          searchNavigationView.searchTextField.resignFirstResponder()
        _ = self.navigationController?.popViewController(animated: true)
    }
    func searchNavigationTextFiled(_ keyWords: String) {
        print("--------keyWords.characters.count \(keyWords.characters.count)")
        if keyWords.characters.count > 0  {
             self.requestData(0, keyWords: keyWords)
            isShowHistory = false
        }else
        {
             isShowHistory = true
            self.dataArr.removeAllObjects()
            self.tableView.reloadData()
        }
    }
    
    //HotSearchTableViewCellDelegate
    func hotSearchBtnClick(_ sender: UIButton) {
        if sender.tag == 1111 {//清理历史记录
            self.didClearHistorySearch()
        } else
        {
            currentSearchStr = sender.currentTitle! as NSString
            self.requestData(0, keyWords: sender.currentTitle!)
            isShowHistory = false
            self.searchNavigationView.searchTextField.text = sender.currentTitle!
            searchNavigationView.searchTextField.clearButtonMode = UITextFieldViewMode.whileEditing
            searchNavigationView.searchTextField.becomeFirstResponder()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchNavigationView.searchTextField.resignFirstResponder()
        searchNavigationView.searchTextField.clearButtonMode = UITextFieldViewMode.always
    }
    
    //UITableViewdelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if isShowHistory {
            if self.historySearchDataArr.count > 0 {
                return 2
            }
            return 1
        }
        return dataArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if isShowHistory {
            if (indexPath as NSIndexPath).row == 0 {
                if self.historySearchDataArr.count > 0 {
                    let count = self.historySearchDataArr.count
                    var row = 1
                    if count%2 == 0 {
                        row = count/2
                    }else
                    {
                        row = count/2 + 1
                    }
                    return CGFloat(row)*37 + 40
                }
            }
            return 230
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if isShowHistory {
            let idefst = "reuseHistorycell"
            let  cell  = HotSearchTableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: idefst)
            cell.hotSearchDelegate = self
            
            if self.historySearchDataArr.count > 0 {
                if (indexPath as NSIndexPath).row == 0 {
                    cell.setupHotSearchModel(self.historySearchDataArr, isHistorySearch: true)
                }else
                {
                    cell.setupHotSearchModel(self.hotSearchDataArr,isHistorySearch: false)
                }
            }else
            {
               cell.setupHotSearchModel(self.hotSearchDataArr,isHistorySearch: false)
            }
            return cell
        }
        
        let idefst = "reusecell"
        let  cell  = UITableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: idefst)
        let model:SearchModel = dataArr[(indexPath as NSIndexPath).row] as! SearchModel
        cell.textLabel?.text = model.title
        cell.textLabel?.textColor = UIColor.gray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isShowHistory {
            return
        }
        print("--------index ",(indexPath as NSIndexPath).row)
    }
    
    /**
     *  数据持久化搜索历史
     */
    
    func saveSearchHistoryData(_ keywords:String) {
        //如果为空返回
        if self.isEmpty(keywords as NSString) || keywords.characters.count == 0{
            return
        }
        let sendDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let  currentHisDic = NSMutableDictionary()
        currentHisDic.setValue(dateFormatter.string(from: sendDate), forKey: TIMESTAMP_SEARCH_HISTORY)
        currentHisDic.setValue(keywords, forKey: WORDS_SEARCH_HISTORY)
        
        
        let userDefaults = UserDefaults.standard
        let tempObjectArr = userDefaults.object(forKey: SEARCH_HISTORY_KEY)
        var historyArr:NSArray = NSArray()
        if tempObjectArr != nil {
            
            historyArr = NSArray.init(array: tempObjectArr as! NSArray)
           

        }

        let  tempArr:NSMutableArray = NSMutableArray.init(array: historyArr)
        if tempArr.count == 10
        {
            tempArr.removeAllObjects()
        }else
        {
            
        }
        
        var isExist = false
        for dic in tempArr {
            
            if ((dic as AnyObject).object(forKey: WORDS_SEARCH_HISTORY) as! String == keywords) {
                tempArr.remove(dic)
                tempArr.insert(currentHisDic, at: 0)
                isExist = true
                break
            }
        }
        
        if !isExist {
            tempArr.insert(currentHisDic, at: 0)
        }
        
        userDefaults.set(tempArr, forKey: SEARCH_HISTORY_KEY)
        userDefaults.synchronize()
        self.historySearchDataArr.removeAllObjects()
        self.historySearchDataArr = NSMutableArray.init(array: tempArr)
        
    }
    
    
    func getHistroryData()
    {
    
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: SEARCH_HISTORY_KEY) == nil {
            return
        }
        
        let tempObjectArr:NSArray =   (userDefaults.object(forKey: SEARCH_HISTORY_KEY) as? NSArray)!

        var historyArr:NSArray = NSArray()
        if tempObjectArr.count > 0 {
            historyArr = NSArray.init(array: tempObjectArr )
            self.historySearchDataArr.removeAllObjects()
            self.historySearchDataArr = NSMutableArray.init(array: historyArr)
        }
        
    }

    
    //判断内容是否全部为空格  yes 全部为空格  no 不是
    func isEmpty(_ str:NSString) -> Bool {
        if str.length == 0 {
            return true
        }else
        {
            let set = CharacterSet.whitespacesAndNewlines
            let tempSt:NSString = str.trimmingCharacters(in: set) as NSString
            if tempSt.length == 0 {
                return true
            }else
            {
                return false
            }
            
        }
    }

    func didClearHistorySearch() {
        self.currentSearchStr = ""
        self.historySearchDataArr.removeAllObjects()
        let userDefaults = UserDefaults()
        userDefaults.set(nil, forKey: SEARCH_HISTORY_KEY)
        userDefaults.synchronize()
        self.tableView.reloadData()
        isShowHistory = true
    }
    
}
