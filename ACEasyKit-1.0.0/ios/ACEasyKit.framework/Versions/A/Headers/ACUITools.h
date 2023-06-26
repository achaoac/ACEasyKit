//
//  ACUITools.h
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ac_line_image @"ac_public_line" // 线条图片

/// 快捷创建基础 UI 的工具
@interface ACUITools : NSObject

/// 创建label
+ (UILabel *)createLabel:(UIView *)superView
                   frame:(CGRect)frame
                    text:(NSString * _Nullable)text
               textColor:(UIColor *)color
                    font:(UIFont *)font
               alignment:(NSTextAlignment)alignment;

/// 创建标题按钮
+ (UIButton *)createButton:(UIView *)superView frame:(CGRect)frame title:(NSString * _Nullable)title target:(id)target selector:(SEL)selector;

/// 创建图片按钮
+ (UIButton *)createButton:(UIView *)superView frame:(CGRect)frame image:(NSString *)imageName target:(id)target selector:(SEL)selector;

/// 创建标题+图片按钮（标题和图片位置可控）
+ (UIButton *)createVariableButton:(UIView *)spView
                             frame:(CGRect)frame
                             title:(NSString * _Nullable)title
                             image:(UIImage * _Nullable)image
                         titleRect:(CGRect)titleRect
                         imageRect:(CGRect)imageRect
                              font:(UIFont * _Nullable)font
                        titleColor:(UIColor * _Nullable)color
                            target:(id)target
                          selector:(SEL)selector;

/// 创建imageView
+ (UIImageView *)createImage:(UIView *)superView frame:(CGRect)frame;

/// 创建imageView
+ (UIImageView *)createImage:(UIView *)superView frame:(CGRect)frame image:(NSString *)imgName;

/// 创建image,可设置圆角
+ (UIImageView *)createImage:(UIView *)superView frame:(CGRect)frame corner:(float)corner border:(float)border borderColor:(UIColor * _Nullable)borderColor;

/// 创建view
+ (UIView *)createView:(UIView *)superView frame:(CGRect)frame bgColor:(UIColor *)color;

/// 创建line，line按照颜色绘制（在部分系统和机型下，line高度可能有视觉偏差，推荐使用+ (UIView *)addPublicLine:(UIView *)spView frame:(CGRect)frame）
+ (UIView *)addLineView:(UIView *)superView frame:(CGRect)frame lineColor:(UIColor *)color;

/// 创建line，以 ac_line_image 命名图片
+ (UIView *)addPublicLine:(UIView *)spView frame:(CGRect)frame;

/// 创建毛玻璃
+ (UIVisualEffectView *)createBlurEffect:(UIView *)spView style:(UIBlurEffectStyle)style frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
