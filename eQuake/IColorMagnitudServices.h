//
//  IColorMagnitudServices.h
//  earthQuake
//
//  Created by Jesus Cagide on 2/25/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IColorMagnitudServices<NSObject>

-(UIColor *) getColorForMagnitude: (float) magnitude;

@end

