//
//  LKCompareTableStackView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit

open class LKCompareTableStackView: UIStackView {
    
    typealias rectBlock = (_ rect: CGRect) -> Void
    
    // MARK: - ***** Public method *****
    
    func layoutSubviewsBlock(block: @escaping rectBlock) {
        layoutSubviewsCall = block
    }
    
    // MARK: - ***** Ivars *****
    
    var separatorColor: UIColor?
    var separatorViews = [UIView]()
    var separatorInset: UIEdgeInsets!

    private(set) var layoutSubviewsCall: rectBlock?
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        makeSeparators()
        layoutSubviewsCall?(frame)
        
    }
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
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
            }else {
                separatorView.frame = CGRect(x: previousView.frame.minX + separatorInset.left, y: previousView.frame.minY + separatorInset.top, width: spacing - separatorInset.left - separatorInset.right, height: previousView.frame.height - separatorInset.top - separatorInset.top - separatorInset.bottom)
            }
            
            addSubview(separatorView)
            tempSeparatorViews.append(separatorView)
            previousView = item
        }
        
        separatorViews = tempSeparatorViews
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
