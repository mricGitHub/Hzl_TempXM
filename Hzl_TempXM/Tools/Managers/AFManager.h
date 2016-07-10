//
//  AFManager.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/13.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface AFManager : AFHTTPSessionManager

+ (AFManager *)sharedManager;

@end
