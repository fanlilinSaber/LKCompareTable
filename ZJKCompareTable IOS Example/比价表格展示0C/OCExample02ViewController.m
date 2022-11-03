//
//  OCExample02ViewController.m
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/27.
//

#import "OCExample02ViewController.h"
#import <ZJKCompareTable/ZJKCompareTable-Swift.h>
#import <Masonry/Masonry.h>
#import "ZJKOCCompareTableTest01Model.h"

@interface OCExample02ViewController () <ZJKCompareTableViewDataSource>
/// compareTableView
@property (nonatomic, strong) ZJKCompareTableView *compareTableView;
/// 测试数据
@property (nonatomic, copy) NSArray <NSArray <ZJKOCCompareTableTest01Model *>*>*testData;
@end

@implementation OCExample02ViewController

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
    return self.testData[section].count;
}

- (NSInteger)compareTableView:(ZJKCompareTableView *)compareTableView numberOfItemsAt:(NSIndexPath *)indexPath
{
    return self.testData[indexPath.section][indexPath.row].values.count;
}

- (NSString *)compareTableView:(ZJKCompareTableView *)compareTableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) { return @"商品属性"; }
    else if (section == 2) { return @"供应商详情"; }
    return nil;
}

- (NSString *)compareTableView:(ZJKCompareTableView *)compareTableView fieldNameForRowAt:(NSIndexPath *)indexPath
{
    return self.testData[indexPath.section][indexPath.row].attrName;
}

- (NSInteger)compareTableView:(ZJKCompareTableView *)compareTableView numberOfLinesForRowAt:(NSIndexPath *)indexPath
{
    return self.testData[indexPath.section][indexPath.row].numberOfLines;
}

- (NSString *)compareTableView:(ZJKCompareTableView *)compareTableView textForItemAt:(NSIndexPath *)indexPath to:(NSInteger)index
{
    return self.testData[indexPath.section][indexPath.row].values[index];
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
        _compareTableView = ZJKCompareTableView.new;
        _compareTableView.dataSource = self;
    }
    return  _compareTableView;
}

- (NSArray<NSArray<ZJKOCCompareTableTest01Model *> *> *)testData
{
    if (_testData == nil) {
        NSMutableArray *data = NSMutableArray.array;
        
        NSArray *attrNames1 = @[@"商品名称"];
        
        NSArray *attrNames2 = @[@"商品分类商品分类商品分类商品分类", @"品牌", @"商品属性", @"仓储地", @"运距", @"物流服务", @"账期", @"发票", @"期货模式"];
        
        NSArray *attrNames3 = @[@"企业名称", @"客户身份", @"信用评分", @"主营业务", @"企业类型", @"经营地址", @"注册资本"];
        
        NSMutableArray *array1 = NSMutableArray.array;
        for (NSString *name in attrNames1) {
            ZJKOCCompareTableTest01Model *model = ZJKOCCompareTableTest01Model.new;
            model.attrName = name;
            model.values = @[@"开始-2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢2022厂家直供钢筋 /八钢/热轧带肋钢结尾", @"2022厂家直供钢筋 /八钢/热轧带肋钢-结束", @"数据展示少一点数据展示少一点数据展示少一点"];
            [array1 addObject:model];
        }
        [data addObject:array1];
        
        NSMutableArray *array2 = NSMutableArray.array;
        for (int i = 0; i < attrNames2.count; i ++) {
            NSString *name = attrNames2[i];
            ZJKOCCompareTableTest01Model *model = ZJKOCCompareTableTest01Model.new;
            model.attrName = name;
            model.headerTitle = @"商品属性";
            
            int num = arc4random_uniform(3);
            NSMutableArray *values = NSMutableArray.array;
            for (int j = 0; j < 10; j ++) {
                NSString *val = [NSString stringWithFormat:@"第2组下的第%d行的第%d个数据", i, j];
                
                /// 随机加长内容测试
                if (num == j) {
                    val = [val stringByAppendingString:@"加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"];
                }
                [values addObject:val];
            }
            
            if ([name isEqualToString:@"物流服务"]) {
                model.numberOfLines = 3;
            }
            model.values = values;
            [array2 addObject:model];
        }
        [data addObject:array2];
        
        NSMutableArray *array3 = NSMutableArray.array;
        for (int i = 0; i < attrNames3.count; i ++) {
            NSString *name = attrNames3[i];
            ZJKOCCompareTableTest01Model *model = ZJKOCCompareTableTest01Model.new;
            model.attrName = name;
            model.headerTitle = @"供应商详情";
            
            int num = arc4random_uniform(3);
            NSMutableArray *values = NSMutableArray.array;
            for (int j = 0; j < 10; j ++) {
                NSString *val = [NSString stringWithFormat:@"第3组下的第%d行的第%d个数据", i, j];
                
                /// 随机加长内容测试
                if (num == j) {
                    val = [val stringByAppendingString:@"加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符加长的占位符"];
                }
                [values addObject:val];
            }
            model.values = values;
            [array3 addObject:model];
        }
        [data addObject:array3];
        
        _testData = data.copy;
    }
    return _testData;
}

@end



