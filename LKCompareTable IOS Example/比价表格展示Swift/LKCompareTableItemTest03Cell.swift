//
//  LKCompareTableItemTest03Cell.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/24.
//

import UIKit
import LKCompareTable

@objcMembers
class LKCompareTableItemTest03Cell: LKCompareTableItemCell {

    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    public private(set) lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public private(set) lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "order_select");
        return imageView
    }()
    
    public private(set) lazy var hideSameSwitch: UISwitch = {
        let aSwitch = UISwitch()
        return aSwitch
    }()
    
    /// 侧边自适应内容父视图
    public private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    required init(style: LKCompareTableItemCell.ItemStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.top.left.equalTo(9)
            make.right.lessThanOrEqualTo(-9)
            make.bottom.lessThanOrEqualTo(-9)
        }
        
        contentStackView.addArrangedSubview(valueLabel)
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(hideSameSwitch)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
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
