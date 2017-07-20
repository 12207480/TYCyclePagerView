//
//  ViewController.swift
//  TYCyclePagerViewDemo_swift
//
//  Created by tany on 2017/7/20.
//  Copyright © 2017年 tany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var datas = [UIColor]()

    lazy var pagerView: TYCyclePagerView = {
        let pagerView = TYCyclePagerView()
        pagerView.isInfiniteLoop = true
        pagerView.autoScrollInterval = 3.0
        return pagerView
    }()
    
    lazy var pageControl: TYPageControl = {
        let pageControl = TYPageControl()
        pageControl.currentPageIndicatorSize = CGSize(width: 8, height: 8)
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addPagerView()
        self.addPageControl()
    }
    
    func addPagerView() {
        self.pagerView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.register(TYCyclePagerViewCell.classForCoder(), forCellWithReuseIdentifier: "cellId")
        self.view.addSubview(self.pagerView)
    }
    
    func addPageControl() {
        self.pagerView.addSubview(self.pageControl)
    }
    
    func loadData() {
        var i = 0
        while i < 5 {
            self.datas.append(UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1))
            i += 1
        }
        self.pageControl.numberOfPages = self.datas.count
        self.pagerView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: TYCyclePagerViewDelegate, TYCyclePagerViewDataSource {
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        return self.datas.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cellId", for: index)
        cell.backgroundColor = self.datas[index]
        return cell
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        layout.itemSize = CGSize(width: pagerView.frame.width, height: pagerView.frame.height)
        layout.itemSpacing = 15
        layout.itemHorizontalCenter = true
        return layout
    }
    
    func pagerView(_ pageView: TYCyclePagerView, didScrollFrom fromIndex: Int, to toIndex: Int) {
        self.pageControl.currentPage = toIndex;
    }
}
