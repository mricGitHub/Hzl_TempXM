//
//  PLMovieManager.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/20.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "PLMovieManager.h"

@implementation PLMovieManager

static PLMovieManager * _sharedPLMovieManager;

+ (PLMoviePlayer *)shareManagerandFrame:(CGRect)frame withURLStr:(NSString *)urlStr{
    
    if (_sharedPLMovieManager) {
        [_sharedPLMovieManager plMoviePlayDidEnd];
    }
    
    _sharedPLMovieManager =  [[PLMovieManager alloc] initWithFrame:frame MovieUrl:urlStr];
    
    return _sharedPLMovieManager;
}

@end
