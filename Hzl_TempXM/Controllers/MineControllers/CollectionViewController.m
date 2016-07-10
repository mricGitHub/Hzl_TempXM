//
//  CollectionViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/24.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "CollectionViewController.h"
#import "InterestModel.h"
#import "InterestCollectionViewCell2.h"
#import "DBManager.h"
#import "InterestDetailViewController.h"


@interface CollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self layoutCollectionView];
    [self layoutNav];
    [self loadData];
    
}

- (void)layoutNav {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"<<返回" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    leftItem.tintColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    label.text = @"收藏";
    label.textColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16];
    
    self.navigationItem.titleView = label;
    
    
}

- (void)itemClick {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadData {
    
    DBManager *manager = [DBManager shareManager];
    _dataArray = [[manager getAllOfModels] mutableCopy];
    [_collectionView reloadData];
}


- (void)layoutCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64- 49) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[InterestCollectionViewCell2 class] forCellWithReuseIdentifier:@"cellC"];
    

}

#pragma mark - collectionVoewDelegate 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InterestModel *model = _dataArray[indexPath.item];
    
    InterestCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellC" forIndexPath:indexPath];
    cell.model = model;
    
    cell.backgroundColor = [UIColor colorWithRed:205 / 255.0 green:241 / 255.0 blue:223 / 255.0 alpha:1];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor blackColor] CGColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
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
