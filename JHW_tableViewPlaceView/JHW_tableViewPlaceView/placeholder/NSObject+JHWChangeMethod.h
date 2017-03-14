//
//  NSObject+JHWChangeMethod.h
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (JHWChangeMethod)

+ (void)methodChangeMethodWithOriginalSelector:(SEL)originalSelector byChangeSelector:(SEL)changeSelector;

@end
