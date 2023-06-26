//
//  ACToastView.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 配置模型，用来配置 toast 样式
@interface ACToastConfigModel : NSObject

/// toast字体样式，默认[UIFont systemFontOfSize:13]
@property (nonatomic, strong) UIFont *font;

/// 文字颜色，默认 (255,255,255)
@property (nonatomic, strong) UIColor *textColor;

/// 背景色，默认 (0,0,0,0.8);
@property (nonatomic, strong) UIColor *bgColor;

/// 弧度，默认6
@property (nonatomic, assign) CGFloat cornerRadius;

/// 展示的时长，默认1.2s
@property (nonatomic, assign) NSTimeInterval duration;

/// 视图距离中心点Y坐标偏移，默认 -60（负数表示向上偏移）
@property (nonatomic, assign) CGFloat viewCenterYIntervel;

/// 视图距离屏幕边缘最小边距，默认 20
@property (nonatomic, assign) CGFloat viewLeftIntervel;

/// 文字距离左右间隔，默认20
@property (nonatomic, assign) CGFloat textLeftIntervel;

/// 文字距离上下间隔，默认11
@property (nonatomic, assign) CGFloat textTopIntervel;

@end

/// 全局 toast 工具
/// Toast会展示在 keyWindow 上，有默认样式；
/// 如果要定制样式，使用可配置函数定制；
@interface ACToastView : UIView

/// 定制 toast 样式，如果未配置，则使用默认样式
/// @param model 数据模型
+ (void)configToastView:(ACToastConfigModel *)model;

/// 展示toast
/// @param content 内容
+ (void)showToast:(NSString *)content, ...;

@end

NS_ASSUME_NONNULL_END
