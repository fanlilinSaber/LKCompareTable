//
//  LKCompareTableTest01Model.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit


open class LKCompareTableTest01Model: NSObject {
    
    /// 头部标题
    public var headerTitle: String?
    
    /// 属性名
    public var attrName: String?
    
    /// 当前属性→展示内容最大换行数（默认 = 0，不限制）
    public var numberOfLines: Int = 0
    
    /// 对应属性的内容
    public var values: Array<String>?
}
