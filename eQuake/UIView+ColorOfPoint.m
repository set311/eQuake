//
// Created by Luis Alejandro Rangel Sánchez on 2/21/15.
// Copyright (c) 2015 Mobile Apps Company. All rights reserved.
//

#import "UIView+ColorOfPoint.h"


@implementation UIView (ColorOfPoint)

// Ref: http://stackoverflow.com/questions/1160229/how-to-get-the-color-of-a-pixel-in-an-uiview
- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);

    CGContextTranslateCTM(context, -point.x, -point.y);

    [self.layer renderInContext:context];

    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

@end