//
//  LKCompareTableItemReusePool.swift
//  LKCompareTable
//
//  Created by 范李林 on 2022/9/29.
//

import UIKit

class LKCompareTableItemReusePool: NSObject {

    /// 取出可重用的视图
    /// - Returns: 可重用的视图
    public func dequeueReusableView(with identifier: String) -> LKCompareTableItemCell? {
        guard let view = waitUsedPool.first as? LKCompareTableItemCell else {
            return nil
        }
        
        waitUsedPool.remove(view)
        usingPool.insert(view)
        return view
    }
        
    /// 添加正在使用的视图
    /// - Parameter view: 正在使用的视图
    public func addUsing(_ view: LKCompareTableItemCell?) {
        guard let newView = view else {
            return
        }
        usingPool.insert(newView)
    }
    
    /// 移除正在使用的视图
    /// - Parameter view: 正在使用的视图
    public func removeUsing(_ view: LKCompareTableItemCell?) {
        guard let newView = view else {
            return
        }
        
        usingPool.remove(newView)
        waitUsedPool.insert(newView)
    }
    
    /// 重置重用池
    public func resetReusePool() {
        for _ in 0..<usingPool.count {
            if let view = usingPool.first {
                usingPool.remove(view)
                waitUsedPool.insert(view)
            }
        }
    }
    
    /// 等待使用池
    private var waitUsedPool:Set<UIView> = Set()
    /// 正在使用池
    private var usingPool:Set<UIView> = Set()
}
