//
//  LKCompareTableItemCell.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/29.
//

import UIKit
import SnapKit

extension LKCompareTableItemCell {
    
    public enum ItemStyle : Int, @unchecked Sendable {

        case `default` = 0
        
    }
}

@objcMembers
open class LKCompareTableItemCell: UIView {
    
    // MARK: - Public（Ivars）
    
    public private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public private(set) var reuseIdentifier: String?
    
    // MARK: - Public（Method）
    
    // MARK: - Init
    
    public required init(style: ItemStyle, reuseIdentifier: String?) {
        super.init(frame: CGRect.zero)
        
        self.reuseIdentifier = reuseIdentifier
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.left.equalTo(9).priority(.high)
            make.right.lessThanOrEqualTo(-9)
            make.bottom.lessThanOrEqualTo(-9)
        }
    }
        
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Config
    
    // MARK: - Update view
    
    // MARK: - Action
    
    // MARK: - Private（Ivars）

    // MARK: - Private（Method）

}

