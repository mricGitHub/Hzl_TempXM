//
//  WildBaseViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/17.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "WildBaseViewController.h"


#import "AFManager.h"
#import "PictureModel.h"
#import "PictureTableViewCell.h"
#import "JokeTableViewCell.h"
#import "VideoTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "SDImageCache.h"
#import "MJRefresh.h"

@interface WildBaseViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation WildBaseViewController {
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSInteger _np;
    NSString *_urlString;
    NSInteger _mode;
    
    Class _classMode;
}

- (void)setMode:(NSInteger)mode {
    _mode = mode;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _dataArray = [NSMutableArray array];
    _np = 0;
    
    [self layoutTableView];
    
    
}

- (void)loadDataUrl:(NSString *)urlStirng {
    _urlString = urlStirng;
    
    AFManager *manager = [AFManager sharedManager];
    [manager GET:[NSString stringWithFormat:urlStirng, _np] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (_np == 0) {
            [_dataArray removeAllObjects];
        }
        
        _np = [responseObject[@"info"][@"np"] integerValue];
        NSArray *tempArray = responseObject[@"list"];
        for (NSDictionary *tempDict in tempArray) {
            PictureModel *model = [[PictureModel alloc] init];
            
            
            
            model.text = tempDict[@"text"];
            model.type = tempDict[@"type"];
            model.share_url = tempDict[@"share_url"];
            model.Id = tempDict[@"id"];
            model.passtime = tempDict[@"passtime"];
            
            NSArray *tagArray = tempDict[@"tags"];
            for (NSDictionary *tagDict in tagArray) {
                [model.tags addObject:tagDict[@"name"]];
            }
            
            model.content = tempDict[@"top_comment"][@"content"];
            model.name = tempDict[@"u"][@"name"];
            model.headerIcon = [tempDict[@"u"][@"header"] firstObject];
            
            if ([model.type isEqualToString:@"image"]) {
                NSDictionary *imageDict = tempDict[@"image"];
                model.image_big = [imageDict[@"big"] firstObject];
                model.image_medium = [imageDict[@"medium"] firstObject];
                model.image_small = [imageDict[@"small"] firstObject];
                model.width = [imageDict[@"width"] integerValue];
                model.height = [imageDict[@"height"] integerValue];
            } else if ([model.type isEqualToString:@"gif"]) {
                
                NSDictionary *imageDict = tempDict[@"gif"];
                model.gif = [imageDict[@"images"] firstObject];
                model.gif_image = [imageDict[@"gif_thumbnail"]firstObject];
                model.width = [imageDict[@"width"] integerValue];
                model.height = [imageDict[@"height"] integerValue];
                
            } else if ([model.type isEqualToString:@"text"]) {
                

                
            } else if ([model.type isEqualToString:@"video"]) {
                
                NSDictionary *imageDict = tempDict[@"video"];
                model.video = [imageDict[@"video"] firstObject];
                model.video_image = [imageDict[@"thumbnail"] firstObject];
                model.width = [imageDict[@"width"] integerValue];
                model.height = [imageDict[@"height"] integerValue];
                
            } else {
                NSLog(@"loadData error");
            }
            
            
            [_dataArray addObject:model];
            
        }
        
        
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
    
}

- (void)layoutTableView {
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[PictureTableViewCell class] forCellReuseIdentifier:@"cell0"];
    [_tableView registerClass:[JokeTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[VideoTableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    
    __weak typeof(self) weakSelf = self;
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _np = 0;
        [weakSelf loadDataUrl:_urlString];
        
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadDataUrl:_urlString];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureModel *model = _dataArray[indexPath.row];
    
    UITableViewCell *resultCell;
    switch (_mode) {
        case 0: {
            PictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
            cell.model = model;
            cell.wildController = self;
            resultCell = cell;
        }
            break;
        case 1: {
            JokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.model = model;
            cell.wildController = self;
            resultCell = cell;
        }
            
            break;
        case 2: {
            VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.model = model;
            cell.wildController = self;
            resultCell = cell;
            
        }
            
            break;
            
        default:
            NSLog(@"tableviewcell * swith error ");
            break;
    }
    
    
    
    
    
    if (indexPath.row % 8 == 0) {
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        NSLog(@"memCache");
    };
    
    //[cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    return resultCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class classmode;
    
    switch (_mode) {
        case 0:
            classmode = [PictureTableViewCell class];
            break;
        case 1:
            classmode = [JokeTableViewCell class];
            break;
        case 2:
            classmode = [VideoTableViewCell class];
            break;
            
        default:
            break;
    }
    
    
    return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row] keyPath:@"model" cellClass:classmode contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)clearChache {
    
    _dataArray = [NSMutableArray array];
    [_tableView reloadData];
    
}

- (void)repeatLoad {
    
    _dataArray = [NSMutableArray array];
    _np = 0;
    
    [self layoutTableView];
    
    switch (_mode) {
        case 0:
            [self loadDataUrl:PICTURE_URL];
            break;
        case 1:
            [self loadDataUrl:JOKE_URL];
            break;
        case 2:
            [self loadDataUrl:VIDEO_URL];
            break;
            
        default:
            NSLog(@"repeatLoad error");
            break;
    }
    
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
