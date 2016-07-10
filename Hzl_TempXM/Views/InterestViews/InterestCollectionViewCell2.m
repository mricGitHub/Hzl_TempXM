//
//  InterestCollectionViewCell2.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/22.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "InterestCollectionViewCell2.h"
#import "InterestModel.h"
#import "UIImageView+WebCache.h"


@implementation InterestCollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    
    return self;
}

- (void)layoutUI {
    

    _customTitleLabel = [[UILabel alloc] init];
    _customTitleLabel.numberOfLines = 0;
    _customTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _customNameLabel = [[UILabel alloc] init];
    _customNameLabel.textAlignment = NSTextAlignmentRight;
    _customNameLabel.textColor = [UIColor lightGrayColor];
    _customNameLabel.font = [UIFont systemFontOfSize:11];
    
    [self.contentView sd_addSubviews:@[_customTitleLabel, _customNameLabel]];
    
    _customTitleLabel.sd_layout.leftSpaceToView(self.contentView, 2).rightSpaceToView(self.contentView, 2).topSpaceToView(self.contentView, 2).heightRatioToView(self.contentView, 0.8);
    
    _customNameLabel.sd_layout.rightSpaceToView(self.contentView, 5).bottomSpaceToView(self.contentView, 5).topEqualToView(self.contentView).heightRatioToView(self.contentView, 0.16);
    
}

- (void)setModel:(InterestModel *)model {
    
  
    _customNameLabel.text = model.auther_name;
    _customTitleLabel.text = model.title;
    
}

@end
