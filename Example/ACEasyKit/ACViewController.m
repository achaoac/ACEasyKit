//
//  ACViewController.m
//  ACEasyKit
//
//  Created by aclct@icloud.com on 06/25/2023.
//  Copyright (c) 2023 aclct@icloud.com. All rights reserved.
//

#import "ACViewController.h"
#import <ACEasyKit/ACEasyKit.h>

@interface ACViewController () <UITableViewDelegate,UITableViewDataSource, ACSegmentCtrlDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ACRouter configRouter:nil classMaps:@{
        @"testVC" : @"",
    }];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"展示 弹框",
                                                    @"展示 toast",
                                                    @"路由跳转",
                                                  ]];
    
    [self _initView];
}

- (void)_initView {
    [ACSegmentCtrl creaetSegmentCtrl:self.view frame:CGRectMake(0, NAVI_BAR_HEIGHT + 16, self.view.frame.size.width, 40) titles:@[@"test1",@"test2",@"test3",@"test4",@"test5",@"test6",@"test7",@"test8",@"test9"] delegate:self config:nil];
    [self initTableView];
}

- (void)initTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVI_BAR_HEIGHT + 70, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.estimatedRowHeight = 44;
    tableView.delegate = self;
    tableView.dataSource = self;
    UIView *fView = [[UIView alloc] init];
    fView.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:fView];
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.text = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: { // ACAleartView
            [ACAleartView creaetAlertView:self.view model:nil title:@"hello" content:@"Info.plist contained no UIScene configuration dictionary (looking for configuration named !" cancel:@"cancel" confirm:@"OK" complete:^{
                NSLog(@"confirm click");
            } cancelBlock:^{
                NSLog(@"cancel click");
            }];
        }
            break;
        case 1: { // ACToast
            [ACToastView showToast:@"this is a toast!"];
        }
            break;
        case 2: { //
            [ACRouter jump:[ACRouter routerUrl:@"testVC"]];
        }
            break;
        default:
            break;
    }
}

#pragma mark - ACSegmentCtrlDelegate
- (void)ACSegmentCtrlDelegateIndexChanged:(int)index {
    NSLog(@"index-%d",index);
}

@end
