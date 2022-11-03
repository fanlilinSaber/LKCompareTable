//
//  OCExample03ViewController.m
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/29.
//

#import "OCExample03ViewController.h"
#import <ZJKCompareTable/ZJKCompareTable-Swift.h>
#import <Masonry/Masonry.h>
#import <ZJKCompareTable_IOS_Example-Swift.h>

@interface OCExample03ViewController () <ZJKCompareTableViewDataSource, ZJKCompareTableViewPinHeaderDataSource, ZJKCompareTableViewHeaderDataSource, ZJKCompareTableViewDelegate>
/// compareTableView
@property (nonatomic, strong) ZJKCompareTableView *compareTableView;
/// 测试数据
@property (nonatomic, copy) NSArray <ZJKCompareTableMoreModel *>*testData;
@end

@implementation OCExample03ViewController

//View初始化
#pragma mark - view init

//View的配置、布局设置
#pragma mark - view config

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSubviews];
    [self layoutPageSubviews];
    
    [self.compareTableView reloadData];
}

- (void)addSubviews
{
    [self.view addSubview:self.compareTableView];
}

- (void)layoutPageSubviews
{
    [self.compareTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - ZJKCompareTableViewDataSource

- (NSInteger)numberOfSectionsIn:(ZJKCompareTableView *)compareTableView
{
    return self.testData.count;
}

- (NSInteger)compareTableView:(ZJKCompareTableView *)compareTableView numberOfRowsInSection:(NSInteger)section
{
    return self.testData[section].fields.count;
}

- (NSInteger)compareTableView:(ZJKCompareTableView *)compareTableView numberOfItemsAt:(NSIndexPath *)indexPath
{
    return self.testData[indexPath.section].fields[indexPath.row].items.count;
}

- (NSString *)compareTableView:(ZJKCompareTableView *)compareTableView titleForHeaderInSection:(NSInteger)section
{
    return self.testData[section].headerTitle;
}

- (NSInteger)compareTableView:(ZJKCompareTableView *)compareTableView numberOfLinesForRowAt:(NSIndexPath *)indexPath
{
    return self.testData[indexPath.section].fields[indexPath.row].numberOfLines;
}

- (UIView *)compareTableView:(ZJKCompareTableView *)compareTableView viewForHeaderInSection:(NSInteger)section
{
    ZJKCompareTableTest01HeaderView *headerView = (ZJKCompareTableTest01HeaderView *)[compareTableView dequeueReusableHeaderFooterViewWithIdentifier:@"ZJKCompareTableTest01HeaderView"];
    return headerView;
}

- (ZJKCompareTableItemCell *)compareTableView:(ZJKCompareTableView *)compareTableView cellForItemAt:(NSIndexPath *)indexPath to:(NSInteger)index
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        if (index == 0) {
            ZJKCompareTableItemTest03Cell *cell = (ZJKCompareTableItemTest03Cell *)[compareTableView dequeueReusableCellWithIdentifier:@"ZJKCompareTableItemTest03Cell" for:indexPath to:index];
            cell.valueLabel.text = @"自定义cell类型三";
            return cell;
        }
        
        ZJKCompareTableItemTest02Cell *cell = (ZJKCompareTableItemTest02Cell *)[compareTableView dequeueReusableCellWithIdentifier:@"ZJKCompareTableItemTest02Cell" for:indexPath to:index];
        cell.valueLabel.text = @"自定义cell类型二";
        cell.valueLabel.textColor = UIColor.brownColor;
        return cell;
    }
    
    ZJKCompareTableItemTest01Cell *cell = (ZJKCompareTableItemTest01Cell *)[compareTableView dequeueReusableCellWithIdentifier:@"ZJKCompareTableItemTest01Cell" for:indexPath to:index];
    cell.text = self.testData[indexPath.section].fields[indexPath.row].items[index].text;
    return cell;
}

