//
//  JokeViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/20.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "JokeViewController.h"

@interface JokeViewController ()

@end

@implementation JokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMode:1];
    [self loadDataUrl:JOKE_URL];
    
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
