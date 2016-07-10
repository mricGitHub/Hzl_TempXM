//
//  WildBaseViewController.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/17.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "BaseViewController.h"

@interface WildBaseViewController : BaseViewController


- (void)loadDataUrl:(NSString *)urlStirng;

- (void)setMode:(NSInteger)mode;

- (void)clearChache;

- (void)repeatLoad;

@end