- (ZJKCompareTableFieldView *)compareTableView:(ZJKCompareTableView *)compareTableView viewForFieldAt:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        ZJKCompareTableTest01FieldView *field = (ZJKCompareTableTest01FieldView *)[compareTableView dequeueReusableFieldWithIdentifier:@"ZJKCompareTableTest01FieldView" for:indexPath];
        field.titleLabel.text = @"自定义field类型一";
        return field;
    }
    
    ZJKCompareTableFieldView *field = (ZJKCompareTableFieldView *)[compareTableView dequeueReusableFieldWithIdentifier:@"ZJKCompareTableFieldView" for:indexPath];
    field.textLabel.text = self.testData[indexPath.section].fields[indexPath.row].fieldName;
    return field;
}

#pragma mark - ZJKCompareTableViewPinHeaderDataSource

- (UIView *)viewForPinHeaderFieldIn:(ZJKCompareTableView *)compareTableView
{
    UIView *contentView = UIView.new;
    contentView.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = UILabel.new;
    label.text = @"隐藏相同";
    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    [contentView addSubview:label];
    
    UISwitch *hideSwitch = UISwitch.new;
    [contentView addSubview:hideSwitch];
    
    [hideSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.right.mas_lessThanOrEqualTo(-9);
        make.left.mas_lessThanOrEqualTo(9);
        make.top.equalTo(hideSwitch.mas_bottom).offset(10);
        make.bottom.mas_lessThanOrEqualTo(-9);
    }];
    
    return contentView;
}

- (UIView *)compareTableView:(ZJKCompareTableView *)compareTableView viewForPinHeaderItemsAt:(NSInteger)index
{
    UILabel *label = UILabel.new;
    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    label.numberOfLines = 0;
    label.text = @"卡罗拉 2022款 双擎1.8L E-CVT先锋版";
    if (index == 1) {
        label.text = @"卡罗拉 2022款 双擎1.8L E-CVT先锋版 测试很长的文本测试很长的文本测试很长的文本测试很长的文本测试很长的文本测试很长的文本自适应";
    }
    return label;
}

- (CGFloat)heightForPinHeaderIn:(ZJKCompareTableView *)compareTableView
{
    return ZJKCompareTableView.automaticDimension;
}

#pragma mark - ZJKCompareTableViewHeaderDataSource

- (UIView *)viewForHeaderIn:(ZJKCompareTableView *)compareTableView
{
    UIView *contentView = UIView.new;
    contentView.backgroundColor = [UIColor colorWithRed:1.0 green:0.97 blue:0.9 alpha:1];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *icon = UIImageView.new;
    icon.image = [UIImage imageNamed:@"zhuyi"];
    [contentView addSubview:icon];
    
    UILabel *label = UILabel.new;
    label.text = @"数据仅供参考，具体以供应商接单为准";
    label.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    label.textColor = [UIColor colorWithRed:1 green:0.75 blue:0 alpha:1];
    [contentView addSubview:label];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
    }];
    
    return contentView;
}

#pragma mark - ZJKCompareTableViewDelegate

- (void)compareTableView:(ZJKCompareTableView *)compareTableView didSelectRowAt:(NSIndexPath *)indexPath to:(NSInteger)index
{
    NSLog(@"点击了第%ld组下的第%ld行的第%ld个", indexPath.section, indexPath.row, index);
}

//私有方法
#pragma mark - private method

//View的生命周期
#pragma mark - view life

//更新View的接口
#pragma mark - update view

//处理View的事件
#pragma mark - handle view event

//发送View的事件
#pragma mark - send view event

//公有方法
#pragma mark - public method

//Setters方法
#pragma mark - setters

//Getters方法
#pragma mark - getters

