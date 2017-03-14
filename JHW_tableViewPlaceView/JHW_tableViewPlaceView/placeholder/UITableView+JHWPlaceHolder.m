//
//  UITableView+JHWPlaceHolder.m
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "UITableView+JHWPlaceHolder.h"

@implementation UITableView (JHWPlaceHolder)
+(void)load{
    //仅执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodChangeMethodWithOriginalSelector:@selector(reloadData) byChangeSelector:@selector(NreloadData)];
    });
}
- (void)NreloadData{
    
    //非首次刷新检测是否为空，解决数据加载未完成显示占位图情况
    if (!self.firstReload) {
        [self checkEmpty];
    }
    self.firstReload = NO;
    [self NreloadData];
}
- (void)checkEmpty{
    BOOL isEmpty = YES;
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;//默认一组

    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前tableView组数
    }
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前组的行数
        if (rows) {//若行数存在，不为空
            isEmpty = NO;
        }
    }
    if (isEmpty) {//若为空，加载占位图
        //默认占位图
        if (!self.placeholderView) {
            [self loadDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    }else{
        self.placeholderView.hidden = YES;
    }
}
- (void)loadDefaultPlaceholderView{

    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    JHWPlaceHolderView *palceView = [[JHWPlaceHolderView alloc]initWithFrame:self.bounds];
    __weak typeof(self) weakSelf = self;
    [palceView setReloadClickBolck:^{
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
    self.placeholderView = palceView;
}

//获取关联
- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}
//添加关联
- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
