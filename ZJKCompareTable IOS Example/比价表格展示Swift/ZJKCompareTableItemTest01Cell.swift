//
//  ZJKCompareTableItemTest01Cell.swift
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/9/29.
//

import UIKit
import ZJKCompareTable

@objcMembers
class ZJKCompareTableItemTest01Cell: ZJKCompareTableItemCell {
    
    // MARK: - ***** Public method *****
    
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
            detailsLabel.isHidden = !isTruncated(with: text, valueLabel.font)
        }
    }
    
    /// 侧边自适应内容父视图
    public private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    required init(style: ZJKCompareTableItemCell.ItemStyle, reuseIdentifier: String?) {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    private func isTruncated(with newText: String?, _ font: UIFont) -> Bool {
        guard let text = newText else { return false }
        let size = CGSize(width: 120 - 18, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = (text as NSString).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        /// 理论行数
        let labelLines = Int(ceil(labelSize.height / font.lineHeight))
        
        /// 实际行数
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        label.numberOfLines = valueLabel.numberOfLines;
        label.font = valueLabel.font;
        label.text = valueLabel.text;
        label.attributedText = valueLabel.attributedText;
        label.sizeToFit()
        
        var labelShowLines = Int(floor(CGFloat(label.frame.size.height) / font.lineHeight))
        if valueLabel.numberOfLines != 0 {
            labelShowLines = min(labelShowLines, valueLabel.numberOfLines)
        }
        
        /// 比较两个行数来判断是否需要截断
        return labelLines > labelShowLines
    }
    
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
