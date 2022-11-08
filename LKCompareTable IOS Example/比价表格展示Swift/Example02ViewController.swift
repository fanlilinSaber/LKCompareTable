//
//  Example02ViewController.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit
import SnapKit
import LKCompareTable

open class Example02ViewController: UIViewController {

    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    lazy var compareTableView: LKCompareTableView = {
        let tableView = LKCompareTableView()
        tableView.dataSource = self
        return tableView
    }()
    
    /// 测试数据
    let testData: [[LKCompareTableTest01Model]] = {
        var data = [[LKCompareTableTest01Model]]()
        
        let attrNames0 = ["商品名称"]
        
        let attrNames1 = ["商品分类商品分类商品分类商品分类", "品牌", "商品属性", "仓储地", "运距", "物流服务", "账期", "发票", "期货模式"];
        
        let attrNames2 = ["企业名称", "客户身份", "信用评分", "主营业务", "企业类型", "经营地址", "注册资本"];
        
        var array0 = [LKCompareTableTest01Model]()
        for name in attrNames0 {
            let model = LKCompareTableTest01Model()
            model.attrName = name;
            model.values = ["开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾", "2022厂家直供钢筋 /八钢/热轧带肋钢-结束", "数据展示少一点数据展示少一点数据展示少一点"];
            
            array0.append(model)
        }
        data.append(array0)
        
        var array1 = [LKCompareTableTest01Model]()
        for (index, name) in attrNames1.enumerated() {
            
            let model = LKCompareTableTest01Model()
            model.attrName = name
            model.headerTitle = "商品属性"
            
            var num: Int = Int(arc4random_uniform(3))
            var values = [String]()
            for i in 1...10 {
                var val = "第2组下的第\(index)行的第\(i)个数据"
                
                /// 加长一点
                if num == i {
                    val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                }
                values.append(val)
            }
            if name == "物流服务" {
                model.numberOfLines = 3
            }
            model.values = values
            array1.append(model)
        }
        data.append(array1)
        
        var array2 = [LKCompareTableTest01Model]()
        for (index, name) in attrNames2.enumerated() {
            
            let model = LKCompareTableTest01Model()
            model.attrName = name
            model.headerTitle = "供应商详情"
            
            var num: Int = Int(arc4random_uniform(3))
            var values = [String]()
            for i in 1...10 {
                var val = "第3组下的第\(index)行的第\(i)个数据"
                
                /// 加长一点
                if num == i {
                    val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                }
                values.append(val)
            }
            
            model.values = values
            array2.append(model)
        }
        data.append(array2)
        
        return data
    }()
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    // MARK: - ***** Lifecycle *****
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        layoutPageSubviews()
        
        compareTableView.reloadData()
    }
    
    func addSubviews() {
        view.addSubview(compareTableView)
    }
    
    func layoutPageSubviews() {
        compareTableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Protocol *****
    
    // MARK: - ***** Create Method *****

}

// MARK: - LKCompareTableViewDataSource
extension Example02ViewController: LKCompareTableViewDataSource {
    
    public func numberOfSections(in compareTableView: LKCompareTableView) -> Int {
        
        return testData.count
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, numberOfRowsInSection section: Int) -> Int {
        
        return testData[section].count
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int {
    
        return testData[indexPath.section][indexPath.row].values?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 { return "商品属性"}
        else if section == 2 { return "供应商详情"}
        
        return nil
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String? {
        
        return testData[indexPath.section][indexPath.row].attrName
    }
    
    public func compareTableView(_ compareTableView: LKCompareTableView, numberOfLinesForRowAt indexPath: IndexPath) -> Int {
        
        return testData[indexPath.section][indexPath.row].numberOfLines
    }

    public func compareTableView(_ compareTableView: LKCompareTableView, textForItemAt indexPath: IndexPath, to index: Int) -> String? {
        
        guard let values = testData[indexPath.section][indexPath.row].values else {
            return nil
        }
        
        return values[index]
    }
}
