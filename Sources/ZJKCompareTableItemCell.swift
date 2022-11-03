//
//  ZJKCompareTableItemCell.swift
//  ZJKCompareTable
//
//  Created by Fan Li Lin on 2022/9/29.
//

import UIKit
import SnapKit

extension ZJKCompareTableItemCell {
    
    public enum ItemStyle : Int, @unchecked Sendable {

        case `default` = 0
        
    }
}

@objcMembers
open class ZJKCompareTableItemCell: UIView {
    
    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    public private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    public private(set) var reuseIdentifier: String?
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    required public init(style: ItemStyle, reuseIdentifier: String?) {
        super.init(frame: CGRect.zero)
        self.reuseIdentifier = reuseIdentifier
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.top.left.equalTo(9).priority(.high)
            make.right.lessThanOrEqualTo(-9)
            make.bottom.lessThanOrEqualTo(-9)
        }
    }
        
    required public init?(coder: NSCoder) {
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
