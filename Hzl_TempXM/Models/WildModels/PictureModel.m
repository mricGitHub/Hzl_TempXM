//
//  PIctureModel.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/13.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

- (instancetype)init {
    
    if (self = [super init]) {
        _tags = [NSMutableArray array];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
