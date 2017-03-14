//
//  UITableView+JHWPlaceHolder.h
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JHWPlaceHolder)

@property (nonatomic, assign)BOOL firstReload;
@property (nonatomic, strong)UIView *placeholderView;

@property (nonatomic,   copy) void(^reloadBlock)(void);
@end
