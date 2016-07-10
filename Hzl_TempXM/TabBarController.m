//
//  TabBarController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/4.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "TabBarController.h"
#import "WildViewController.h"
#import "InterestViewController.h"
#import "MineViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createConnect];
    
    
}

- (void)createConnect {
    
    NSArray *titleArray = @[@"狂欢城", @"兴趣", @"我的"];
    NSArray *imageNameArray = @[@"狂欢城", @"兴趣", @"我的"];
    NSArray *selectedImageNameArray = @[@"狂欢城_on", @"兴趣_on", @"我的_on"];
    NSArray *classes = @[[WildViewController class], [InterestViewController class], [MineViewController class]];
    
    NSMutableArray *navArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIViewController *vc = [[classes[i] alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [navArray addObject:nav];
        
    }
    
    self.viewControllers = navArray;
    for (int i = 0; i < self.tabBar.items.count; i ++) {
        
        UIImage *image = [[UIImage imageNamed:imageNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:selectedImageNameArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem *item = self.tabBar.items[i];
        item = [item initWithTitle:titleArray[i] image:image selectedImage:selectedImage];
    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1]} forState:UIControlStateSelected];
    
    self.selectedIndex = 2;
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
