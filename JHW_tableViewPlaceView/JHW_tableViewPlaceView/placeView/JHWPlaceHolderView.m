//
//  JHWPlaceHolderView.m
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "JHWPlaceHolderView.h"

@interface JHWPlaceHolderView(){

    UIButton *_reloadButton;
}

@end
@implementation JHWPlaceHolderView

//-(instancetype)initWithFrame:(CGRect)frame{
//
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self creatUI];
//    }
//    return self;
//}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self creatUI];
}
- (void)creatUI{
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reloadButton.frame = CGRectMake(0, 0, 150, 150);
        _reloadButton.center = self.center;
        _reloadButton.layer.cornerRadius = 75.0;
        [_reloadButton setBackgroundImage:[UIImage imageNamed:@"sure_placeholder_error"] forState:UIControlStateNormal];
        [_reloadButton setTitle:@"暂无数据，点击重新加载!" forState:UIControlStateNormal];
        [_reloadButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(200, -50, 0, -50)];
        [[_reloadButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            [self reloadClick];
        }];
        CGRect rect = _reloadButton.frame;
        rect.origin.y -= 50;
        _reloadButton.frame = rect;
    }
    [self addSubview:_reloadButton];
}
- (void)reloadClick{
    if (self.ReloadClickBolck) {
        self.ReloadClickBolck();
    }
}

@end




















