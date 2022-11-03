//
//  ZJKCompareTableEasy.swift
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/7.
//

import Foundation
import UIKit

class ZJKCompareTableEasy: NSObject {
    static let sharedLabel = UILabel()
}

extension UILabel {
    
    /// 是否被截断
    public func isTruncated(with width: CGFloat) -> Bool {
        guard let text = text else { return false }
    
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let label = ZJKCompareTableEasy.sharedLabel;
        label.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        label.text = text
        label.font = font
        label.attributedText = attributedText
        label.lineBreakMode = lineBreakMode
        
        /// 计算理论行数
        label.numberOfLines = 0;
        label.sizeToFit()
        let labelSize = label.frame.size
        let labelLines = Int(floor(labelSize.height / font.lineHeight))
        
        /// 计算实际行数
        label.numberOfLines = numberOfLines
        label.sizeToFit()
        var labelShowLines = Int(floor(CGFloat(label.frame.size.height) / font.lineHeight))
        
        if numberOfLines != 0 {
            labelShowLines = min(labelShowLines, numberOfLines)
        }
        
        /// 比较两个行数来判断是否需要截断
        return labelLines > labelShowLines
    }
}
