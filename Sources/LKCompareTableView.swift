//
//  LKCompareTableView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit

@objc
public protocol LKCompareTableViewDelegate: NSObjectProtocol {
    
    /// 点击某个item项
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    ///   - index: 第几个item
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, didSelectRowAt indexPath: IndexPath, to index: Int)
    
    /// 内部scrollView滚动回调
    /// - Parameter scrollView: 包含了垂直滑动的UITableView 和 水平滑动的UIScrollView
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
}

@objc
public protocol LKCompareTableViewDataSource: NSObjectProtocol {
    
    /// 返回分组数量
    /// - Parameter compareTableView: compareTableView
    /// - Returns: 分组数量
    func numberOfSections(in compareTableView: LKCompareTableView) -> Int
    
    /// 返回某一分组下的行数
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - section: 第几组
    /// - Returns: 行数
    func compareTableView(_ compareTableView: LKCompareTableView, numberOfRowsInSection section: Int) -> Int
    
    /// 返回某一行下的item数量
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    /// - Returns: item数量
    func compareTableView(_ compareTableView: LKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int
    
    /// 返回分组标题
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - section: 第几组
    /// - Returns: 标题
    func compareTableView(_ compareTableView: LKCompareTableView, titleForHeaderInSection section: Int) -> String?
    
    /// 返回自定义Header视图
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - section: 第几组
    /// - Returns: 自定义Header视图
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, viewForHeaderInSection section: Int) -> UIView?
    
    /// 返回某一行的字段名
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    /// - Returns: 属性名
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String?
    
    /// 返回某一行内容展示的最大换行数 （默认 = 0，不限制）
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    /// - Returns: 换行数
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, numberOfLinesForRowAt indexPath: IndexPath) -> Int
    
    /// 返回某个item项的内容
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    ///   - index: 第几个item
    /// - Returns: 内容
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, textForItemAt indexPath: IndexPath, to index: Int) -> String?
    
    /// 返回自定义item项
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    ///   - index: 第几个item
    /// - Returns: 自定义view（注意要用自动布局约束撑开父视图）
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, cellForItemAt indexPath: IndexPath, to index: Int) -> LKCompareTableItemCell
    
    /// 返回某个分组标题栏高度； 默认 = 32
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - section: 第几个分组
    /// - Returns: 高度
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, heightForHeaderInSection section: Int) -> CGFloat
    
    /// 返回某一行的高度（默认 = automaticDimension）
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    /// - Returns: 高度
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    /// 返回自定义FieldView
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - indexPath: 分组和行数
    /// - Returns: FieldView
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, viewForFieldAt indexPath: IndexPath) -> LKCompareTableFieldView!
}

/// 悬浮HeaderView代理
@objc
public protocol LKCompareTableViewPinHeaderDataSource: NSObjectProtocol {
    
    /// 返回悬浮View的高度（默认 = automaticDimension）
    /// - Parameter compareTableView: compareTableView
    /// - Returns: 高度
    @objc optional func heightForPinHeader(in compareTableView: LKCompareTableView) -> CGFloat
    
    /// 返回HeaderView的字段栏显示
    /// - Parameter compareTableView: compareTableView
    /// - Returns: 自定义Field View
    @objc optional func viewForPinHeaderField(in compareTableView: LKCompareTableView) -> UIView?
    
    /// 返回悬浮HeaderView的item view显示
    /// - Parameters:
    ///   - compareTableView: compareTableView
    ///   - index: 第几个item
    /// - Returns: 自定义 item view
    @objc optional func compareTableView(_ compareTableView: LKCompareTableView, viewForPinHeaderItemsAt index: Int) -> UIView
    
    /// 返回自定义悬浮HeaderView（如果实现了自定义上面两个协议方法失效）
    /// - Parameter compareTableView: compareTableView
    /// - Returns: 返回悬浮HeaderView
    @objc optional func viewForPinHeader(in compareTableView: LKCompareTableView) -> UIView?
}

/// HeaderView代理
@objc
public protocol LKCompareTableViewHeaderDataSource: NSObjectProtocol {
    
    /// 返回自定义HeaderView
    /// - Parameter compareTableView: compareTableView
    /// - Returns: 自定义View
    @objc optional func viewForHeader(in compareTableView: LKCompareTableView) -> UIView?
}

extension LKCompareTableView {

    /// Section Header 样式
    @objc public enum HeaderStyle : Int, @unchecked Sendable {
        /// 自动悬浮在顶部（默认的）
        case suspending = 0
        /// 跟随滑动
        case follow = 1
    }
    
