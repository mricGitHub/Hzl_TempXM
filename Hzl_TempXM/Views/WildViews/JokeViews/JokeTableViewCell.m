//
//  JockTableViewCell.m
//  Hzl_TempXM
//
//  Created by 苏超 on 16/6/17.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "JokeTableViewCell.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"

@implementation JokeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    _headerImageView = [[UIImageView alloc] init];
    
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor grayColor];
    
    _passtimeLabel = [[UILabel alloc] init];
    _passtimeLabel.font = [UIFont systemFontOfSize:13];
    _passtimeLabel.textColor = [UIColor grayColor];
    
    _cusotmTextLabel = [[UILabel alloc] init];
    _cusotmTextLabel.numberOfLines = 0;
    _cusotmTextLabel.font = [UIFont systemFontOfSize:16];
    _cusotmTextLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    
    
    _labelImageView = [[UIImageView alloc] init];
    _labelImageView.image = [UIImage imageNamed:@"标签.png"];
    
    _labelLabel = [[UILabel alloc] init];
    _labelLabel.font = [UIFont systemFontOfSize:14];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor darkGrayColor];
    
    
    
    [self.contentView sd_addSubviews:@[_headerImageView, _nameLabel, _passtimeLabel, _cusotmTextLabel, _labelImageView, _labelLabel, _contentLabel]];
    
    _headerImageView.sd_layout.widthIs(30).heightIs(30).topSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10);
    
    _nameLabel.sd_layout.topEqualToView(_headerImageView).leftSpaceToView(_headerImageView, 10).heightIs(14).rightSpaceToView(self.contentView, 10);
    
    _passtimeLabel.sd_layout.topSpaceToView(_nameLabel, 2).leftSpaceToView(_headerImageView, 10).heightIs(14).rightSpaceToView(self.contentView, 10);
    
    
    _cusotmTextLabel.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_headerImageView, 5).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
    
    _labelImageView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_cusotmTextLabel, 5).widthIs(20).heightIs(20);
    
    _labelLabel.sd_layout.leftSpaceToView(_labelImageView, 10).topSpaceToView(_cusotmTextLabel, 5).rightSpaceToView(self.contentView, 10).heightIs(20);
    
    _contentLabel.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_labelImageView, 5).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
    
    _headerImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    [_passtimeLabel setSingleLineAutoResizeWithMaxWidth:200];
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
}



- (void)setModel:(PictureModel *)model {
    
    _model = model;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headerIcon]];
    _nameLabel.text = model.name;
    _passtimeLabel.text = model.passtime;
    _cusotmTextLabel.text = model.text;
    _contentLabel.text = [NSString stringWithFormat:@"--最屌评论:%@", model.content];
    NSMutableString *str = [NSMutableString string];
    for (NSString *tempStr in model.tags) {
        [str appendFormat:@"~~%@", tempStr];
    }
    [str appendString:@"~~"];
    _labelLabel.text = str;
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:5];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
