//
//  LKCompareTableMorePlug.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit

@objc public protocol LKCompareTableMorePlugDelegate: NSObjectProtocol {
    
    /// 点击某个item项
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    ///   - index: 第几个item
    ///   - truncated: 是否被截断（用于判断是否需要展开）
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int, is truncated: Bool, deal result: Any?)
}

open class LKCompareTableMorePlug: NSObject {
    
    /// 数据源
    private var datas: [LKCompareTableMoreModel]?
    
    /// 作为内部样式额外的事件
    public weak var delegate: LKCompareTableMorePlugDelegate?
    
    /// init
    public init(delegate: LKCompareTableMorePlugDelegate? = nil) {
        self.delegate = delegate
    }
}

extension LKCompareTableMorePlug: LKCompareTablePlug {
    
    public func prepare(with target: LKCompareTableView) {
        target.register(LKCompareTableIMoreItemCell.self, forCellReuseIdentifier: "LKCompareTableIMoreItemCell")
    }
    
    public func load(with data: Any?) {
        self.datas = data as? [LKCompareTableMoreModel]
    }
}

extension LKCompareTableMorePlug: LKCompareTableViewDataSource {
    
    public func numberOfSections(in compareTableView: LKCompareTableView) -> Int {
        return datas?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, numberOfRowsInSection section: Int) -> Int {
        return datas?[section].fields?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int {
        return datas?[indexPath.section].fields?[indexPath.row].items?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, titleForHeaderInSection section: Int) -> String? {
        return datas?[section].headerTitle
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String? {
        return datas?[indexPath.section].fields?[indexPath.row].fieldName ?? nil
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, cellForItemAt indexPath: IndexPath, to index: Int) -> LKCompareTableItemCell {
        let cell = compareTableView.dequeueReusableCell(withIdentifier: "LKCompareTableIMoreItemCell", for: indexPath, to: index) as! LKCompareTableIMoreItemCell
        cell.setAlignment(datas?[indexPath.section].fields?[indexPath.row].contentAlignment ?? .topLeft)
        
        let items = datas?[indexPath.section].fields?[indexPath.row].items
        guard let text = items?[index].text else {
            cell.attributedText = items?[index].attributedText
            return cell
        }
        
        cell.text = text
        return cell
    }
}

extension LKCompareTableMorePlug: LKCompareTableViewDelegate {
    
    public func compareTableView(_ compareTableView: LKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int) {
        let ownCell = compareTableView.cellForItem(at: indexPath, to: index) as? LKCompareTableIMoreItemCell
        if (ownCell != nil) {
            let items = datas?[indexPath.section].fields?[indexPath.row].items
            self.delegate?.compareTableView?(compareTableView, didSelectRowAt: indexPath, to: index, is: !ownCell!.detailsLabel.isHidden, deal: items?[index].result)
        }
    }
}

