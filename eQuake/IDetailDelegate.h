//
//  IDetailDelegate.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDetailDelegate <NSObject>

- (void)getMapInformationForEarthquake:(id)earthquakeModel withCallback:(void (^)(id))shapeCallback;

@end