//
//  Example03ViewController.swift
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/9/28.
//

import UIKit
import SnapKit
import ZJKCompareTable

class Example03ViewController: UIViewController {

    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    lazy var compareTableView: ZJKCompareTableView = {
        let tableView = ZJKCompareTableView()
        
        tableView.register(ZJKCompareTableItemTest01Cell.self, forCellReuseIdentifier: "ZJKCompareTableItemTest01Cell")
        tableView.register(ZJKCompareTableItemTest02Cell.self, forCellReuseIdentifier: "ZJKCompareTableItemTest02Cell")
        tableView.register(ZJKCompareTableItemTest03Cell.self, forCellReuseIdentifier: "ZJKCompareTableItemTest03Cell")
        
        tableView.register(ZJKCompareTableTest01HeaderView.self, forHeaderFooterViewReuseIdentifier: "ZJKCompareTableTest01HeaderView")
        
        tableView.register(ZJKCompareTableFieldView.self, forFieldReuseIdentifier: "ZJKCompareTableFieldView")
        tableView.register(ZJKCompareTableTest01FieldView.self, forFieldReuseIdentifier: "ZJKCompareTableTest01FieldView")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pinHeaderDataSource = self
        tableView.headerDataSource = self
        return tableView
    }()
    
    
    /// 测试数据
    let testData: [ZJKCompareTableMoreModel] = {
        var data = [ZJKCompareTableMoreModel]()
        
        let attrNames1 = ["商品名称"]
        
        let attrNames2 = ["商品分类商品分类商品分类商品分类", "品牌", "商品属性", "仓储地", "运距", "物流服务", "账期", "发票", "期货模式"];
        
        let attrNames3 = ["企业名称", "客户身份", "信用评分", "主营业务", "企业类型", "经营地址", "注册资本"];
        

        let model01 = ZJKCompareTableMoreModel()
        /// 添加属性测试数据
        model01.makeFieldModel(with: attrNames1.count) { index, attr in
            attr.fieldName = attrNames1[index]
        
            /// 添加item测试数据
            attr.makeItemModel(with: 8) { itemIndex, item in
                if itemIndex == 0 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                else if itemIndex == 1 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                else if itemIndex == 2 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
            }
        }
        data.append(model01)
        
        let model02 = ZJKCompareTableMoreModel()
        model02.headerTitle = "商品属性"
        /// 添加属性测试数据
        model02.makeFieldModel(with: attrNames2.count) { index, attr in
            attr.fieldName = attrNames2[index]
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(8))
            attr.makeItemModel(with: 8) { itemIndex, item in
                var val = "第2组下的第\(index)行的第\(itemIndex)个项数据"
                
                /// 加长一点测试
                if num == itemIndex {
                    val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                }
                item.text = val
                
            }
            
            /// 指定某一项字段换行数
            if attr.fieldName == "物流服务" {
                attr.numberOfLines = 3
            }
        }
        data.append(model02)
        
        let model03 = ZJKCompareTableMoreModel()
        model03.headerTitle = "供应商详情"
        
        /// 添加属性测试数据
        model03.makeFieldModel(with: attrNames3.count) { index, attr in
            attr.fieldName = attrNames3[index]
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(8))
            attr.makeItemModel(with: 8) { itemIndex, item in
                var val = "第3组下的第\(index)行的第\(itemIndex)项数据"
                
                /// 加长一点测试
                if num == itemIndex {
                    val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                }
                item.text = val
                
            }

        }
        data.append(model03)
        
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

// MARK: - ZJKCompareTableViewDataSource
extension Example03ViewController: ZJKCompareTableViewDataSource {
    
