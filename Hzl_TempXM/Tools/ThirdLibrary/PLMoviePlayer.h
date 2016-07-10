//
//  PLMoviePlayer.h
//  VideoPlayer
//
//  Created by qianfeng on 16/6/12.
//  Copyright © 2016年 潘乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLMoviePlayer : UIView

/**
 记得设置block释放掉本页
 */
//block 用于释放当前页面
@property (nonatomic, copy) void(^releaseCurrentPageBlock)();

//按钮(用户点击用以移除视频)
@property (nonatomic, strong) UIButton *removeMoviePlayerButton;


/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame MovieUrl:(NSString *)url;

- (void)plMoviePlayDidEnd;

@end
