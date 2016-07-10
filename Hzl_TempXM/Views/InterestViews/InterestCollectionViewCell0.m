//
//  InterestCollectionViewCell0.m
//  Hzl_TempXM
//
//  Created by qianfeng on 16/6/22.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "InterestCollectionViewCell0.h"
#import "InterestModel.h"
#import "UIImageView+WebCache.h"

@implementation InterestCollectionViewCell0


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self layoutUI];
    }
    
    return self;
}

- (void)layoutUI {
    
    _customImageView = [[UIImageView alloc] init];
    
    _customTitleLabel = [[UILabel alloc] init];
    _customTitleLabel.numberOfLines = 0;
    _customTitleLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _customNameLabel = [[UILabel alloc] init];
    _customNameLabel.textAlignment = NSTextAlignmentRight;
    _customNameLabel.textColor = [UIColor lightGrayColor];
    _customNameLabel.font = [UIFont systemFontOfSize:11];
    
    [self.contentView sd_addSubviews:@[_customImageView, _customTitleLabel, _customNameLabel]];
    
    _customImageView.sd_layout.leftEqualToView(self.contentView).topEqualToView(self.contentView).rightEqualToView(self.contentView).heightRatioToView(self.contentView, 0.8);
    
    _customTitleLabel.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).topSpaceToView(_customImageView, 2).heightRatioToView(self.contentView, 0.12);
    
    _customNameLabel.sd_layout.rightEqualToView(self.contentView).bottomEqualToView(self.contentView).leftEqualToView(self.contentView).topSpaceToView(_customTitleLabel, 2);
    
}

- (void)setModel:(InterestModel *)model {
    

    [_customImageView sd_setImageWithURL:[NSURL  URLWithString:model.thumbnail_pic]];
    _customNameLabel.text = model.auther_name;
    _customTitleLabel.text = model.title;
    
}


@end
