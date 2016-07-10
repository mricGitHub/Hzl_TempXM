//
//  WildViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/4.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "WildViewController.h"
#import "PictureViewController.h"
#import "JokeViewController.h"
#import "VideoViewController.h"
#import "UIView+SDAutoLayout.h"

@interface WildViewController () <UIScrollViewDelegate>

@end

@implementation WildViewController {
    
    UIScrollView *_scrollView;
    NSArray *_arr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutScrollView];
    [self layoutNav];
    
}

- (void)layoutNav {
    
    self.navigationItem.titleView = [self layoutBtns];
    
    
}

- (UIView *)layoutBtns {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 60, 44)];
    NSArray *titleArray = @[@"图片", @"文字", @"视频"];
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(i * (view.width - 60) / 3 + 30, 20, (view.width - 100) / 3, 20);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [btn setTintColor:[UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1]];
        btn.tag = 10 + i;
        [view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return view;
}

- (void)layoutScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 -49)];
    [self.view addSubview:_scrollView];
    
    
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(self.view.width * 3, 0);
    

    PictureViewController *pvc = [[PictureViewController alloc] init];
    JokeViewController *jvc = [[JokeViewController alloc] init];
    VideoViewController *vvc = [[VideoViewController alloc] init];
    _arr = @[pvc, jvc, vvc];
    
    for (int i = 0; i < _arr.count; i ++) {
        WildBaseViewController *wildVC = _arr[i];
        [self addChildViewController:wildVC];
        wildVC.view.frame = CGRectMake(_scrollView.width * i, -64, _scrollView.width, _scrollView.height + 64 + 49);
        [_scrollView addSubview:wildVC.view];
    }
    
}

- (void)btnClick:(UIButton *)btn {
    
    [_scrollView setContentOffset:CGPointMake((btn.tag - 10) * _scrollView.bounds.size.width, 0) animated:NO];
    
    int index = (int)(btn.tag - 10);
    
    if (index != 2) {
        for (UIView *view in ((WildBaseViewController *)_arr[2]).view.subviews) {
            [view removeFromSuperview];
        }
    } else {
        [((WildBaseViewController *)_arr[2]) repeatLoad];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