    /// 悬浮 HeaderView 样式
    @objc public enum PinHeaderStyle : Int, @unchecked Sendable {
        /// 固定在顶部（默认的）
        case fixed = 0
        /// 跟随列表的边缘反弹回来
        case bounces = 1
    }
    
    public static let automaticDimension: CGFloat = UITableView.automaticDimension
}

@objcMembers
open class LKCompareTableView: UIView {

    // MARK: - ***** Public method *****
    
    open func reloadData() {
        
        dequeuePool.removeAllObjects()
        reloadPinHeader()
        reloadHeader()
        tableView.reloadData()
        updatePinHeaderLayout()
    }
    
    /// 注册对应的fieldClass
    /// - Parameters:
    ///   - fieldClass: 继承于`LKCompareTableFieldView`class
    ///   - identifier: 唯一标识符
    public func register(_ fieldClass: AnyClass, forFieldReuseIdentifier identifier: String) {

        assert(fieldClass.isSubclass(of: LKCompareTableFieldView.self), "FieldClass Must Inherited From LKCompareTableFieldView")
        fieldClassPool[identifier] = fieldClass
    }
    
    /// 注册对应的cellClass
    /// - Parameters:
    ///   - cellClass: 继承于`LKCompareTableItemCell`class
    ///   - identifier: 唯一标识符
    public func register(_ cellClass: AnyClass, forCellReuseIdentifier identifier: String) {

        assert(cellClass.isSubclass(of: LKCompareTableItemCell.self), "CellClass Must Inherited From LKCompareTableItemCell")
        cellClassPool[identifier] = cellClass
    }
    
    /// 注册对应的HeaderFooterView class
    /// - Parameters:
    ///   - aClass: 继承于`LKCompareTableHeaderFooterView`class
    ///   - identifier: 唯一标识符
    public func register(_ aClass: AnyClass, forHeaderFooterViewReuseIdentifier identifier: String) {

        assert(aClass.isSubclass(of: LKCompareTableHeaderFooterView.self), "aClass Must Inherited From LKCompareTableHeaderFooterView")
        tableView.register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 出列自定义itemCell
    /// - Parameters:
    ///   - identifier: 唯一标识符
    ///   - indexPath: 路径
    /// - Returns: 继承于`LKCompareTableItemCell`的实例
    public func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath, to index: Int) -> LKCompareTableItemCell {
        
        guard let cell = dequeuePool.object(forKey: indexPath as NSIndexPath) else {
            assertionFailure("请在代理方法‘compareTableView(_:cellForItemAt:to:)中使用’")
            return LKCompareTableItemCell(style: .default, reuseIdentifier: identifier)
        }
        
        var itemCell = cell.cellForItem(at: index)
        if itemCell == nil || itemCell?.reuseIdentifier != identifier {
            let cellClass = cellClassPool[identifier] as? LKCompareTableItemCell.Type
            assert((cellClass != nil), "未注册对应的cellClass")
            itemCell = cellClass!.init(style: .default, reuseIdentifier: identifier)
        }
        return itemCell!
    }
    
