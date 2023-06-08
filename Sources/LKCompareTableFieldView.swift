//
//  LKCompareTableFieldView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/10/21.
//

import UIKit

extension LKCompareTableFieldView {
    
    public enum FieldStyle : Int, @unchecked Sendable {

        case `default` = 0
        
    }
}

@objcMembers
open class LKCompareTableFieldView: UIView {
    
    // MARK: - Public（Ivars）
    
    public private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    public private(set) var reuseIdentifier: String?
    
    // MARK: - Public（Method）
    
    // MARK: - Init
    
    public required init(style: FieldStyle, reuseIdentifier: String?) {
        super.init(frame: CGRect.zero)
        
        self.reuseIdentifier = reuseIdentifier
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.lessThanOrEqualTo(-10)
            make.top.lessThanOrEqualTo(9)
            make.bottom.lessThanOrEqualTo(-9).priority(.high)
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
