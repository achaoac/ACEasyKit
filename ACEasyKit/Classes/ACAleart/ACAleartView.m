//
//  ACAleartView.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/10/26.
//

#import "ACAleartView.h"

@implementation ACAleartViewConfigModel

- (instancetype)init {
    if (self = [super init]) {
        self.cornerRadius = 12;
        self.titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        self.desFont = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        self.confirmButtonFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        self.cancelButtonFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        self.bgColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.contentColor = UIColor.whiteColor;
        self.titleTextColor = [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1];
        self.contentTextColor = [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1];
        self.cancelTextColor = [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1];
        self.confirmTextColor = [UIColor colorWithRed:255 / 255.0 green:73 / 255.0 blue:84 / 255.0 alpha:1];
        self.lineColor = UIColor.lightGrayColor;
        self.viewLeftIntervel = 40;
        self.maxWidth = 340;
        self.contentLeftIntervel = 24;
        self.titleTopIntervel = 24;
        self.contentTopNonTitleIntervel = 30;
        self.contentTopIntervel = 60;
        self.buttonHeight = 47;
        self.buttonIntervel = 24;
        self.lineWidth = 0.6;
    }
    return self;
}

@end

@interface ACAleartView ()

@property (nonatomic, strong) ACAleartViewConfigModel *model;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, copy) ACAlertCompleteBlock complete;
@property (nonatomic, copy) ACAlertCompleteBlock cancelBlock;

@end

@implementation ACAleartView

+ (ACAleartView *)creaetAlertView:(UIView *)spView model:(ACAleartViewConfigModel * _Nullable)model title:(NSString * _Nullable)title content:(NSString * _Nullable)content cancel:(NSString * _Nullable)cancel confirm:(NSString * _Nullable)confirm complete:(ACAlertCompleteBlock _Nullable)block cancelBlock:(ACAlertCcancelBlock _Nullable)cancelBlock {
    ACAleartView *v = [[ACAleartView alloc] initWithFrame:CGRectMake(0, 0, spView.frame.size.width, spView.frame.size.height) model:model title:title content:content cancel:cancel confirm:confirm];
    v.complete = block;
    v.cancelBlock = cancelBlock;
    [spView addSubview:v];
    [v showAlertView];
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame model:(ACAleartViewConfigModel *)model title:(NSString * _Nullable)title content:(NSString * _Nullable)content cancel:(NSString *)cancel confirm:(NSString * _Nullable)confirm {
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        if (!self.model) {
            self.model = [[ACAleartViewConfigModel alloc] init];
        }
        self.confirmAutoRemove = YES;
        [self _initViewTitle:title content:content cancel:cancel confirm:confirm];
    }
    return self;
}

- (void)_initViewTitle:(NSString * _Nullable)title content:(NSString * _Nullable)content cancel:(NSString *)cancel confirm:(NSString * _Nullable)confirm {
    self.backgroundColor = UIColor.clearColor;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bgView.backgroundColor = self.model.bgColor;
    [self addSubview:self.bgView];
    self.bgView.alpha = 0;
    
    // 限制横屏下最大宽度为340
    float w = MIN(self.frame.size.width - self.model.viewLeftIntervel * 2, self.model.maxWidth);
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - w) / 2.0, 320, w, 176)];
    cView.backgroundColor = self.model.contentColor;
    [self.bgView addSubview:cView];
    cView.layer.cornerRadius = self.model.cornerRadius;
    cView.layer.masksToBounds = YES;
    
    NSTextAlignment desAlign = NSTextAlignmentCenter;
    float desY = self.model.contentTopNonTitleIntervel;
    if (title.length > 0) {
        desAlign = NSTextAlignmentLeft;
        desY = self.model.contentTopIntervel;
        // 标题
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.model.titleTopIntervel, cView.frame.size.width - 40, 24)];
        titleLab.text = title;
        titleLab.textColor = self.model.titleTextColor;
        titleLab.font = self.model.titleFont;
        titleLab.textAlignment = NSTextAlignmentCenter;
        [titleLab sizeToFit];
        [titleLab setFrame:CGRectMake((cView.frame.size.width - titleLab.frame.size.width) / 2.0, self.model.titleTopIntervel, titleLab.frame.size.width, titleLab.frame.size.height)];
        [cView addSubview:titleLab];
    }
    
    UILabel *desLab = [[UILabel alloc] initWithFrame:CGRectMake(self.model.contentLeftIntervel, desY, cView.frame.size.width - self.model.contentLeftIntervel * 2, 30)];
    desLab.text = content;
    desLab.textColor = self.model.contentTextColor;
    desLab.font = self.model.desFont;
    desLab.textAlignment = desAlign;
    desLab.numberOfLines = 0;
    [desLab sizeToFit];
    [cView addSubview:desLab];
    if (title.length == 0) {
        [desLab setFrame:CGRectMake(self.model.contentLeftIntervel, desLab.frame.origin.y, cView.frame.size.width - self.model.contentLeftIntervel * 2, ceilf(desLab.frame.size.height))];
    }
    float y = CGRectGetMaxY(desLab.frame);
    
    float confirmX = 0;
    float confirmW = cView.frame.size.width;
    if (cancel.length > 0) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setFrame:CGRectMake(0, y + self.model.buttonIntervel, cView.frame.size.width / 2.0, self.model.buttonHeight)];
        [cancelBtn setTitle:cancel forState:UIControlStateNormal];
        [cView addSubview:cancelBtn];
        
        [cancelBtn setTitleColor:self.model.cancelTextColor forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[self.model.cancelTextColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
        cancelBtn.titleLabel.font = self.model.cancelButtonFont;
        
        confirmX = cView.frame.size.width / 2.0;
        confirmW = cView.frame.size.width / 2.0;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(cView.frame.size.width / 2.0, cancelBtn.frame.origin.y, self.model.lineWidth, cancelBtn.frame.size.height)];
        lineView.backgroundColor = self.model.lineColor;
        [cView addSubview:lineView];
    }
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn addTarget:self action:@selector(confirButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setFrame:CGRectMake(confirmX, y + self.model.buttonIntervel, confirmW,  self.model.buttonHeight)];
    [confirmBtn setTitle:confirm forState:UIControlStateNormal];
    [confirmBtn setTitleColor:self.model.confirmTextColor forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[self.model.confirmTextColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
    confirmBtn.titleLabel.font = self.model.confirmButtonFont;
    [cView addSubview:confirmBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, confirmBtn.frame.origin.y, cView.frame.size.width, self.model.lineWidth)];
    lineView.backgroundColor = self.model.lineColor;
    [cView addSubview:lineView];
    
    [cView setFrame:CGRectMake(cView.frame.origin.x, (self.frame.size.height - CGRectGetMaxY(confirmBtn.frame)) / 2.0, CGRectGetWidth(cView.frame), CGRectGetMaxY(confirmBtn.frame))];
}

- (void)confirButtonAction {
    if (self.complete) {
        self.complete();
    }
    if (self.confirmAutoRemove) {
        [self removeAlertView];
    }
}

- (void)cancelButtonAction {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeAlertView];
}

- (void)showAlertView {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAlertView {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
