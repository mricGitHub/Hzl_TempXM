//
//  DBManager.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/24.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InterestModel;
@class FMDatabase;

@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabase *dataBase;

+ (instancetype)shareManager;

- (void)createTable;
- (void)insertModelData:(InterestModel *)model;
- (InterestModel *)getModelFromTitle:(NSString *)title;
- (BOOL)isFavorite:(NSString *)title;
- (void)removeModelFromDB:(NSString *)title;
- (NSArray *)getAllOfModels;

@end
