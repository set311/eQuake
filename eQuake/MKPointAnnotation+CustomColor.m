//
// Created by Luis Alejandro Rangel Sánchez on 2/21/15.
// Copyright (c) 2015 Mobile Apps Company. All rights reserved.
//

#import <objc/runtime.h>
#import "MKPointAnnotation+CustomColor.h"


@implementation MKPointAnnotation (CustomColor)

NSString const *key = @"MKPointAnnotation.customColor";

- (void)setCustomColor:(UIColor *)test
{
    objc_setAssociatedObject(self, &key, test, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)customColor
{
    return objc_getAssociatedObject(self, &key);
}


@end