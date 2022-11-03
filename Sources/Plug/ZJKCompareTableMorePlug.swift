//
//  ZJKCompareTableMorePlug.swift
//  ZJKCompareTable
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit

@objc public protocol ZJKCompareTableMorePlugDelegate: NSObjectProtocol {
    
    /// 点击某个item项
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    ///   - index: 第几个item
    ///   - truncated: 是否被截断（用于判断是否需要展开）
    @objc optional func compareTableView(_ compareTableView: ZJKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int, is truncated: Bool, deal result: Any?)
}

open class ZJKCompareTableMorePlug: NSObject {
    
    /// 数据源
    private var datas: [ZJKCompareTableMoreModel]?
    
    /// 作为内部样式额外的事件
    public weak var delegate: ZJKCompareTableMorePlugDelegate?
    
    /// init
    public init(delegate: ZJKCompareTableMorePlugDelegate? = nil) {
        self.delegate = delegate
    }
}

extension ZJKCompareTableMorePlug: ZJKCompareTablePlug {
    
    public func prepare(with target: ZJKCompareTableView) {
        
        target.register(ZJKCompareTableIMoreItemCell.self, forCellReuseIdentifier: "ZJKCompareTableIMoreItemCell")
    }
    
    public func load(with data: Any?) {
        self.datas = data as? [ZJKCompareTableMoreModel]
    }
}

extension ZJKCompareTableMorePlug: ZJKCompareTableViewDataSource {
    
    public func numberOfSections(in compareTableView: ZJKCompareTableView) -> Int {
        return datas?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfRowsInSection section: Int) -> Int {
        return datas?[section].fields?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int {
        return datas?[indexPath.section].fields?[indexPath.row].items?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, titleForHeaderInSection section: Int) -> String? {
        return datas?[section].headerTitle
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String? {
        return datas?[indexPath.section].fields?[indexPath.row].fieldName ?? nil
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, cellForItemAt indexPath: IndexPath, to index: Int) -> ZJKCompareTableItemCell {
        
        let cell = compareTableView.dequeueReusableCell(withIdentifier: "ZJKCompareTableIMoreItemCell", for: indexPath, to: index) as! ZJKCompareTableIMoreItemCell
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

extension ZJKCompareTableMorePlug: ZJKCompareTableViewDelegate {
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int) {
        
        let ownCell = compareTableView.cellForItem(at: indexPath, to: index) as? ZJKCompareTableIMoreItemCell
        
        if (ownCell != nil) {
            let items = datas?[indexPath.section].fields?[indexPath.row].items
            self.delegate?.compareTableView?(compareTableView, didSelectRowAt: indexPath, to: index, is: !ownCell!.detailsLabel.isHidden, deal: items?[index].result)
        }
    }
}
