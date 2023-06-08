//
//  LKCompareTableHeaderFooterView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/26.
//

import UIKit
import SnapKit

@objcMembers
open class LKCompareTableHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Public（Ivars）
    
    /// 标题
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    // MARK: - Public（Method）
    
    // MARK: - Init
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundView = UIView()
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
        contentView.backgroundColor = .white
        addSubviews()
        layoutPageSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Config
    
    open func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    open func layoutPageSubviews() {
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalTo(contentView)
            make.right.lessThanOrEqualTo(-10).priority(.high)
        }
    }
    
    // MARK: - Update view
    
    // MARK: - Action
    
    // MARK: - Private（Ivars）

    // MARK: - Private（Method）

}
