//
//  Example04ViewController.swift
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/7.
//

import UIKit
import SnapKit
import LKCompareTable

class Example04ViewController: UIViewController {

    // MARK: - ***** Public method *****
    
    // MARK: - ***** Ivars *****
    
    lazy var compareTableView: LKCompareTableView = {
        let tableView = LKCompareTableView(frame: .zero, headerStyle: .follow)
        tableView.register(LKCompareTableItemTest01Cell.self, forCellReuseIdentifier: "LKCompareTableItemTest01Cell")
        tableView.dataSourcePlug = LKCompareTableMorePlug(delegate: self)
        tableView.delegate = self
        tableView.headerDataSource = self
        tableView.displayCount = 5
        return tableView
    }()

    var flag: Bool = false
    
    /// 测试数据
    let testData: [LKCompareTableMoreModel] = {
        var data = [LKCompareTableMoreModel]()
        
        let attrNames1 = ["商品名称"]
        
        let attrNames2 = ["商品分类商品分类商品分类商品分类", "商品价格", "品牌", "商品属性", "仓储地", "运距", "物流服务", "账期", "发票", "期货模式"];
        
        let attrNames3 = ["企业名称", "客户身份", "信用评分", "主营业务", "企业类型", "经营地址", "注册资本"];
        

        let model01 = LKCompareTableMoreModel()
        /// 添加属性测试数据
        model01.makeFieldModel(with: attrNames1.count) { index, attr in
            attr.fieldName = attrNames1[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            attr.makeItemModel(with: 8) { itemIndex, item in
                if itemIndex == 0 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 1 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 2 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 3 { item.text = "/"}
            }
        }
        data.append(model01)
        
        let model02 = LKCompareTableMoreModel()
        model02.headerTitle = "商品属性"
        /// 添加属性测试数据
        model02.makeFieldModel(with: attrNames2.count) { index, attr in
            attr.fieldName = attrNames2[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(8))
            var values = [String]()
        
            attr.makeItemModel(with: 8) { itemIndex, item in
                
                if attr.fieldName == "商品价格" {
//                    item.text = "¥3400.00/吨"
                    
                    let price = "¥3400.00/吨"
                    let suffix = "详情>"
                    let lineBreaks = "\n"
                    let string = price + lineBreaks + suffix
                    
                    let priceAttributes = [.foregroundColor: UIColor(red: 0.94, green: 0.25, blue: 0.2, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .regular)] as [NSAttributedString.Key : Any]
                    
                    let suffixAttributes = [.foregroundColor: UIColor(red: 0.34, green: 0.57, blue: 0.99, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .regular)] as [NSAttributedString.Key : Any]
                    
                    let attString = NSMutableAttributedString(string: string)
                    attString.addAttributes(priceAttributes, range: NSRange(location: 0, length: price.count))
                    attString.addAttributes(suffixAttributes, range: NSRange(location: price.count + lineBreaks.count, length: suffix.count))
                    item.attributedText = attString
                }else {
                    var val = "第2组下的第\(index)行的第\(itemIndex)个数据"
                    
                    /// 加长一点测试
                    if num == itemIndex {
                        val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                    }
                    item.text = val
                }
                
                if index == 2 && itemIndex == 3 { item.text = "/"}
            }
            
            /// 指定某一项字段换行数
            if attr.fieldName == "物流服务" {
                attr.numberOfLines = 3
            }
        }
        data.append(model02)
        
        let model03 = LKCompareTableMoreModel()
        model03.headerTitle = "供应商详情"
        
        /// 添加属性测试数据
        model03.makeFieldModel(with: attrNames3.count) { index, attr in
            attr.fieldName = attrNames3[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(8))
            var values = [String]()
            attr.makeItemModel(with: 8) { itemIndex, item in
                var val = "第3组下的第\(index)行的第\(itemIndex)个数据"
                
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
    
    /// 测试数据
    let test2Data: [LKCompareTableMoreModel] = {
        var data = [LKCompareTableMoreModel]()
        
        let attrNames1 = ["商品名称"]
        
        let attrNames2 = ["商品分类商品分类商品分类商品分类", "商品价格", "品牌", "商品属性", "仓储地", "运距", "物流服务", "账期", "发票", "期货模式"];
        
        let attrNames3 = ["企业名称", "客户身份", "信用评分", "主营业务", "企业类型", "经营地址", "注册资本"];
        

        let model01 = LKCompareTableMoreModel()
        /// 添加属性测试数据
        model01.makeFieldModel(with: attrNames1.count) { index, attr in
            attr.fieldName = attrNames1[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            attr.makeItemModel(with: 2) { itemIndex, item in
                if itemIndex == 0 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 1 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 2 { item.text = "开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"}
                if itemIndex == 3 { item.text = "/"}
            }
        }
        data.append(model01)
        
        let model02 = LKCompareTableMoreModel()
        model02.headerTitle = "商品属性"
        /// 添加属性测试数据
        model02.makeFieldModel(with: attrNames2.count) { index, attr in
            attr.fieldName = attrNames2[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(2))
            var values = [String]()
        
            attr.makeItemModel(with: 2) { itemIndex, item in
                
                if attr.fieldName == "商品价格" {
//                    item.text = "¥3400.00/吨"
                    
                    let price = "¥3400.00/吨"
                    let suffix = "详情>"
                    let lineBreaks = "\n"
                    let string = price + lineBreaks + suffix
                    
                    let priceAttributes = [.foregroundColor: UIColor(red: 0.94, green: 0.25, blue: 0.2, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .regular)] as [NSAttributedString.Key : Any]
                    
                    let suffixAttributes = [.foregroundColor: UIColor(red: 0.34, green: 0.57, blue: 0.99, alpha: 1), .font: UIFont.systemFont(ofSize: 12, weight: .regular)] as [NSAttributedString.Key : Any]
                    
                    let attString = NSMutableAttributedString(string: string)
                    attString.addAttributes(priceAttributes, range: NSRange(location: 0, length: price.count))
                    attString.addAttributes(suffixAttributes, range: NSRange(location: price.count + lineBreaks.count, length: suffix.count))
                    item.attributedText = attString
                }else {
                    var val = "第2组下的第\(index)行的第\(itemIndex)个数据"
                    
                    /// 加长一点测试
                    if num == itemIndex {
                        val += "加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"
                    }
                    item.text = val
                }
                
                if index == 2 && itemIndex == 3 { item.text = "/"}
            }
            
            /// 指定某一项字段换行数
            if attr.fieldName == "物流服务" {
                attr.numberOfLines = 3
            }
        }
        data.append(model02)
        
        let model03 = LKCompareTableMoreModel()
        model03.headerTitle = "供应商详情"
        
        /// 添加属性测试数据
        model03.makeFieldModel(with: attrNames3.count) { index, attr in
            attr.fieldName = attrNames3[index]
            attr.contentAlignment = .centerLeft
            
            /// 添加item测试数据
            var num: Int = Int(arc4random_uniform(2))
            var values = [String]()
            attr.makeItemModel(with: 2) { itemIndex, item in
                var val = "第3组下的第\(index)行的第\(itemIndex)个数据"
                
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试增删", style: .plain, target: self, action: #selector(rightBarButtonEvent))
        
        addSubviews()
        layoutPageSubviews()
        
        /// next
        compareTableView.datas = test2Data
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
    
    @objc func rightBarButtonEvent() {
        
        flag = !flag
        if flag {
            /// next
            compareTableView.datas = testData
        }else {
            /// next
            compareTableView.datas = test2Data
        }
    }
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Protocol *****
    
    // MARK: - ***** Create Method *****
    
}

extension Example04ViewController: LKCompareTableViewHeaderDataSource {
    
    func viewForHeader(in compareTableView: LKCompareTableView) -> UIView? {
        
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

extension Example04ViewController: LKCompareTableViewDelegate {
    
    func compareTableView(_ compareTableView: LKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int) {
        
        print("点击了第\(indexPath.section)组下的第\(indexPath.row)行的第\(index)个")
    }
}

extension Example04ViewController: LKCompareTableMorePlugDelegate {
    
    func compareTableView(_ compareTableView: LKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int, is truncated: Bool, deal result: Any?) {
        
        if truncated {
            
            let alert = UIAlertController(title: "提示", message: "需要查看更多", preferredStyle: .alert)
            let good = UIAlertAction(title: "好的", style: .default)
            alert.addAction(good)
            
            present(alert, animated: true)
            
            print("需要查看更多")
        }
    }
}
