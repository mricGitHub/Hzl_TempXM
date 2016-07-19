//
//  JockTableViewCell.h
//  Hzl_TempXM
//
//  Created by 苏超 on 16/6/17.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
@class PictureModel;
@class WildBaseViewController;


@interface JokeTableViewCell : UITableViewCell


@property (nonatomic, strong) PictureModel *model;

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *passtimeLabel;

@property (nonatomic, strong) UILabel *cusotmTextLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UIImageView *labelImageView;
@property (nonatomic, strong) UILabel *labelLabel;
@property (nonatomic, strong) UIButton *reportBtn;
@property (nonatomic, weak) WildBaseViewController *wildController;

- (void)setModel:(PictureModel *)model;

@end
