//
//  LKCompareTableIMoreItemCell.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit

class LKCompareTableIMoreItemCell: LKCompareTableItemCell {
    
    // MARK: - ***** Public method *****
    
    public func setAlignment(_ alignment: LKCompareTableMoreFieldModel.ContentAlignment) {
        if contentAlignment == alignment { return }
        contentAlignment = alignment
        if alignment == .topLeft {
            contentStackView.alignment = .fill
            contentStackView.snp.remakeConstraints { make in
                make.top.left.equalTo(9)
                make.right.lessThanOrEqualTo(-9)
                make.bottom.lessThanOrEqualTo(-9)
            }
        } else if alignment == .centerLeft {
            contentStackView.alignment = .fill
            contentStackView.snp.remakeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(9)
                make.top.lessThanOrEqualTo(9)
                make.right.lessThanOrEqualTo(-9)
                make.bottom.lessThanOrEqualTo(-9)
            }
        } else if alignment == .center {
            contentStackView.alignment = .center
            contentStackView.snp.remakeConstraints { make in
                make.centerY.centerX.equalToSuperview()
                make.left.lessThanOrEqualTo(9)
                make.right.lessThanOrEqualTo(-9)
                make.top.lessThanOrEqualTo(9)
                make.bottom.equalTo(-9)
            }
        }
    }
    
    // MARK: - ***** Ivars *****
    
    public private(set) lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private(set) lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "展开全部>"
        label.textColor = UIColor(red: 0.34, green: 0.57, blue: 0.99, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public var text: String? {
        didSet {
            valueLabel.text = text
            detailsLabel.isHidden = !valueLabel.isTruncated(with: 120 - 18)
        }
    }
    
    public var attributedText: NSAttributedString? {
        didSet {
            valueLabel.attributedText = attributedText
            detailsLabel.isHidden = true
        }
    }
    
    /// 侧边自适应内容父视图
    public private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private var contentAlignment: LKCompareTableMoreFieldModel.ContentAlignment = .topLeft
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    required public init(style: LKCompareTableItemCell.ItemStyle, reuseIdentifier: String?) {
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
        contentStackView.addArrangedSubview(detailsLabel)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Create method *****
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
