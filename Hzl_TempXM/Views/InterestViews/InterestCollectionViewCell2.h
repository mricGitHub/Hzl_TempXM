//
//  InterestCollectionViewCell2.h
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/22.
//  Copyright © 2016年 mric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"
@class InterestModel;


@interface InterestCollectionViewCell2 : UICollectionViewCell

@property (nonatomic, strong) UILabel *customNameLabel;
@property (nonatomic, strong) UILabel *customTitleLabel;

@property (nonatomic, strong) InterestModel *model;

@end