    /// 出列自定义HeaderFooterView
    /// - Parameter identifier: 唯一标识符
    /// - Returns: 继承于`dequeueReusableHeaderFooterView`的实例
    public func dequeueReusableHeaderFooterView(withIdentifier identifier: String) -> LKCompareTableHeaderFooterView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? LKCompareTableHeaderFooterView
    }
    
    /// 出列自定义FieldView
    /// - Parameters:
    ///   - identifier: 唯一标识符
    ///   - indexPath: 路径
    /// - Returns: 继承于`LKCompareTableFieldView`的实例
    public func dequeueReusableField(withIdentifier identifier: String, for indexPath: IndexPath) -> LKCompareTableFieldView {

        guard let cell = dequeuePool.object(forKey: indexPath as NSIndexPath) else {
            assertionFailure("请在代理方法‘compareTableView(_:viewForFieldAt:)中使用’")
            return LKCompareTableFieldView(style: .default, reuseIdentifier: identifier)
        }
        
        var field = cell.fieldView
        if field == nil || field?.reuseIdentifier != identifier {
            let fieldClass = fieldClassPool[identifier] as? LKCompareTableFieldView.Type
            assert((fieldClass != nil), "未注册对应的fieldClass")
            field = fieldClass!.init(style: .default, reuseIdentifier: identifier)
        }
        return field!
    }
    
    /// 返回对应的ItemCell
    /// - Parameters:
    ///   - indexPath: 分组和行数
    ///   - index: 第几个
    /// - Returns: LKCompareTableItemCell
    public func cellForItem(at indexPath: IndexPath, to index: Int) -> LKCompareTableItemCell? {
        guard let cell = tableView.cellForRow(at: indexPath) as? LKCompareTableCell else {
            return nil
        }
        let itemCell = cell.cellForItem(at: index);
        return itemCell
    }
    
    // MARK: - ***** Ivars *****
    
    private let cellIdentifier = "LKCompareTableCell"
    private let headerIdentifier = "LKCompareTableHeaderView"
    private let itemCellIdentifier = "LKCompareTableItemCell"
    private let fieldViewIdentifier = "LKCompareTableFieldView"
    
    public private(set) lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: (headerStyle == .suspending) ? .plain : .grouped)
        tableView.register(LKCompareTableCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        if #available(iOS 11.0, *)  { tableView.contentInsetAdjustmentBehavior = .never }
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 }
        if headerStyle == .follow { tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
        tableView.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private(set) var pinHeader: UIView?
    
    /// 设置数据源（必须设置dataSourceAgent != custom才有效）
    public var datas: [AnyObject]? {
        didSet {
            if dataSourcePlug == nil {
                assertionFailure("请使用`dataSource`协议下的方法自己实现绑定数据")
            } else if (dataSourcePlug!.isKind(of: LKCompareTableMorePlug.self)) {
                dataSourcePlug?.load(with: datas)
            }
            
            reloadData()
        }
    }
    
    public var dataSourcePlug: (LKCompareTableViewDataSource & LKCompareTablePlug)?{
        didSet {
            dataSource = dataSourcePlug
            plugDelegate = dataSourcePlug as? LKCompareTableViewDelegate
            dataSourcePlug?.prepare(with: self)
        }
    }
    
    /// 每个itemCell的宽度（设置 = LKCompareTableView.automaticDimension，每一行的的cell单独自定义宽度）
    open var itemCellWidth: CGFloat = 120.0
    /// 左边属性栏的宽度（设置 = LKCompareTableView.automaticDimension，每一行的属性栏单独自定义宽度）
    open var fieldWidth: CGFloat = 68.0
    /// 用于占位补充显示数量；如： displayCount = 5，纵向列数实际数据只有3列，会补充2列空白显示
    open var displayCount: Int = 0
    /// HeaderView DataSource
    open weak var headerDataSource: LKCompareTableViewHeaderDataSource?
    /// 悬浮 HeaderView DataSource
    open weak var pinHeaderDataSource: LKCompareTableViewPinHeaderDataSource?
    /// 列表数据源 DataSource
    weak open var dataSource: LKCompareTableViewDataSource?
    /// 列表代理
    weak open var delegate: LKCompareTableViewDelegate?
    /// 悬浮 HeaderView 样式; 如果设置了
    open var pinHeaderStyle: PinHeaderStyle = .fixed
    /// HeaderView 背景颜色
    open var headerColor: UIColor = .clear {
        didSet {
            tableView.tableHeaderView?.backgroundColor = headerColor
        }
    }
    /// 复用cell池
    private var resuelPool = LKCompareTableItemReusePool()
    /// 注册cell类型池
    private var cellClassPool = [String: AnyClass]()
    /// 注册field类型池
    private var fieldClassPool = [String: AnyClass]()
    /// tableView celli已经出列的缓存池
    private var dequeuePool = NSMapTable<NSIndexPath, LKCompareTableCell>(keyOptions: .weakMemory, valueOptions: .weakMemory)
    /// 水平滚动视图的最后一次偏移量
    private var lastContentOffsetX: CGFloat = 0.0

    private weak var plugDelegate: LKCompareTableViewDelegate?
    
    private var headerStyle: HeaderStyle = .suspending

    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    public init(frame: CGRect, headerStyle: HeaderStyle) {
        super.init(frame: frame)
        self.headerStyle = headerStyle
        initConfig()
        
        /// add view
        addSubview(tableView)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initConfig()
        
        /// add view
        addSubview(tableView)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****

    // MARK: - ***** Update view *****
    
    func updatePinHeaderLayout() {
                
        /// 自定义HeaderView
        guard let pinView = pinHeader else {
            tableView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            return
        }

        let pinHeight = pinHeaderDataSource?.heightForPinHeader?(in: self) ?? LKCompareTableView.automaticDimension
        if pinView.superview != self {
            addSubview(pinView)
        }

        pinView.snp.makeConstraints({ make in
            make.left.right.equalTo(self.safeAreaLayoutGuide)
            make.top.equalToSuperview()
            if pinHeight != LKCompareTableView.automaticDimension {
                make.height.equalTo(pinHeight);
            }
        })

        tableView.snp.remakeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(pinView.snp.bottom)
        }
    }
    
    // MARK: - ***** Private method *****
    
    func initConfig() {
        register(LKCompareTableItemCell.self, forCellReuseIdentifier: itemCellIdentifier)
        register(LKCompareTableFieldView.self, forFieldReuseIdentifier: fieldViewIdentifier)
        register(LKCompareTableHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier)
    }
    
    func reloadHeader() {
        if headerDataSource == nil { return }
        /// 自定义悬浮HeaderView
        if (headerDataSource!.responds(to: #selector(LKCompareTableViewHeaderDataSource.viewForHeader(in:)))) {
            
            guard let view = headerDataSource?.viewForHeader?(in: self) else {
                return
            }
            view.layoutIfNeeded()
            
            let headerView = UIView()
            headerView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: view.frame.height)
            headerView.addSubview(view)
            view.snp.makeConstraints { make in
                make.left.right.equalTo(headerView.safeAreaLayoutGuide);
                make.bottom.top.equalToSuperview()
            }
            headerView.backgroundColor = headerColor
            tableView.tableHeaderView = headerView
        }
    }
        
    func reloadPinHeader() {

        if pinHeaderDataSource == nil { return }
        /// 自定义悬浮HeaderView
        if (pinHeaderDataSource!.responds(to: #selector(LKCompareTableViewPinHeaderDataSource.viewForPinHeader(in:)))) {
            
            pinHeader = pinHeaderDataSource?.viewForPinHeader?(in: self)
        } else {
            
            var pinView: LKCompareTablePinHeaderView {
                get {
                    if pinHeader == nil {
                        pinHeader = LKCompareTablePinHeaderView()
                        (pinHeader as! LKCompareTablePinHeaderView).scrollViewDelegate = self
                    }
                    return pinHeader as! LKCompareTablePinHeaderView
                }
            }
            
            if (pinHeaderDataSource!.responds(to: #selector(LKCompareTableViewPinHeaderDataSource.viewForPinHeaderField(in:)))) {
                
                /// 关联悬浮视图-属性栏view
                pinView.setAttrContent(with: pinHeaderDataSource!.viewForPinHeaderField?(in: self))
            }
            
            if (pinHeaderDataSource!.responds(to: #selector(LKCompareTableViewPinHeaderDataSource.compareTableView(_:viewForPinHeaderItemsAt:)))) {
                
                /// 关联悬浮视图-Item
                let number = dataSource?.compareTableView(self, numberOfItemsAt: NSIndexPath.init(row: 0, section: 0) as IndexPath) ?? 0

                pinView.setItemCell(with: number, itemCellWidth: itemCellWidth) { index in
                    let itemCell = pinHeaderDataSource!.compareTableView?(self, viewForPinHeaderItemsAt: index)
                    return itemCell
                }
            }
        }
    }
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Create method *****
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LKCompareTableView: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource?.numberOfSections(in: self) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource?.compareTableView(self, numberOfRowsInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LKCompareTableCell
        
        /// 加入缓存池
        dequeuePool.setObject(cell, forKey: indexPath as NSIndexPath)
        
        cell.contentOffset = CGPoint(x: lastContentOffsetX, y: 0)
        
        let number = dataSource?.compareTableView(self, numberOfItemsAt: indexPath) ?? 0
        
        /// 如果实现了自定义字段栏协议优先自定义
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(LKCompareTableViewDataSource.compareTableView(_:viewForFieldAt:))))! {
            
            cell.setFieldView(with: fieldWidth, field: dataSource!.compareTableView!(self, viewForFieldAt: indexPath))
        } else {
            let field = dequeueReusableField(withIdentifier: fieldViewIdentifier, for: indexPath)
            field.textLabel.text = dataSource?.compareTableView?(self, fieldNameForRowAt: indexPath)
            cell.setFieldView(with: fieldWidth, field: field)
        }
        
        /// 如果实现了自定义cell协议优先自定义
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(LKCompareTableViewDataSource.compareTableView(_:cellForItemAt:to:))))! {
            
            cell.setItemCell(with: (number > displayCount) ? number : displayCount, itemCellWidth: itemCellWidth) { [weak self] index in
                guard let self = self else { return nil }
                if self.displayCount > 0 && index >= number {
                    return UIView()
                }
                let itemCell = dataSource!.compareTableView!(self, cellForItemAt: indexPath, to: index)
                return itemCell
            }
            
        } else {
            /// 默认的cell
            cell.setItemCell(with: number, itemCellWidth: itemCellWidth) { [weak self] index in
                guard let self = self else { return nil }
                let itemCell = dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath, to: index)
                itemCell.textLabel.text = dataSource?.compareTableView?(self, textForItemAt: indexPath, to: index) ?? ""
                itemCell.textLabel.numberOfLines = dataSource?.compareTableView?(self, numberOfLinesForRowAt: indexPath) ?? 0
                return itemCell
            }
        }
        
        cell.didSelectIndexBlock { [weak self] index, itemCell in
            guard let self = self else { return }
            self.delegate?.compareTableView?(self, didSelectRowAt: indexPath, to: index)
            self.plugDelegate?.compareTableView?(self, didSelectRowAt: indexPath, to: index)
        }
        
        cell.scrollViewDelegate = self
        cell.mainScrollView.contentOffset = CGPoint(x: lastContentOffsetX, y: 0)
        
        /// 是最后一个元素隐藏底部的分割线
        cell.bottomLineView.isHidden = !(indexPath.row == self.tableView(tableView, numberOfRowsInSection: indexPath.section) - 1)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(LKCompareTableViewDataSource.compareTableView(_:viewForHeaderInSection:))))! {
            
            return self.dataSource!.compareTableView!(self, viewForHeaderInSection: section)
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! LKCompareTableHeaderFooterView
        header.titleLabel.text = dataSource?.compareTableView(self, titleForHeaderInSection: section)
        return header
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(LKCompareTableViewDataSource.compareTableView(_:heightForHeaderInSection:))))! {
            
            return self.dataSource!.compareTableView!(self, heightForHeaderInSection: section)
        }
        
        guard (dataSource?.compareTableView(self, titleForHeaderInSection: section)) != nil else {
            return CGFloat.leastNormalMagnitude
        }
        return 32
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.dataSource != nil && (self.dataSource?.responds(to: #selector(LKCompareTableViewDataSource.compareTableView(_:heightForRowAt:))))! {
            
            return self.dataSource!.compareTableView!(self, heightForRowAt: indexPath)
        }
        
        return UITableView.automaticDimension
    }
}

