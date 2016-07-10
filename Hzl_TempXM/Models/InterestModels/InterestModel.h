//
//  InterestModel.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/21.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *thumbnail_mpic;
@property (nonatomic, strong) NSString *thumbnail_pic;
@property (nonatomic, strong) NSString *weburl;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSString *auther_name;

@end
