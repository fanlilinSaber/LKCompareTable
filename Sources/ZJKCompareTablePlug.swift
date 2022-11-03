//
//  ZJKCompareTablePlug.swift
//  ZJKCompareTable
//
//  Created by Fan Li Lin on 2022/10/24.
//

import Foundation

@objc public protocol ZJKCompareTablePlug: NSObjectProtocol {
    
    /// 做一些配置和准备工作
    /// - Parameter target: ZJKCompareTableView
    func prepare(with target: ZJKCompareTableView)
    
    /// 加载的数据源
    /// - Parameter data: 数据源
    func load(with data: Any?)
}
