//
//  EarthQuakeBusinessController.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IEarthQuakeDelegate.h"
#import "IDetailDelegate.h"

@interface EarthQuakeBusinessController : NSObject<IEarthquakesDataSource, IDetailDelegate>

- (float)getMagnitudeFromModel: (id) model;


@end
