//
//  DBManager.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/24.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "InterestModel.h"

@implementation DBManager

static DBManager *_sharedDBManager;

+ (instancetype)shareManager {
    
    if (!_sharedDBManager) {
        _sharedDBManager = [[DBManager alloc] init];
        _sharedDBManager.dataBase = [[FMDatabase alloc] initWithPath:[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"date_m.db"]];
        
        if (_sharedDBManager.dataBase.close) {
            [_sharedDBManager.dataBase open];
        }
        
    }
    
    return _sharedDBManager;
}


- (void)createTable {
    
    [_dataBase open];
    
    BOOL result = [_dataBase executeUpdate:@"create table if not exists T(title text primary key,thumbnail_mpic text,thumbnail_pic text,weburl text,width integer,height integer,auther_name text)"];
    
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    
    [_dataBase close];
    
}
- (void)insertModelData:(InterestModel *)model {
    
    [_dataBase open];
    BOOL result = [_dataBase executeUpdate:@"insert into T(title,thumbnail_mpic,thumbnail_pic,weburl,width,height,auther_name) values(?,?,?,?,?,?,?)", model.title, model.thumbnail_mpic, model.thumbnail_pic, model.weburl, @(model.width), @(model.height), model.auther_name];
    if (result) {
        NSLog(@"插入成功");
    } else {
        NSLog(@"插入失败");
    }
    [_dataBase close];
    
}
- (InterestModel *)getModelFromTitle:(NSString *)title {
    
    [_dataBase open];
    
    FMResultSet *set = [_dataBase executeQuery:@"select *from T where title = ?", title];
    InterestModel *model = [[InterestModel alloc] init];

    while ([set next]) {
        model.title = [set stringForColumn:@"title"];
        model.thumbnail_mpic = [set stringForColumn:@"thumbnail_mpic"];
        model.thumbnail_pic = [set stringForColumn:@"thumbnail_pic"];
        model.weburl = [set stringForColumn:@"weburl"];
        model.width = [set longForColumn:@"width"];
        model.height = [set longForColumn:@"height"];
        model.auther_name = [set stringForColumn:@"auther_name"];
        
    }
    [_dataBase close];
    
    return model;
}
- (BOOL)isFavorite:(NSString *)title {
    
    [_dataBase open];
    BOOL back = NO;
    FMResultSet *set = [_dataBase executeQuery:@"select *from T where title = ?", title];
    while ([set next]) {
        back = YES;
    }

    [_dataBase close];
    return back;
}
- (void)removeModelFromDB:(NSString *)title {
    
    [_dataBase open];
    BOOL result = [_dataBase executeUpdate:@"delete from T where title = ?", title];
    if (result) {
        NSLog(@"取消收藏成功");
    } else {
        NSLog(@"取消收藏失败");
    }
    [_dataBase close];
    
}
- (NSArray *)getAllOfModels {
    
    [_dataBase open];
    NSMutableArray *arr = [NSMutableArray array];
    FMResultSet *set = [_dataBase executeQuery:@"select *from T"];
    
    while ([set next]) {
        
        InterestModel *model = [[InterestModel alloc] init];
        model.title = [set stringForColumn:@"title"];
        model.thumbnail_mpic = [set stringForColumn:@"thumbnail_mpic"];
        model.thumbnail_pic = [set stringForColumn:@"thumbnail_pic"];
        model.weburl = [set stringForColumn:@"weburl"];
        model.width = [set longForColumn:@"width"];
        model.height = [set longForColumn:@"height"];
        model.auther_name = [set stringForColumn:@"auther_name"];
        [arr addObject:model];
    }
    
    [_dataBase close];
    return arr;
    
}

@end
