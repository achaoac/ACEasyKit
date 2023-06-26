//
//  ACSegmentCtrl.m
//  ACEasyKit
//
//  Created by achaoacwang on 2022/12/8.
//  Copyright © 2022 achaoacwang All rights reserved.
//

#import "ACSegmentCtrl.h"

static int const gTitleLabelTag = 100;

@implementation ACSegmentCtrlConfig

- (instancetype)init {
    if (self = [super init]) {
        self.defaultIndex = 0;
        self.lrInterval = 16;
        self.interval = 24;
        self.isCenterShow = YES;
        self.bgColor = UIColor.whiteColor;
        self.lightTitleColor = [UIColor colorWithRed:47/255.0 green:123/255.0 blue:246/255.0 alpha:1];
        self.defaultTitleColor = UIColor.blackColor;
        self.lightTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        self.defaultTitleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        self.isLineShow = YES;
        self.lineColor = [UIColor colorWithRed:47/255.0 green:123/255.0 blue:246/255.0 alpha:1];
        self.lineWidth = 40;
        self.lineHeight = 2;
    }
    return self;
}

@end

@interface ACSegmentCtrl ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *viewArr;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) UIScrollView *sView;
@property (nonatomic, assign) int curr_index;
@property (nonatomic, strong) ACSegmentCtrlConfig *config;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ACSegmentCtrl

+ (ACSegmentCtrl *)creaetSegmentCtrl:(UIView *)spView frame:(CGRect)frame titles:(NSArray <NSString *> * _Nullable)titles delegate:(id<ACSegmentCtrlDelegate>)delegate config:(ACSegmentCtrlConfig * _Nullable)config {
    ACSegmentCtrl *v = [[ACSegmentCtrl alloc] initWithFrame:frame titles:titles delegate:delegate config:config];
    [spView addSubview:v];
    return v;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles delegate:(id<ACSegmentCtrlDelegate>)delegate config:(ACSegmentCtrlConfig *)config {
    if (self = [super initWithFrame:frame]) {
        if (!config) {
            self.config = [[ACSegmentCtrlConfig alloc] init];
        } else {
            self.config = config;
        }
        self.delegate = delegate;
        self.curr_index = -1;
        self.viewArr = [NSMutableArray array];
        [self _initView:titles];
    }
    return self;
}

- (void)_initView:(NSArray *)titles {
    self.backgroundColor = self.config.bgColor;
    
    UIScrollView *sView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    sView.showsHorizontalScrollIndicator = NO;
    [self addSubview:sView];
    self.sView = sView;
    
    if (self.config.isLineShow) {
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sView.frame.size.height - self.config.lineHeight, self.config.lineWidth, self.config.lineHeight)];
        self.lineView.backgroundColor = self.config.lineColor;
        [self.sView addSubview:self.lineView];
    }
    
    [self updateCateView:titles];
}

- (void)updateCateView:(NSArray <NSString *> *)titles {
    self.titles = titles;
    [self.sView setFrame:CGRectMake(0, self.sView.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    for (int i = 0; i < self.viewArr.count; i++) {
        UIView *v = self.viewArr[i];
        [v removeFromSuperview];
    }
    [self.viewArr removeAllObjects];
    float leftInterval = self.config.lrInterval - self.config.interval / 2.0;
    float x = leftInterval;
    for (int i = 0; i < self.titles.count; i++) {
        // 内容区
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 60, self.sView.frame.size.height)];
        [self.sView addSubview:v];
        [self.viewArr addObject:v];
        
        NSString *title = self.titles[i];
        // 标题
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(self.config.interval / 2.0, 0, 30, 30)];
        lab.text = title;
        lab.textColor = self.config.defaultTitleColor;
        lab.font = self.config.defaultTitleFont;
        lab.textAlignment = NSTextAlignmentCenter;
        [v addSubview:lab];
        // 固定tag，方便寻找
        lab.tag = gTitleLabelTag;
        [lab sizeToFit];
        [v setFrame:CGRectMake(x, 0, lab.frame.size.width + self.config.interval, v.frame.size.height)];
        [lab setFrame:CGRectMake(0, (v.frame.size.height - 30) / 2.0, v.frame.size.width, 30)];
        
        // 按钮响应点击事件
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(segButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, 0, v.frame.size.width, v.frame.size.height)];
        [v addSubview:btn];
        btn.tag = i;
        x = x + v.frame.size.width;
    }
    x = x + leftInterval;
    if (x < self.frame.size.width) {
        [self.sView setFrame:CGRectMake(self.config.isCenterShow ? (self.frame.size.width - x) / 2.0 : 0, self.sView.frame.origin.y, x, self.frame.size.height)];
    }
    [self.sView setContentSize:CGSizeMake(x, self.sView.frame.size.height)];
    
    [self scrollToIndex:self.config.defaultIndex];
}

- (void)segButtonClickAction:(UIButton *)btn {
    if (self.curr_index == btn.tag) {
        return;
    }
    [self scrollToIndex:(int)btn.tag];
}

- (void)scrollToIndex:(int)index {
    self.curr_index = index;
    [self updateUI];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ACSegmentCtrlDelegateIndexChanged:)]) {
        [self.delegate ACSegmentCtrlDelegateIndexChanged:self.curr_index];
    }
}

- (void)updateUI {
    float x = 0;
    for (int i = 0; i < self.viewArr.count; i++) {
        UIView *v = self.viewArr[i];
        UILabel *lab = [v viewWithTag:gTitleLabelTag];
        if (i == self.curr_index) {
            lab.textColor = self.config.lightTitleColor;
            lab.font = self.config.lightTitleFont;
            if (self.lineView) {
                [self.lineView setFrame:CGRectMake(v.center.x - self.lineView.frame.size.width / 2.0, self.lineView.frame.origin.y, self.lineView.frame.size.width, self.lineView.frame.size.height)];
            }
            x = v.center.x;
        } else {
            lab.textColor = self.config.defaultTitleColor;
            lab.font = self.config.defaultTitleFont;
        }
    }
    // 滑动的横坐标
    float s_x = x - self.sView.frame.size.width / 2.0;
    // 左边容错
    s_x = MAX(s_x, 0);
    // 右边容错
    s_x = MIN(s_x, self.sView.contentSize.width - self.sView.frame.size.width);
    [self.sView setContentOffset:CGPointMake(s_x, 0) animated:YES];
}

@end

