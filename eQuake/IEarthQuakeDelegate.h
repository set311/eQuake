//
//  IEarthQuakeDelegate.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IEarthquakesDataSource <NSObject>

- (void)loadEarthquakesInformationWithCallback:(void (^)(NSArray *))earthQuakesInformation;

@end