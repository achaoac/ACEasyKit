//
//  ACToastView.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/26.
//

#import "ACToastView.h"

@implementation ACToastConfigModel

- (instancetype)init {
    if (self = [super init]) {
        self.duration = 1.2;
        self.bgColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        self.textColor = [UIColor whiteColor];
        self.cornerRadius = 6;
        self.font = [UIFont systemFontOfSize:13];
        self.textLeftIntervel = 20;
        self.textTopIntervel = 11;
        self.viewCenterYIntervel = -60;
        self.viewLeftIntervel = 20;
    }
    return self;
}

@end

@interface ACToastView ()

@property (nonatomic,strong) UILabel *textLab; // 展示文字的label
@property (nonatomic,strong) NSTimer *timer; // 控制自动消失的timer
@property (nonatomic,strong) ACToastConfigModel *cfgModel; // 样式配置数据模型

@end

@implementation ACToastView

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initToastView];
    }
    return self;
}

// 根据当前model初始化视图
- (void)initToastView {
    [self.layer setMasksToBounds:YES];
    self.backgroundColor = self.cfgModel.bgColor;
    self.layer.cornerRadius = self.cfgModel.cornerRadius;
    
    self.textLab.textColor = self.cfgModel.textColor;
    self.textLab.font = self.cfgModel.font;
}

+ (void)configToastView:(ACToastConfigModel *)model {
    if (!model) {
#ifdef DEBUG
        NSLog(@"%s 配置 model 为 nil，使用默认样式",__func__);
#endif
        return;
    }
    [ACToastView sharedInstance].cfgModel = model;
    [[ACToastView sharedInstance] initToastView];
}

+ (void)showToast:(NSString *)content, ... {
    va_list arglist;
    va_start(arglist, content);
    NSString *text = [[NSString alloc] initWithFormat:content arguments:arglist];
    va_end(arglist);
    
#ifdef DEBUG
    NSLog(@"%s %@",__func__,text);
#endif
    
    if (text.length == 0) {
        return;
    }
    
    ACToastView *instance = [ACToastView sharedInstance];
    [instance removeTipView];
    
    // 先将宽度重置为最大，然后计算出文字高度
    float maxW = instance.cfgModel.viewLeftIntervel + instance.cfgModel.textLeftIntervel;
    [instance.textLab setFrame:CGRectMake(maxW, instance.cfgModel.textTopIntervel, [UIScreen mainScreen].bounds.size.width - maxW * 2, 20)];
    instance.textLab.text = text;
    [instance.textLab sizeToFit];
    
    // 重新设置label frame
    [instance.textLab setFrame:CGRectMake(instance.cfgModel.textLeftIntervel, instance.cfgModel.textTopIntervel, instance.textLab.frame.size.width, instance.textLab.frame.size.height)];
    
    float view_w = instance.textLab.frame.size.width + instance.cfgModel.textLeftIntervel * 2;
    float view_h = instance.textLab.frame.size.height + instance.cfgModel.textTopIntervel * 2;
    
    // 更新视图frame
    [instance setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - view_w) / 2.0, ([UIScreen mainScreen].bounds.size.height - view_h) / 2.0 + instance.cfgModel.viewCenterYIntervel, view_w, view_h)];
    UIWindow *keyWindow = [ACToastView keyWindow];
#ifdef DEBUG
    if (!keyWindow) {
        NSLog(@"%s keyWindow 获取失败，无法展示toast！！！",__func__);
    }
#endif
    [keyWindow addSubview:instance];
    instance.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        instance.alpha = 1;
    } completion:^(BOOL finished) {
        instance.timer = [NSTimer scheduledTimerWithTimeInterval:instance.cfgModel.duration target:instance selector:@selector(removeTipView) userInfo:nil repeats:NO];
        // 解决scrollview滑动时，toast不消失的问题
        [[NSRunLoop currentRunLoop] addTimer:instance.timer forMode:NSRunLoopCommonModes];
    }];
}

- (void)removeTipView {
    [self.timer invalidate];
    self.timer = nil;
    [[ACToastView sharedInstance] removeFromSuperview];
}

- (ACToastConfigModel *)cfgModel {
    if (!_cfgModel) {
        _cfgModel = [[ACToastConfigModel alloc] init];
    }
    return _cfgModel;
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.numberOfLines = 0;
        [self addSubview:_textLab];
    }
    return _textLab;
}

+ (UIWindow *)keyWindow {
    // 获取keyWindow
    UIWindow *keyWindow = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                for (UIWindow *window in windowScene.windows) {
                    if (window.isKeyWindow) {
                        keyWindow = window;
                        break;
                    }
                }
                if (keyWindow) {
                    break;
                }
            }
        }
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        keyWindow = [UIApplication sharedApplication].keyWindow;
#pragma clang diagnostic pop
    }
    return keyWindow;
}


@end
