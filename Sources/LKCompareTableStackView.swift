//
//  LKCompareTableStackView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit

open class LKCompareTableStackView: UIStackView {
    
    // MARK: - Public（Ivars）
    
    typealias rectBlock = (_ rect: CGRect) -> Void
    
    var separatorColor: UIColor?
    var separatorViews = [UIView]()
    var separatorInset: UIEdgeInsets!
    
    func layoutSubviewsBlock(block: @escaping rectBlock) {
        layoutSubviewsCall = block
    }
    
    // MARK: - Public（Method）
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        makeSeparators()
        layoutSubviewsCall?(frame)
    }
    
    // MARK: - Config
    
    // MARK: - Update view
    
    // MARK: - Action
    
    // MARK: - Private（Ivars）
    
    private(set) var layoutSubviewsCall: rectBlock?
    
    // MARK: - Private（Method）
    
    private func makeSeparators() {
        for item in separatorViews {
            item.removeFromSuperview()
        }
        
        separatorViews.removeAll()
        
        var tempSeparatorViews = [UIView]()
        
        var previousView: UIView!
        for (idx, item) in arrangedSubviews.enumerated() {
            if idx == 0 {
                previousView = item
            }
            
            let separatorView = UIView()
            separatorView.backgroundColor = separatorColor
            
            if axis == .horizontal {
                separatorView.frame = CGRect(x: previousView.frame.maxX + separatorInset.left, y: previousView.frame.minY + separatorInset.top, width: spacing - separatorInset.left - separatorInset.right, height: previousView.frame.height - separatorInset.top - separatorInset.top - separatorInset.bottom)
            } else {
                separatorView.frame = CGRect(x: previousView.frame.minX + separatorInset.left, y: previousView.frame.minY + separatorInset.top, width: spacing - separatorInset.left - separatorInset.right, height: previousView.frame.height - separatorInset.top - separatorInset.top - separatorInset.bottom)
            }
            
            addSubview(separatorView)
            tempSeparatorViews.append(separatorView)
            previousView = item
        }
        
        separatorViews = tempSeparatorViews
    }
}
