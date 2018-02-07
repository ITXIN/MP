//
//  ScrollPageView.swift
//  ScrollViewController
//
//  Created by jasnig on 16/4/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//
// github: https://github.com/jasnig
// 简书: http://www.jianshu.com/p/b84f4dd96d0c

import UIKit

protocol ScrollPageViewDelegate:NSObjectProtocol {
    func currentIndex(_ currentIndex:NSInteger)
}



class ScrollPageView: UIView ,ScrollSegmentViewDelegate {
    
    var scrollPageDelegate:ScrollPageViewDelegate!
    
    static let cellId = "cellId"
    var segmentStyle = SegmentStyle()
    
    fileprivate var segView: ScrollSegmentView!
    fileprivate var contentView: ContentView!
    fileprivate var titlesArray: [String] = []
    /// 所有的子控制器
    fileprivate var childVcs: [UIViewController] = []
    
    /// 设置选中的下标
    func selectedIndex(_ selectedIndex: Int, animated: Bool) {
        
        // 移动滑块的位置
        segView.selectedIndex(selectedIndex, animated: animated)
        
    }
    init(frame:CGRect, segmentStyle: SegmentStyle, titles: [String], childVcs:[UIViewController]) {
        self.childVcs = childVcs
        self.titlesArray = titles
        self.segmentStyle = segmentStyle
        assert(childVcs.count == titles.count, "标题的个数必须和子控制器的个数相同")
        super.init(frame: frame)
        // 初始化设置了frame后可以在以后的任何地方直接获取到frame了, 就不必重写layoutsubview()方法在里面设置各个控件的frame
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func commonInit() {
        backgroundColor = UIColor.white
        /**
         *  类别视图
         */
        segView = ScrollSegmentView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44), segmentStyle: segmentStyle, titles: titlesArray)
        segView.scrollSegmentDelegate = self
     
        
        contentView = ContentView(frame: CGRect(x: 0, y: segView.frame.maxY, width: bounds.size.width, height: bounds.size.height - 44), childVcs: childVcs)
        contentView.delegate = self
        
        addSubview(contentView)
        addSubview(segView)
        // 在这里调用了懒加载的collectionView, 那么之前设置的self.frame将会用于collectionView,如果在layoutsubviews()里面没有相关的处理frame的操作, 那么将导致内容显示不正常
        // 避免循环引用
        segView.titleBtnOnClick = {[unowned self] (label: UILabel, index: Int) in
            
            // 切换内容显示
            self.contentView.setContentOffSet(CGPoint(x: self.contentView.bounds.size.width * CGFloat(index), y: 0), animated: false)
        }


    }
    
    //ScrollSegmentViewDelegate
    func currentIndex(_ currentIndex: NSInteger) {
        print("--------currentindex \(currentIndex)")

        if scrollPageDelegate != nil {
            scrollPageDelegate.currentIndex(currentIndex)
        }
    }
    
    

 
}


extension ScrollPageView: ContentViewDelegate {

    var segmentView: ScrollSegmentView {
        return segView
    }

}
