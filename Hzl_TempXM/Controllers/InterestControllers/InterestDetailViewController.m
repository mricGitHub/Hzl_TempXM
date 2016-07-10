//
//  InterestDetailViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/22.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "InterestDetailViewController.h"
#import <WebKit/WebKit.h>
#import "DBManager.h"


@interface InterestDetailViewController () <WKNavigationDelegate>

@end

@implementation InterestDetailViewController {
    
    WKWebView *_webView;
    UILabel *_label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self layoutNav];
    [self layoutWebView];

}



- (void)layoutNav {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"<<返回" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    leftItem.tintColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"Collection_no.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Collection.png"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(0, 0, 40, 40);
    DBManager *manager = [DBManager shareManager];
    btn.selected =  [manager isFavorite:_model.title];
    
    [btn addTarget:self action:@selector(coClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)itemClick {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)coClick:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        DBManager *manager = [DBManager shareManager];
        [manager createTable];
        [manager insertModelData:_model];
        
    } else {
        
        DBManager *manager = [DBManager shareManager];
        [manager createTable];
        [manager removeModelFromDB:_model.title];
        
    }
    
}

- (void)layoutWebView {
    
    
    
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
    [self.view addSubview:_webView];
    _webView.navigationDelegate = self;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_model.weburl] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:1];
       dispatch_async(dispatch_get_main_queue(), ^{
          
           [_webView loadRequest:request];
       });
    });

    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 2 - 50, 64, 100, 30)];
    _label.textColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    _label.text = @"开始加载...";
    [self.view addSubview:_label];
    
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    _label.text = @"正在加载...";
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    _label.text = @"加载完成...";
    
    
    [UIView animateWithDuration:1 animations:^{
        _label.frame = CGRectMake(self.view.width - 200, 200, 100, 30);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            _label.frame = CGRectMake(self.view.width, 0, 0, 0);
            
        } completion:^(BOOL finished) {
            [_label removeFromSuperview];
            _label = nil;
        }];
        
    }];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%@", error);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
