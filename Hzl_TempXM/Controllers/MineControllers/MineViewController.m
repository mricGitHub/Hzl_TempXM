//
//  MineViewController.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/4.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "MineViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "CollectionViewController.h"
#import "AboutMeViewController.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MineViewController {
    
    UITableView *_tableView;
    UIView *_darkView;
    UIImageView *_headerImageView;
    
    NSArray *_titleArray;
    NSArray *_iconArray;
    
}

static CGFloat ImageOriginHeight = 200;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self layoutTableView];
    [self layoutNav];
}

- (void)layoutNav {
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    label.text = @"漫漫长路,有我为伴";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
    
    
    self.navigationItem.titleView = label;
}

- (void)loadData {
    
    _iconArray = @[@"收藏.png", @"夜间模式.png", @"关于我们.png"];
    _titleArray = @[@"收藏", @"夜间模式", @"关于我们"];
    ImageOriginHeight = self.view.width * 3 / 4.0;
}


- (void)layoutTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0 - ImageOriginHeight, self.view.width, ImageOriginHeight)];
    [_headerImageView setImage:[UIImage imageNamed:@"Header_Top.jpg"]];
    [_tableView addSubview:_headerImageView];
    
    _tableView.contentInset = UIEdgeInsetsMake(ImageOriginHeight, 0, 0, 0);
    
    _darkView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        if (indexPath.row == 0 || indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else if (indexPath.row == 1) {
            
            UISwitch *swi = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.width - 70, 5, 40, 34)];
            swi.onTintColor = [UIColor colorWithRed:17 / 255.0 green:205 / 255.0 blue:110 / 255.0 alpha:1];
            [swi addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:swi];
            
        }
        
        
        
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_iconArray[indexPath.row]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        CollectionViewController *vc = [[CollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        
        AboutMeViewController * vc = [[AboutMeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}




- (void)changeValue:(UISwitch *)swi {
    
    _darkView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    if (swi.on) {
        UIApplication *app = [UIApplication sharedApplication];
        AppDelegate *delegate = app.delegate;
        [delegate.window addSubview:_darkView];
        
        _darkView.userInteractionEnabled = NO;
    } else {
        [_darkView removeFromSuperview];
    }
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView == _tableView) {
        CGFloat yoffset = scrollView.contentOffset.y;
        CGFloat xoffset = (yoffset + ImageOriginHeight) / 2;
        
        if (yoffset < (0 - ImageOriginHeight)) {
            
            CGRect rect = _headerImageView.frame;
            rect.origin.y = yoffset;
            rect.size.height = 0 - yoffset;
            rect.origin.x = xoffset;
            rect.size.width = self.view.width + fabs(xoffset) * 2;
                                                     
            _headerImageView.frame = rect;
            
            
        }
        
        
        
        
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