// MARK: - UIScrollViewDelegate
extension LKCompareTableView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        plugDelegate?.scrollViewDidScroll?(scrollView)
        if scrollView.tag == 985 {
            
            if scrollView.contentSize.equalTo(.zero) { return }

            /// 更新cell中的 ScrollView contentOffset
            for case let cell as LKCompareTableCell in tableView.visibleCells {
                if cell.mainScrollView == scrollView { continue }
                cell.mainScrollView.contentOffset = scrollView.contentOffset
            }
            
            /// 如果有悬浮Header 更新悬浮Header中的 ScrollView contentOffset
            if pinHeader != nil && pinHeader!.isKind(of: LKCompareTablePinHeaderView.self) {
                let pinView = pinHeader as! LKCompareTablePinHeaderView
                if pinView.mainScrollView == scrollView { return }
                pinView.mainScrollView.contentOffset = scrollView.contentOffset
            }
            
            lastContentOffsetX = scrollView.contentOffset.x
        } else if (scrollView == tableView) {
            
            guard let pinView = pinHeader as? LKCompareTablePinHeaderView else {
                return
            }
            
            if pinHeader!.isKind(of: LKCompareTablePinHeaderView.self) {
                /// 先停止悬浮Header的滚动
                pinView.mainScrollView.setContentOffset(pinView.mainScrollView.contentOffset, animated: false)
            }
            
            if pinHeaderStyle == .fixed  { return }
            
            if scrollView.contentOffset.y < 0 {
                var newFrame = pinView.frame
                newFrame.origin.y = -scrollView.contentOffset.y
                pinView.frame = newFrame
            } else {
                var newFrame = pinView.frame
                newFrame.origin.y = 0
                pinView.frame = newFrame
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if (scrollView == tableView) {
            
            guard let pinView = pinHeader else {
                return
            }
            
            if pinHeaderStyle == .fixed  { return }
        
            if scrollView.contentOffset.y >= 0 {
                var newFrame = pinView.frame
                newFrame.origin.y = 0
                pinView.frame = newFrame
            }
        }
    }
}
