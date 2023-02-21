//
//  LKCompareTableTest01FieldView.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/23.
//

import UIKit
import LKCompareTable

@objcMembers
class LKCompareTableTest01FieldView: LKCompareTableFieldView {
    
    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    public private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public private(set) lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "order_delete");
        return imageView
    }()
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    required init(style: LKCompareTableFieldView.FieldStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(iconImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(8);
            make.left.equalTo(10)
            make.right.lessThanOrEqualTo(-10)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Create method *****
    
}
