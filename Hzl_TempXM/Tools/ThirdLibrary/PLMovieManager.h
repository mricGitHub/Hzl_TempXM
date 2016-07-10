//
//  PLMovieManager.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/20.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "PLMoviePlayer.h"

@interface PLMovieManager : PLMoviePlayer

+ (PLMoviePlayer *)shareManagerandFrame:(CGRect)frame withURLStr:(NSString *)urlStr;

@end
