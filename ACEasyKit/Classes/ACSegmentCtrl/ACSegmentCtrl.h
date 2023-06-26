//
//  ACSegmentCtrl.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/12/8.
//  Copyright © 2022 achaoacwang All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 配置类
@interface ACSegmentCtrlConfig : NSObject

/// 默认索引，默认0
@property (nonatomic, assign) int defaultIndex;

/// 左右间距，默认16
@property (nonatomic, assign) float lrInterval;

/// 标题间距，默认24
@property (nonatomic, assign) float interval;

/// 背景色，默认whiteColor
@property (nonatomic, strong) UIColor *bgColor;

/// 高亮标题颜色，默认（47, 123, 246,1）
@property (nonatomic, strong) UIColor *lightTitleColor;

/// 默认标题颜色，默认blackColor
@property (nonatomic, strong) UIColor *defaultTitleColor;

/// 高亮字体，默认[UIFont fontWithName:@"PingFangSC-Medium" size:17]
@property (nonatomic, strong) UIFont *lightTitleFont;

/// 默认字体，默认[UIFont fontWithName:@"PingFangSC-Medium" size:15]
@property (nonatomic, strong) UIFont *defaultTitleFont;

/// 当元素不足一屏时，是否居中展示，默认YES
@property (nonatomic, assign) BOOL isCenterShow;

/// 是否展示高亮线条，默认YES
@property (nonatomic, assign) BOOL isLineShow;

/// 线条颜色，默认（47, 123, 246,1）
@property (nonatomic, strong) UIColor *lineColor;

/// 线条宽度，默认40
@property (nonatomic, assign) float lineWidth;

/// 线条高度，默认2
@property (nonatomic, assign) float lineHeight;

@end

@protocol ACSegmentCtrlDelegate <NSObject>

- (void)ACSegmentCtrlDelegateIndexChanged:(int)index;

@end

@interface ACSegmentCtrl : UIView

/// 构造函数
/// @param spView 父视图
/// @param frame 坐标
/// @param titles 标题数组
/// @param delegate 代理
/// @param config 配置（为空时使用默认样式）
+ (ACSegmentCtrl *)creaetSegmentCtrl:(UIView *)spView frame:(CGRect)frame titles:(NSArray <NSString *> * _Nullable)titles delegate:(id<ACSegmentCtrlDelegate>)delegate config:(ACSegmentCtrlConfig * _Nullable)config;

/// 滑动到指定位置
/// @param index 索引
- (void)scrollToIndex:(int)index;

/// 更新
/// @param titles 标题数组，更新之后索引会回到defaultIndex
- (void)updateCateView:(NSArray <NSString *> *)titles;

@end

NS_ASSUME_NONNULL_END
