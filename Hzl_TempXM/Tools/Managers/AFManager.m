//
//  AFManager.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/13.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "AFManager.h"


@implementation AFManager
static AFManager *manager = nil;
+ (AFManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFManager alloc] init];
    });
    return manager;
}



@end
