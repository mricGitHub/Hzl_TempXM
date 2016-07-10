//
//  AboutMeViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/24.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    [self layoutNav];
}

- (void)layoutNav {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"<<返回" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    leftItem.tintColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text = @"关于我们";
    label.textColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    
    self.navigationItem.titleView = label;
    
    
}

- (void)itemClick {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)layoutUI {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64, self.view.width - 40, 100)];
    label.numberOfLines = 0;
    label.text = @"版本号:1.0\n如发现bug请联系我们:hzl_china@126.com";
    label.textColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:15];
    
    [self.view addSubview:label];
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
