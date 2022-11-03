//
//  ViewController.m
//  ZJKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/11/3.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"表格集合";
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CGFLOAT_MIN)];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"testCell"];
    self.dataSource = @[
                        @{@"title": @"比价表格展示-OC",
                          @"aClassName": @"OCExample02ViewController"},
                        @{@"title": @"比价表格展示-Swift",
                          @"aClassName": @"Example02ViewController"},
                        
                        @{@"title": @"比价表格展示自定义-OC",
                          @"aClassName": @"OCExample03ViewController"},
                        @{@"title": @"比价表格展示自定义-Swift",
                          @"aClassName": @"Example03ViewController"},
                        
                        @{@"title": @"比价表格内部样式展示-Swift",
                          @"aClassName": @"Example04ViewController"},
                        
                        @{@"title": @"仿汽车之家比价头部悬浮设计-Swift",
                          @"aClassName": @"Example05ViewController"},
    ];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[NSClassFromString(self.dataSource[indexPath.row][@"aClassName"]) alloc] init];
    if (!vc) {
//        NSString *workName = NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"];
        NSString *workName = @"_TtC27ZJKCompareTable_IOS_Example23";
        vc = [[NSClassFromString([NSString stringWithFormat:@"%@%@", workName, self.dataSource[indexPath.row][@"aClassName"]]) alloc] init];
    }
    vc.title = self.dataSource[indexPath.row][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
