//
//  ACAleartView.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ACAlertCompleteBlock)(void);
typedef void (^ACAlertCcancelBlock)(void);

/// 配置模型，用来配置 aleart 样式
@interface ACAleartViewConfigModel : NSObject

/// 弧度，默认12
@property (nonatomic, assign) CGFloat cornerRadius;

/// 标题字体样式，默认[UIFont fontWithName:@"PingFangSC-Medium" size:17]
@property (nonatomic, strong) UIFont *titleFont;

/// 内容字体样式，默认[UIFont fontWithName:@"PingFangSC-Regular" size:15]
@property (nonatomic, strong) UIFont *desFont;

/// 确认按钮字体样式，默认[UIFont fontWithName:@"PingFangSC-Medium" size:17]
@property (nonatomic, strong) UIFont *confirmButtonFont;

/// 取消按钮字体样式，默认[UIFont fontWithName:@"PingFangSC-Medium" size:17]
@property (nonatomic, strong) UIFont *cancelButtonFont;

/// 浮层背景色，默认 (0, 0, 0, 0.3)
@property (nonatomic, strong) UIColor *bgColor;

/// 内容背景色，默认 whiteColor
@property (nonatomic, strong) UIColor *contentColor;

/// 标题颜色，默认  (30, 30, 30, 1)
@property (nonatomic, strong) UIColor *titleTextColor;

/// 内容颜色，默认  (30, 30, 30, 1)
@property (nonatomic, strong) UIColor *contentTextColor;

/// 取消按钮文字颜色，默认  (30, 30, 30, 1)
@property (nonatomic, strong) UIColor *cancelTextColor;

/// 确认按钮文字颜色，默认 (255, 73, 84, 1)
@property (nonatomic, strong) UIColor *confirmTextColor;

/// 线条颜色，默认 lightGrayColor
@property (nonatomic, strong) UIColor *lineColor;

/// 视图距离屏幕边缘最小边距，默认 40，但是会受最大宽度影响，当屏幕过宽时，以最大宽度为准
@property (nonatomic, assign) CGFloat viewLeftIntervel;

/// 内容区最大宽度，默认 340（如ipad或者iphone横屏）
@property (nonatomic, assign) CGFloat maxWidth;

/// 内容距离左边间距，默认 24
@property (nonatomic, assign) CGFloat contentLeftIntervel;

/// 标题距离顶部间距，默认 24
@property (nonatomic, assign) CGFloat titleTopIntervel;

/// 内容距离顶部间距（无标题时），默认 30
@property (nonatomic, assign) CGFloat contentTopIntervel;

/// 内容距离顶部间距（有标题时），默认 60
@property (nonatomic, assign) CGFloat contentTopNonTitleIntervel;

/// 按钮高度，默认47
@property (nonatomic, assign) CGFloat buttonHeight;

/// 按钮距离内容间隔，默认24
@property (nonatomic, assign) CGFloat buttonIntervel;

/// 线条粗度，默认0.6
@property (nonatomic, assign) CGFloat lineWidth;


@end

@interface ACAleartView : UIView

/// 点击确认按钮是否自动移除 aleart，默认为 YES
@property (nonatomic, assign) BOOL confirmAutoRemove;

/// 创建提示弹框
/// - Parameters:
///   - spView: 父视图
///   - model: 样式模型（不传则使用默认样式）
///   - title: 标题
///   - content: 内容描述
///   - cancel: 取消按钮
///   - confirm: 确认按钮
///   - block: 确认回调
///   - cancelBlock: 取消回调
+ (ACAleartView *)creaetAlertView:(UIView *)spView model:(ACAleartViewConfigModel * _Nullable)model title:(NSString * _Nullable)title content:(NSString * _Nullable)content cancel:(NSString * _Nullable)cancel confirm:(NSString * _Nullable)confirm complete:(ACAlertCompleteBlock _Nullable)block cancelBlock:(ACAlertCcancelBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
