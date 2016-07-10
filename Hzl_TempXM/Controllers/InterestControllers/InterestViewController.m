//
//  InterestViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/4.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "InterestViewController.h"
#import "UIView+Frame.h"
#import "InterestModel.h"
#import "AFManager.h"
#import "Header.h"
#import "InterestCollectionViewCell0.h"
#import "InterestCollectionViewCell1.h"
#import "InterestCollectionViewCell2.h"
#import "MJRefresh.h"
#import "InterestDetailViewController.h"

@interface InterestViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation InterestViewController {
    
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    NSString *_next_url;
    BOOL _notFirst;
    BOOL _notFirstB;
    
    UIScrollView *_scrollView;
    NSInteger _btnSelected;
    NSArray *_URLArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _next_url = ZAKER_0;
    
    _URLArr = @[ZAKER_0, ZAKER_1, ZAKER_2, ZAKER_3, ZAKER_4, ZAKER_5, ZAKER_6, ZAKER_7, ZAKER_8, ZAKER_9, ZAKER_10, ZAKER_11, ZAKER_12];
    
    _dataArray = [NSMutableArray array];
    
    [self layoutCollectionView];
    [self layoutNav];
    [self loadData];
}

- (void)layoutNav {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 80, 44)];
    self.navigationItem.titleView = view;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44 - 25, self.view.width - 80, 25)];
    [view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(12 * 70, 0);
    
    NSArray *titleArray = @[@"电影资迅", @"文艺频道", @"小视频", @"今日看点", @"冷笑话", @"图片", @"电器", @"国际事物" ,@"NBA", @"小电影", @"东方历史" ,@"别样历史"];
    
    for (int i = 0; i < 12; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 10 + i;
        btn.frame = CGRectMake(i * 70, 0, 60, 20);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:132 / 255.0 green:227 / 255.0 blue:179 / 255.0 alpha:1]] forState:UIControlStateSelected];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    }
    
    
}
         
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

         
         
         
         

- (void)btnClick:(UIButton *)btn {
    
    _btnSelected = btn.tag - 10;
    [_dataArray removeAllObjects];
    _notFirst = NO;
    _next_url = _URLArr[_btnSelected];
    [self loadData];
    
    btn.selected = !btn.selected;
    for (UIView *TempView in _scrollView.subviews) {
        if ([TempView isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)TempView;
            
            if (tempBtn.tag != btn.tag) {
                tempBtn.selected = NO;
            }
            
        }
        
        
        
    }
    
    [_scrollView setContentOffset:CGPointMake(_btnSelected * 70 - 140, 0) animated:YES];
}

- (void)loadData {
    
    _notFirstB = _notFirst;
    
    if (_next_url.length == 0) {
        NSLog(@"next_url error");
    }
    
    AFManager *manager = [AFManager sharedManager];
    [manager GET:_next_url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        if (_notFirst == NO) {
            [_dataArray removeAllObjects];
        }
        
        NSArray *arr = responseObject[@"data"][@"articles"];
        int count = 0;
        for (NSDictionary *dict in arr) {
            
            if (!_notFirst || count > 5) {
                InterestModel *model = [[InterestModel alloc] init];
                model.thumbnail_mpic = dict[@"thumbnail_mpic"];
                model.thumbnail_pic = dict[@"thumbnail_pic"];
                model.title = dict[@"title"];
                model.weburl = dict[@"weburl"];
                NSString *str = dict[@"thumbnail_picsize"];
                NSArray *strArr = [str componentsSeparatedByString:@","];
                model.height = [strArr[1] integerValue];
                model.width = [strArr[0] integerValue];
                model.auther_name = dict[@"auther_name"];
                [_dataArray addObject:model];
            }
            count ++;
        }
        _next_url = responseObject[@"data"][@"info"][@"next_url"];
        _notFirst = YES;
        [_collectionView reloadData];
        
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [_collectionView reloadData];
        
        [_collectionView.header endRefreshing];
        [_collectionView.footer endRefreshing];
    }];
    
}

- (void)layoutCollectionView {
    
    

    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:@"green.jpg"]];
    _collectionView.backgroundView = imageView;
    
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        
        _notFirst = NO;
        _next_url = _URLArr[_btnSelected];
        [self loadData];
        
    }];
    
    _collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadData];
        
    }];
    
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 49, 0));
        
    }];
    
    [_collectionView registerClass:[InterestCollectionViewCell0 class] forCellWithReuseIdentifier:@"cell0"];
    [_collectionView registerClass:[InterestCollectionViewCell1 class] forCellWithReuseIdentifier:@"cell1"];
    [_collectionView registerClass:[InterestCollectionViewCell2 class] forCellWithReuseIdentifier:@"cell2"];
    
}

#pragma mark - collectionViewDelegate


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InterestModel *model = _dataArray[indexPath.item];
    UICollectionViewCell *resultCell;
    
    if (indexPath.item %7 == 0 && _notFirstB == NO && model.thumbnail_pic != nil) {
        
        if ((model.width  * 1.0 / model.height) > (self.view.width * 1.0 / 300)) {
            
            InterestCollectionViewCell0 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell0" forIndexPath:indexPath];
            cell.model = model;
            resultCell = cell;
            
        } else {
            
            InterestCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
            cell.model = model;
            resultCell = cell;
            
        }
        
    } else {
        
        InterestCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.model = model;
        resultCell = cell;
        
    }
    
    resultCell.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    resultCell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    resultCell.layer.borderWidth = 1;
    
    return resultCell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    InterestModel *model = _dataArray[indexPath.item];

    if (indexPath.item %7 == 0 && _notFirstB == NO && model.thumbnail_pic != nil) {
        return CGSizeMake(self.view.width, 300);
    }
    
    return CGSizeMake(self.view.width / 2 - 5, 80);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InterestDetailViewController *vc = [[InterestDetailViewController alloc] init];
    vc.model = _dataArray[indexPath.item];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
