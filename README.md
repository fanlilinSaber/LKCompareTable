# ZJKCompareTable
类似汽车之家比价表格展示，内容自定义，支持HeaderView悬浮。

## 功能特点

- 支持OC和Swift
- 支持表格分组Header视图自定义、字段栏Field视图自定义、item视图自定义
- 悬浮HeaderView自定义
- 支持每一行高度自适应和自定义
- 利用系统TableView cell重用机制，优化内存，提升性能

## 预览

| 效果  | 预览图 |
|-------|-------|

## 安装

### CocoaPods 安装使用

支持swift版本：5.0+

请在Podfile中指定
pod 'ZJKCompareTable'
然后终端执行 `pod install`

## 使用

**OC**
```Objective-C

/// compareTableView
@property (nonatomic, strong) ZJKCompareTableView *compareTableView;
/// 测试数据
@property (nonatomic, copy) NSArray <NSArray <ZJKOCCompareTableTest01Model *>*>*testData;

_compareTableView = ZJKCompareTableView.new;
_compareTableView.dataSource = self;
[_compareTableView reloadData]

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

```

**Swift**
```Swift

let tableView = ZJKCompareTableView()
tableView.dataSource = self
compareTableView.reloadData()
        
// MARK: - ZJKCompareTableViewDataSource

public func numberOfSections(in compareTableView: ZJKCompareTableView) -> Int {
    
    return testData.count
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfRowsInSection section: Int) -> Int {
    
    return testData[section].count
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfItemsAt indexPath: IndexPath) -> Int {

    return testData[indexPath.section][indexPath.row].values?.count ?? 0
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, titleForHeaderInSection section: Int) -> String? {
    
    if section == 1 { return "商品属性"}
    else if section == 2 { return "供应商详情"}
    
    return nil
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, fieldNameForRowAt indexPath: IndexPath) -> String? {
    
    return testData[indexPath.section][indexPath.row].attrName
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, numberOfLinesForRowAt indexPath: IndexPath) -> Int {
    
    return testData[indexPath.section][indexPath.row].numberOfLines
}

public func compareTableView(_ compareTableView: ZJKCompareTableView, textForItemAt indexPath: IndexPath, to index: Int) -> String? {
    
    guard let values = testData[indexPath.section][indexPath.row].values else {
        return nil
    }
    
    return values[index]
}

```
更新使用请参考demo


## 更新日志

* 2022年11月3日 `v1.0.0`
1. 第一个版本上线
