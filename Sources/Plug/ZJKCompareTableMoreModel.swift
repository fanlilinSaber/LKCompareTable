//
//  ZJKCompareTableMoreModel.swift
//  ZJKCompareTable
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit

extension ZJKCompareTableMoreFieldModel {
    /// 内容整体排列模式
    public enum ContentAlignment : Int, @unchecked Sendable {
        /// 垂直→从上到下，水平→从左到右边
        case topLeft = 0
        /// 垂直→居中，水平→从左到右边
        case centerLeft = 1
        /// 垂直→居中，水平→居中
        case center = 2
    }
}

@objcMembers
open class ZJKCompareTableMoreModel: NSObject {
    
    /// 头部标题
    public var headerTitle: String?
    
    /// 对应的字段
    public var fields: Array<ZJKCompareTableMoreFieldModel>?
}

@objcMembers
open class ZJKCompareTableMoreFieldModel: NSObject {
    
    /// 字段名
    public var fieldName: String?
    
    /// 当前字段→展示内容最大换行数（默认 = 0，不限制）
    public var numberOfLines: Int = 0
    
    /// 对齐模式
    public var contentAlignment: ContentAlignment = .topLeft
    
    /// 对应字段的内容
    public var items: Array<ZJKCompareTableMoreItemModel>?
}

@objcMembers
open class ZJKCompareTableMoreItemModel: NSObject {
    
    /// 普通文本
    public var text: String?
    
    /// 富文本
    public var attributedText: NSAttributedString?
    
    /// 可以关联任意值；用于处理比如点击之后根据字段'result'的值做下一步操作
    public var result: Any?
}

extension ZJKCompareTableMoreModel {
    
    public func makeFieldModel(with number: Int,_ closure: (_ index: Int , _ field: ZJKCompareTableMoreFieldModel) -> Void) {
        
        var array = [ZJKCompareTableMoreFieldModel]()
        for index in 0..<number {
            let model = ZJKCompareTableMoreFieldModel()
            closure(index, model)
            array.append(model)
        }
        fields = array
    }
}

extension ZJKCompareTableMoreFieldModel {
    
    public func makeItemModel(with number: Int,_ closure: (_ index: Int , _ item: ZJKCompareTableMoreItemModel) -> Void) {
        
        var array = [ZJKCompareTableMoreItemModel]()
        for index in 0..<number {
            let model = ZJKCompareTableMoreItemModel()
            closure(index, model)
            array.append(model)
        }
        items = array
    }
}