- (ZJKCompareTableView *)compareTableView
{
    if (_compareTableView == nil) {
        _compareTableView = [[ZJKCompareTableView alloc] initWithFrame:CGRectZero headerStyle:HeaderStyleSuspending];
      
        [_compareTableView register:ZJKCompareTableItemTest01Cell.class forCellReuseIdentifier:@"ZJKCompareTableItemTest01Cell"];
        [_compareTableView register:ZJKCompareTableItemTest02Cell.class forCellReuseIdentifier:@"ZJKCompareTableItemTest02Cell"];
        [_compareTableView register:ZJKCompareTableItemTest03Cell.class forCellReuseIdentifier:@"ZJKCompareTableItemTest03Cell"];
        
        [_compareTableView register:ZJKCompareTableTest01HeaderView.class forHeaderFooterViewReuseIdentifier:@"ZJKCompareTableTest01HeaderView"];
        
        [_compareTableView register:ZJKCompareTableFieldView.class forFieldReuseIdentifier:@"ZJKCompareTableFieldView"];
        [_compareTableView register:ZJKCompareTableTest01FieldView.class forFieldReuseIdentifier:@"ZJKCompareTableTest01FieldView"];
        
        _compareTableView.dataSource = self;
        _compareTableView.delegate = self;
        _compareTableView.pinHeaderDataSource = self;
        _compareTableView.headerDataSource = self;
    }
    return  _compareTableView;
}

- (NSArray<ZJKCompareTableMoreModel *> *)testData
{
    if (_testData == nil) {
        NSMutableArray *data = NSMutableArray.array;
        
        NSArray *attrNames1 = @[@"商品名称"];
        
        NSArray *attrNames2 = @[@"商品分类商品分类商品分类商品分类", @"品牌", @"商品属性", @"仓储地", @"运距", @"物流服务", @"账期", @"发票", @"期货模式"];
        
        NSArray *attrNames3 = @[@"企业名称", @"客户身份", @"信用评分", @"主营业务", @"企业类型", @"经营地址", @"注册资本"];
        
        ZJKCompareTableMoreModel *model01 = ZJKCompareTableMoreModel.new;
        /// 添加属性测试数据
        [model01 makeFieldModelWith:attrNames1.count :^(NSInteger index, ZJKCompareTableMoreFieldModel *field) {
            field.fieldName = attrNames1[index];
            
            /// 添加item测试数据
            [field makeItemModelWith:8 :^(NSInteger itemIndex, ZJKCompareTableMoreItemModel *item) {
                if (itemIndex == 0) { item.text = @"开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"; }
                else if (itemIndex == 1) { item.text = @"开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"; }
                else if (itemIndex == 2) { item.text = @"开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾"; }
            }];
        }];
        [data addObject:model01];
        
        ZJKCompareTableMoreModel *model02 = ZJKCompareTableMoreModel.new;
        model02.headerTitle = @"商品属性";
        /// 添加属性测试数据
        [model02 makeFieldModelWith:attrNames2.count :^(NSInteger index, ZJKCompareTableMoreFieldModel *field) {
            field.fieldName = attrNames2[index];
            
            /// 添加item测试数据
            NSInteger num = arc4random_uniform(8);
            
            [field makeItemModelWith:8 :^(NSInteger itemIndex, ZJKCompareTableMoreItemModel *item) {
                
                NSString *val = [NSString stringWithFormat:@"第2组下的第%ld行的第%ld个数据", index, itemIndex];
                
                /// 随机加长内容测试
                if (num == itemIndex) {
                    val = [val stringByAppendingString:@"加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"];
                }
                item.text = val;
                
            }];
            
            /// 指定某一项字段换行数
            if ([field.fieldName isEqualToString:@"物流服务"]) {
                field.numberOfLines = 3;
            }
        }];
        [data addObject:model02];
        
        ZJKCompareTableMoreModel *model03 = ZJKCompareTableMoreModel.new;
        model03.headerTitle = @"供应商详情";
        /// 添加属性测试数据
        [model03 makeFieldModelWith:attrNames3.count :^(NSInteger index, ZJKCompareTableMoreFieldModel *field) {
            field.fieldName = attrNames3[index];
            
            /// 添加item测试数据
            NSInteger num = arc4random_uniform(8);
            [field makeItemModelWith:8 :^(NSInteger itemIndex, ZJKCompareTableMoreItemModel *item) {
                
                NSString *val = [NSString stringWithFormat:@"第3组下的第%ld行的第%ld个数据", index, itemIndex];
                
                /// 随机加长内容测试
                if (num == itemIndex) {
                    val = [val stringByAppendingString:@"加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"];
                }
                item.text = val;
                
            }];
        }];
        [data addObject:model03];
        
        _testData = data.copy;
    }
    return _testData;
}

@end
