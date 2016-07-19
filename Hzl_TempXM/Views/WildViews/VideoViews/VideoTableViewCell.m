//
//  VideoTableViewCell.m
//  Hzl_TempXM
//
//  Created by 苏超 on 16/6/17.
//  Copyright © 2016年 mric. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"
#import "PLMoviePlayer.h"
#import "PLMovieManager.h"
#import "WildBaseViewController.h"

@implementation VideoTableViewCell

static PLMoviePlayer *_mv;

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
    
    _mainImageView = [[UIImageView alloc] init];
    _mainImageView.backgroundColor = [UIColor lightGrayColor];
    _mainImageView.userInteractionEnabled = YES;
    
    _labelImageView = [[UIImageView alloc] init];
    _labelImageView.image = [UIImage imageNamed:@"标签.png"];
    
    _labelLabel = [[UILabel alloc] init];
    _labelLabel.font = [UIFont systemFontOfSize:14];
    
    _reportBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_reportBtn setTitle:@"举报内容" forState:UIControlStateNormal];
    [_reportBtn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor darkGrayColor];
    
    
    _videoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_videoBtn setImage:[[UIImage imageNamed:@"pl_play.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _videoBtn.tag = 101;
    [_videoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView sd_addSubviews:@[_headerImageView, _nameLabel, _passtimeLabel, _cusotmTextLabel, _mainImageView, _labelImageView, _labelLabel, _reportBtn, _contentLabel]];
    
    [_mainImageView sd_addSubviews:@[_videoBtn]];
    
    _headerImageView.sd_layout.widthIs(30).heightIs(30).topSpaceToView(self.contentView, 10).leftSpaceToView(self.contentView, 10);
    
    _nameLabel.sd_layout.topEqualToView(_headerImageView).leftSpaceToView(_headerImageView, 10).heightIs(14).rightSpaceToView(self.contentView, 10);
    
    _passtimeLabel.sd_layout.topSpaceToView(_nameLabel, 2).leftSpaceToView(_headerImageView, 10).heightIs(14).rightSpaceToView(self.contentView, 10);
    
    
    _cusotmTextLabel.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_headerImageView, 5).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
    
    _mainImageView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_cusotmTextLabel, 5).rightSpaceToView(self.contentView, 10);
    
    _labelImageView.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_mainImageView, 5).widthIs(20).heightIs(20);
    
    _labelLabel.sd_layout.leftSpaceToView(_labelImageView, 10).topSpaceToView(_mainImageView, 5).rightSpaceToView(self.contentView, 100).heightIs(20);
    
    _reportBtn.sd_layout.rightSpaceToView(self.contentView, 10).heightIs(20).topEqualToView(_labelLabel).widthIs(80);
    
    _contentLabel.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(_labelImageView, 5).rightSpaceToView(self.contentView, 10).autoHeightRatio(0);
    
    _videoBtn.sd_layout.centerXEqualToView(_mainImageView).centerYEqualToView(_mainImageView).heightIs(40).widthIs(40);
    
    
    _headerImageView.sd_cornerRadiusFromWidthRatio = @(0.5);
    [_passtimeLabel setSingleLineAutoResizeWithMaxWidth:200];
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:150];
    
}



- (void)setModel:(PictureModel *)model {
    
    _model = model;
    
    [_mv plMoviePlayDidEnd];
    
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
    
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.video_image]];
    
    
    _mainImageView.sd_layout.autoHeightRatio(  _model.height * 1.0 / _model.width);
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:5];
    
    
}

- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"btn click");
    [_mv plMoviePlayDidEnd];
    
    _mv = [[PLMoviePlayer alloc] initWithFrame:_mainImageView.bounds MovieUrl:_model.video];
    [_mv setReleaseCurrentPageBlock:^{
        
    }];
    [_mainImageView addSubview:_mv];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)btnClick1:(UIButton *)btn {
    
    UIAlertController *cl = [UIAlertController alertControllerWithTitle:@"举报内容" message:@"确认举报内容？举报后我们将尽快处理。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *destru = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [cl addAction:report];
    [cl addAction:destru];
    if (_wildController) {
        [_wildController presentViewController:cl animated:YES completion:nil];
    }
    
}

@end
