//
//  LKCompareTableTest01HeaderView.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit
import LKCompareTable

class LKCompareTableTest01HeaderView: LKCompareTableHeaderFooterView {
    
    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.gray
        titleLabel.textColor = UIColor.red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ***** Lifecycle *****
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Protocol *****
    
    // MARK: - ***** Create Method *****
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
