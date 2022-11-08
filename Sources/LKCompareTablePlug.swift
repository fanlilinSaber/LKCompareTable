//
//  LKCompareTablePlug.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/10/24.
//

import Foundation

@objc public protocol LKCompareTablePlug: NSObjectProtocol {
    
    /// 做一些配置和准备工作
    /// - Parameter target: LKCompareTableView
    func prepare(with target: LKCompareTableView)
    
    /// 加载的数据源
    /// - Parameter data: 数据源
    func load(with data: Any?)
}
