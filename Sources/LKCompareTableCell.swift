//
//  LKCompareTableCell.swift
//  LKCompareTable
//
//  Created by Fan Li Lin on 2022/9/21.
//

import UIKit
import SnapKit

class LKCompareTableCell: UITableViewCell {
    
    // MARK: - ***** Public method *****
    
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

        if number != contentStackView.arrangedSubviews.count {
            for cell in contentStackView.arrangedSubviews {
                cell.removeFromSuperview()
            }
        }
        
        for index in 0..<number {
            guard let cell = closure(index) else {
                break
            }

            if width != LKCompareTableView.automaticDimension {
                cell.snp.updateConstraints { make in
                    make.width.equalTo(width)
                }
            }
                    
            let view = contentStackView.arrangedSubviews.count > index ? contentStackView.arrangedSubviews[index] : nil;
            if (view == nil) {
                contentStackView.addArrangedSubview(cell)
                if cell.isKind(of: LKCompareTableItemCell.self) {
                    cell.isUserInteractionEnabled = true
                    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
                }
            } else if (view != cell) {
                /// 移除视图并更新的视图位置
                view!.removeFromSuperview()
                contentStackView.insertArrangedSubview(cell, at: index)
                if cell.isKind(of: LKCompareTableItemCell.self) {
                    cell.isUserInteractionEnabled = true
                    cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
                }
            }
            cell.tag = index
        }

        /// 如果第一次contentSize为空情况下 在外部设置 contentOffset 之后会反弹
        if mainScrollView.contentSize.equalTo(.zero) {
            var size = contentStackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            
            if size.equalTo(.zero) {
                size = contentStackView.sizeThatFits(CGSize(width: frame.width, height: 0))
            }
            mainScrollView.contentSize = size
        }
    }
     
    /// 设置自定义FieldView
    /// - Parameters:
    ///   - width: 宽度
    ///   - view: FieldView
    public func setFieldView(with width: CGFloat, field view: LKCompareTableFieldView) {
        
        if fieldView != nil && view.reuseIdentifier != fieldView?.reuseIdentifier {
            fieldView?.removeFromSuperview()
        }
        
        fieldView = view
        if view.superview != fieldContentView {
            fieldContentView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                if width != LKCompareTableView.automaticDimension {
                    make.width.equalTo(width)
                }
            }
        } else {
            view.snp.updateConstraints { make in
                if width != LKCompareTableView.automaticDimension {
                    make.width.equalTo(width)
                }
            }
        }
    }
    
    public func didSelectIndexBlock(block: @escaping indexBlock) {
        didSelectIndexCall = block
    }
    
    // MARK: - ***** Ivars *****
    
    typealias indexBlock = (_ index: Int, _ itemCell: LKCompareTableItemCell) -> Void
    
    /// 分割线颜色
    private let separatorColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    /// 分割线宽度
    private let separatorWidth = 1.0 / UIScreen.main.scale
    
    /// scrollView 的滚动事件暴露给外层去处理
    public weak var scrollViewDelegate: UIScrollViewDelegate? {
        didSet {
            mainScrollView.delegate = scrollViewDelegate
        }
    }
    
    public var contentOffset: CGPoint = .zero
    
    /// 用于占位补充显示数量；如： displayCount = 5，纵向列数实际数据只有3列，会补充2列空白显示
    public var displayCount: Int = 0
    
    /// 左边的字段栏
    public private(set) var fieldView: LKCompareTableFieldView?
    
    /// 左边的字段栏视图
    public private(set) lazy var fieldContentView: UIView = {
        let attrNameView = UIView()
        return attrNameView
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
    
    private var didSelectIndexCall: indexBlock?
    
    // MARK: - ***** Class method *****
    
    // MARK: - ***** Init method *****
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundView?.backgroundColor = .clear
        backgroundColor = .clear
        contentView.backgroundColor = .white
        
        addSubviews()
        layoutPageSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ***** Lifecycle *****
    
    /// addView
    private func addSubviews() {
        contentView.addSubview(fieldContentView)
        contentView.addSubview(mainScrollView)
        mainScrollView.addSubview(contentStackView)
        contentView.addSubview(topLineView)
        contentView.addSubview(bottomLineView)
        contentView.addSubview(rightLineView)
    }
    
    /// 布局子视图
    private func layoutPageSubviews() {
        fieldContentView.snp.makeConstraints { make in
            make.left.bottom.top.equalToSuperview()
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(fieldContentView.snp.right)
            make.height.equalTo(contentStackView);
        }
        
        contentStackView.snp.makeConstraints { make in
            make.left.equalTo(mainScrollView)
            make.right.equalTo(mainScrollView)
            make.top.bottom.equalTo(mainScrollView)
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
    
    // MARK: - ***** Update view *****
    
    // MARK: - ***** Private method *****
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        
        didSelectIndexCall?(sender.view?.tag ?? 0, sender.view as! LKCompareTableItemCell)
    }
    
    // MARK: - ***** Respond event method *****
    
    // MARK: - ***** Create method *****
}

class LKCompareTableAttrNameView: UIView {
    
    public private(set) lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutPageSubviews()
    }
    
    func addSubviews() {
        addSubview(textLabel)
    }
    
    func layoutPageSubviews() {
        textLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.lessThanOrEqualTo(-10)
            make.top.lessThanOrEqualTo(9)
            make.bottom.lessThanOrEqualTo(-9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


