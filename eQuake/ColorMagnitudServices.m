//
//  ColorMagnitudServices.m
//  earthQuake
//
//  Created by Jesus Cagide on 2/25/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "ColorMagnitudServices.h"
#import "UIView+ColorOfPoint.h"

@interface ColorMagnitudServices()

@property(nonatomic, strong) UIView *baseView;

@end


@implementation ColorMagnitudServices


- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(0, 0, 11, 11);
        self.baseView = [[UIView alloc] initWithFrame:frame];
        
        UIColor * color1 = [UIColor colorWithRed:42/255.0f green:256/255.0f blue:0/255.0f alpha:1.0f];
        UIColor * color2 = [UIColor colorWithRed:42/255.0f green:105/255.0f blue:0/255.0f alpha:1.0f];
        
        UIColor * color3 = [UIColor colorWithRed:237/255.0f green:21/255.0f blue:14/255.0f alpha:1.0f];
        UIColor * color4 = [UIColor colorWithRed:96/255.0f green:1/255.0f blue:0/255.0f alpha:1.0f];
        
        NSArray *colors = @[
                            (id) color1.CGColor,
                            (id) color2.CGColor,
                            (id) color3.CGColor,
                            (id) color4.CGColor,
                            ];
        NSArray *locations = @[
                               @0.0F,
                               @0.1F,
                               @0.9F,
                               @1.0F
                               ];
        
        CAGradientLayer *headerLayer = [CAGradientLayer layer];
        headerLayer.colors = colors;
        headerLayer.locations = locations;
        
        headerLayer.frame = self.baseView.bounds;
        [self.baseView.layer insertSublayer:headerLayer atIndex:0];
    }
    
    return self;
}

-(UIColor *) getColorForMagnitude: (float) magnitude
{
    CGFloat cgFloat = (CGFloat) magnitude;
    UIColor *colorOfPoint = [self.baseView colorOfPoint:CGPointMake(cgFloat, cgFloat)];
    return colorOfPoint;
}


@end