    public func numberOfSections(in compareTableView: ZJKCompareTableView) -> Int {
        
        return testData.count
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfRowsInSection section: Int) -> Int {
        
        return testData[section].fields?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int {
    
        return testData[indexPath.section].fields?[indexPath.row].items?.count ?? 0
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, titleForHeaderInSection section: Int) -> String? {
        
//        if section == 1 { return "商品属性"}
//        else if section == 2 { return "供应商详情"}
        
        return testData[section].headerTitle
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String? {
        
        return testData[indexPath.section].fields?[indexPath.row].fieldName
    }
    
    public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfLinesForRowAt indexPath: IndexPath) -> Int {
        
        return testData[indexPath.section].fields?[indexPath.row].numberOfLines ?? 0
    }
    
    func compareTableView(_ compareTableView: ZJKCompareTableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = compareTableView.dequeueReusableHeaderFooterView(withIdentifier: "ZJKCompareTableTest01HeaderView") as? ZJKCompareTableTest01HeaderView
        header?.titleLabel.text = testData[section].headerTitle
        return header
    }
    
    func compareTableView(_ compareTableView: ZJKCompareTableView, cellForItemAt indexPath: IndexPath, to index: Int) -> ZJKCompareTableItemCell {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            
            if index == 0 {
                let cell = compareTableView.dequeueReusableCell(withIdentifier: "ZJKCompareTableItemTest03Cell", for: indexPath, to: index) as! ZJKCompareTableItemTest03Cell
                cell.valueLabel.text = "自定义cell类型三"
                return cell
            }
            
            let cell = compareTableView.dequeueReusableCell(withIdentifier: "ZJKCompareTableItemTest02Cell", for: indexPath, to: index) as! ZJKCompareTableItemTest02Cell
            cell.valueLabel.text = "自定义cell类型二"
            cell.valueLabel.textColor = .brown
            return cell
        }
        
        let cell = compareTableView.dequeueReusableCell(withIdentifier: "ZJKCompareTableItemTest01Cell", for: indexPath, to: index) as! ZJKCompareTableItemTest01Cell
        let items = testData[indexPath.section].fields?[indexPath.row].items
        cell.text = items?[index].text
        return cell
    }
    
    func compareTableView(_ compareTableView: ZJKCompareTableView, viewForFieldAt indexPath: IndexPath) -> ZJKCompareTableFieldView! {
        
        if indexPath.section == 1 && indexPath.row == 1 {
            let field = compareTableView.dequeueReusableField(withIdentifier: "ZJKCompareTableTest01FieldView", for: indexPath) as! ZJKCompareTableTest01FieldView
            field.titleLabel.text = "自定义field类型一"
            return field
        }
        let field = compareTableView.dequeueReusableField(withIdentifier: "ZJKCompareTableFieldView", for: indexPath)
        field.textLabel.text = testData[indexPath.section].fields?[indexPath.row].fieldName
        return field
    }
    
//    func compareTableView(_ compareTableView: ZJKCompareTableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        return 50
//    }

}


extension Example03ViewController: ZJKCompareTableViewPinHeaderDataSource {
    
    func viewForPinHeaderField(in compareTableView: ZJKCompareTableView) -> UIView? {
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.text = "隐藏相同"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        contentView.addSubview(label);
        
        let hideSwitch = UISwitch()
        contentView.addSubview(hideSwitch);
        
        hideSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.right.lessThanOrEqualTo(-9)
            make.left.lessThanOrEqualTo(9)
            make.top.equalTo(hideSwitch.snp.bottom).offset(10)
            make.bottom.lessThanOrEqualTo(-9)
        }
        
        return contentView
    }
    
    func compareTableView(_ compareTableView: ZJKCompareTableView, viewForPinHeaderItemsAt index: Int) -> UIView {
        
        let label = UILabel()
        label.text = "卡罗拉 2022款 双擎1.8L E-CVT先锋版"
        if index == 1 {
            label.text = "卡罗拉 2022款 双擎1.8L E-CVT先锋版 测试很长的文本测试很长的文本测试很长的文本测试很长的文本测试很长的文本测试很长的文本自适应"
        }
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0;
        
        return label
    }
    
    func heightForPinHeader(in compareTableView: ZJKCompareTableView) -> CGFloat {
//        return 120
        /// 自适应
        return ZJKCompareTableView.automaticDimension
    }
}

extension Example03ViewController: ZJKCompareTableViewHeaderDataSource {
    
    func viewForHeader(in compareTableView: ZJKCompareTableView) -> UIView? {
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor(red: 1, green: 0.97, blue: 0.9, alpha: 1)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        let icon = UIImageView()
        icon.image = UIImage(named: "zhuyi")
        contentView.addSubview(icon)
        
        let label = UILabel()
        label.text = "数据仅供参考，具体以供应商接单为准"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(red: 1, green: 0.75, blue: 0, alpha: 1)
        contentView.addSubview(label)
        
        icon.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        return contentView
    }
}

extension Example03ViewController: ZJKCompareTableViewDelegate {
    
    func compareTableView(_ compareTableView: ZJKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int) {
        
        print("点击了第\(indexPath.section)组下的第\(indexPath.row)行的第\(index)个")
    }
}

