//
//  LKOCCompareTableTest01Model.h
//  LKCompareTable IOS Example
//
//  Created by Fan Li Lin on 2022/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKOCCompareTableTest01Model : NSObject
/// 头部标题
@property (nonatomic, copy) NSString *headerTitle;
/// 属性名
@property (nonatomic, copy) NSString *attrName;
/// 当前属性→展示内容最大换行数（默认 = 0，不限制）
@property (nonatomic, assign) NSInteger numberOfLines;
/// 对应属性的内容
@property (nonatomic, copy) NSArray *values;
@end

NS_ASSUME_NONNULL_END
