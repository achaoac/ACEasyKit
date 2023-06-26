//
//  ACUIMacro.h
//  ACEasyKit
//
//  Created by achaoacwang on 2023/6/26.
//

#ifndef ACUIMacro_h
#define ACUIMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define TAB_BAR_HEIGHT (IsIphoneXSeries()?83:49)      //49+34---->83
#define NAVI_BAR_HEIGHT (IsIphoneXSeries()?88:64)     //44+20+24
#define TAB_BAR_INTERVEL (IsIphoneXSeries()?34:0)     //34
#define NAVI_BAR_INTERVEL (IsIphoneXSeries()?24:0)    //24

//等比拉伸
#define Actual_px(x) ((SCREEN_WIDTH/375.0f)*x)    //等比拉伸高度适配

//字体
#define Curr_Font(x) ((SCREEN_WIDTH/375.0f)*x)
#define PF_Regular_Font(x) [UIFont fontWithName:@"PingFangSC-Regular" size:x]
#define PF_Medium_Font(x) [UIFont fontWithName:@"PingFangSC-Medium" size:x]
#define PF_Semibold_Font(x) [UIFont fontWithName:@"PingFangSC-Semibold" size:x]
//字体等比适配
#define PF_Actual_Regular_Font(x) [UIFont fontWithName:@"PingFangSC-Regular" size:Curr_Font(x)]
#define PF_Actual_Medium_Font(x)  [UIFont fontWithName:@"PingFangSC-Medium" size:Curr_Font(x)]
#define PF_Actual_Semibold_Font(x) [UIFont fontWithName:@"PingFangSC-Semibold" size:Curr_Font(x)]

// color
#define CONVER_COLOR_16(x,a) [UIColor colorWithRed:((float)((x & 0xFF0000) >> 16)) / 255.0 green:((float)((x & 0xFF00) >> 8)) / 255.0 blue:((float)(x & 0xFF)) / 255.0 alpha:a]
#define COLOR_O CONVER_COLOR_16(0xF57D23,1.0)
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]

//********************* create UI *********************//

#define getx(view)             CGRectGetMinX(view.frame)
#define gety(view)             CGRectGetMinY(view.frame)
#define getwidth(view)         CGRectGetWidth(view.frame)
#define getheight(view)        CGRectGetHeight(view.frame)

#define gx(view)                getx(view)//获取view x坐标
#define gr(view)                (getx(view) + getwidth(view))//获取view的右边沿x坐标
#define gy(view)                gety(view)//获取view y坐标
#define gb(view)                (gety(view) + getheight(view))//获取view的下边沿y坐标
#define gw(view)                getwidth(view)//获取view 宽度
#define gh(view)                getheight(view)//获取view 高度
#define gs(view)                view.frame.size//获取view size
#define go(view)                view.frame.origin//获取view origin
#define gc(view)                view.center//获取view中心 center
#define gcx(view)               view.center.x//获取view中心的x
#define gcy(view)               view.center.y//获取view中心的Y

static inline void set_x(UIView *view, CGFloat x) {
    CGRect frame = view.frame;
    frame.origin = CGPointMake(x, gy(view));
    view.frame = frame;
}

static inline void set_y(UIView *view, CGFloat y) {
    CGRect frame = view.frame;
    frame.origin = CGPointMake(gx(view), y);
    view.frame = frame;
}

static inline void set_width(UIView *view, CGFloat width) {
    CGRect frame = view.frame;
    frame.size = CGSizeMake(width, gh(view));
    view.frame = frame;
}

static inline void set_height(UIView *view, CGFloat height) {
    CGRect frame = view.frame;
    frame.size = CGSizeMake(gw(view), height);
    view.frame = frame;
}

static inline void set_origin(UIView *view, CGPoint origin) {
    CGRect frame = view.frame;
    frame.origin = origin;
    view.frame = frame;
}

static inline void set_size(UIView *view, CGSize size) {
    CGRect frame = view.frame;
    frame.size = size;
    view.frame = frame;
}

#endif /* ACUIMacro_h */
