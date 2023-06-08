//
//  LKCompareTablePinHeaderView.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/10/17.
//

import UIKit

open class LKCompareTablePinHeaderView: UIView {
    
    // MARK: - Public（Ivars）
    
    public typealias indexBlock = (_ index: Int, _ itemCell: LKCompareTableItemCell) -> Void
    
    /// scrollView 的滚动事件暴露给外层去处理
    public weak var scrollViewDelegate: UIScrollViewDelegate? {
        didSet {
            mainScrollView.delegate = scrollViewDelegate
        }
    }
    
    /// 属性栏
    public private(set) lazy var attrView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// 侧边滚动父视图
    public private(set) lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.tag = 985
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    /// 侧边自适应内容父视图
    public private(set) lazy var contentStackView: LKCompareTableStackView = {
        let stackView = LKCompareTableStackView()
        stackView.axis = .horizontal
        stackView.spacing = separatorWidth
        stackView.separatorColor = separatorColor
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    /// 顶部分割线
    public private(set) lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = separatorColor
        return view
    }()
    
    /// 底部分割线
    public private(set) lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = separatorColor
        return view
    }()
    
    /// 右边分割线
    public private(set) lazy var rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = separatorColor
        return view
    }()
    
    // MARK: - Public（Method）
    
    /// 返回对应的ItemCell
    /// - Parameter index: 第几个
    /// - Returns: LKCompareTableItemCell
    public func cellForItem(at index: Int) -> LKCompareTableItemCell? {
        guard contentStackView.arrangedSubviews.count > index else {
            return nil
        }
        return contentStackView.arrangedSubviews[index] as? LKCompareTableItemCell;
    }
    
    /// 设置自定义的cell
    /// - Parameters:
    ///   - number: 属性数量
    ///   - closure: 回调
    public func setItemCell(with number: Int, itemCellWidth width: CGFloat,_ closure: (_ index: Int) -> UIView?) {
        for cell in contentStackView.arrangedSubviews {
            cell.removeFromSuperview()
        }
        
        for index in 0..<number {
            guard let cell = closure(index) else {
                break
            }
            if width > 0 {
                cell.snp.makeConstraints { make in
                    make.width.equalTo(width)
                }
            }
            contentStackView.addArrangedSubview(cell)
            
            cell.tag = index
            cell.isUserInteractionEnabled = true
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
        }
    }
    
    /// 设置属性栏填充的内容
    /// - Parameter view: 填充的内容
    public func setAttrContent(with view: UIView?) {
        if view == nil { return }
        attrView.addSubview(view!)
        view!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func didSelectIndexBlock(block: @escaping indexBlock) {
        didSelectIndexCall = block
    }
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        addSubviews()
        layoutPageSubviews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Config
    
    /// addView
    private func addSubviews() {
        addSubview(attrView)
        addSubview(mainScrollView)
        mainScrollView.addSubview(contentStackView)
        addSubview(topLineView)
        addSubview(bottomLineView)
        addSubview(rightLineView)
    }
    
    /// 布局子视图
    private func layoutPageSubviews() {
        attrView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().priority(.high)
            make.left.equalToSuperview()
            make.width.equalTo(68)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(attrView.snp.right)
            make.height.equalTo(contentStackView);
        }
        
        contentStackView.snp.makeConstraints { make in
            make.left.equalTo(mainScrollView)
            make.right.equalTo(mainScrollView)
            make.top.bottom.equalToSuperview()
        }
        
        topLineView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(separatorWidth)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(separatorWidth)
        }
        
        rightLineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(mainScrollView.snp.left)
            make.width.equalTo(separatorWidth)
        }
    }
    
    // MARK: - Update view
    
    // MARK: - Action
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        didSelectIndexCall?(sender.view?.tag ?? 0, sender.view as! LKCompareTableItemCell)
    }
    
    // MARK: - Private（Ivars）
    
    /// 分割线颜色
    private let separatorColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    /// 分割线宽度
    private let separatorWidth = 1.0 / UIScreen.main.scale
    
    private var didSelectIndexCall: indexBlock?
    
    // MARK: - Private（Method）
}

