//
//  PictureTableViewCell.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/14.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
@class PictureModel;

@interface PictureTableViewCell : UITableViewCell

@property (nonatomic, strong) PictureModel *model;

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passtimeLabel;

@property (nonatomic, strong) UILabel *cusotmTextLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UIImageView *labelImageView;
@property (nonatomic, strong) UILabel *labelLabel;

- (void)setModel:(PictureModel *)model;

@end
