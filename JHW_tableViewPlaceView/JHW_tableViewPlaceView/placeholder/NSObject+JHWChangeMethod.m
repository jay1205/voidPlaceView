//
//  NSObject+JHWChangeMethod.m
//  JHW_tableViewPlaceView
//
//  Created by JHW on 17/3/14.
//  Copyright © 2017年 JHW. All rights reserved.
//

#import "NSObject+JHWChangeMethod.h"


@implementation NSObject (JHWChangeMethod)

+ (void)methodChangeMethodWithOriginalSelector:(SEL)originalSelector byChangeSelector:(SEL)changeSelector{

    Class class = [self class];
    //获得实例方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method changeMethod = class_getInstanceMethod(class, changeSelector);
    //动态添加实例方法 当前类中如果有返回NO ，如果没有返回YES
    BOOL didAddMethod = class_addMethod(class, changeSelector, method_getImplementation(changeMethod), method_getTypeEncoding(changeMethod));
    if (didAddMethod) {
        //当前类中没有此替换方法
        class_replaceMethod(class, changeSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        //当前类中有此替换方法
        method_exchangeImplementations(originalMethod, changeMethod);
    }
}
/** 第一种情况是要复写的方法(changeMethod)并没有在目标类中实现(notimplemented)，而是在其父类中实现了。第二种情况是这个方法已经存在于目标类中(does existin the class itself)。这两种情况要区别对待。 (译注: 这个地方有点要明确一下，它的目的是为了使用一个重写的方法替换掉原来的方法。但重写的方法可能是在父类中重写的，也可能是在子类中重写的。) 对于第一种情况，应当先在目标类增加一个新的实现方法(changeMethod)，然后将复写的方法替换为原先(的实现(original one)。 对于第二情况(在目标类重写的方法)。这时可以通过method_exchangeImplementations来完成交换 */

@end
