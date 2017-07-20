//
//  TYCyclePagerViewCell.swift
//  TYCyclePagerViewDemo_swift
//
//  Created by tany on 2017/7/20.
//  Copyright © 2017年 tany. All rights reserved.
//

import UIKit

class TYCyclePagerViewCell: UICollectionViewCell {
    
    lazy var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTextLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTextLabel()
    }
    
    func addTextLabel() {
        self.label.textColor = UIColor.white
        self.label.textAlignment = NSTextAlignment.center
        self.label.font = UIFont.systemFont(ofSize: 18)
        self.addSubview(self.label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
}
