//
//  EarthQuakeBusinessController.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "EarthQuakeBusinessController.h"
#import "GeoJSONSerialization.h"

#define url @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

@interface EarthQuakeBusinessController()

@property(nonatomic, strong) NSDictionary *geoJSON;
@property(nonatomic, strong) NSArray *shapes;

@property(nonatomic, strong) dispatch_queue_t queue;
@property(nonatomic, copy) NSString *tempPath;

@end

@implementation EarthQuakeBusinessController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("Earthquakes", DISPATCH_QUEUE_CONCURRENT);
        self.tempPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/all_hour.geojson"];
    }
    return self;
}

- (void)loadEarthquakesInformationWithCallback:(void (^)(NSArray *))earthQuakesInformation {
    
    dispatch_barrier_async(self.queue, ^{
        NSError * error = nil;
        BOOL saveCache = YES;
        NSData * data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:url] options:nil error:&error];
        
        if(!data) {
            data = [NSData dataWithContentsOfFile:self.tempPath];
            saveCache = NO;
        }
        if(data) {
            NSError * interpretationError = nil;
            self.geoJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&interpretationError];
            
            if(!interpretationError) {
                NSError * geoJsonExtractionError = nil;
                self.shapes = [GeoJSONSerialization shapesFromGeoJSONFeatureCollection:self.geoJSON error:&geoJsonExtractionError];
                
                if(!geoJsonExtractionError) {
                    if(saveCache)
                        [data writeToFile:self.tempPath atomically:YES];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        earthQuakesInformation(self.geoJSON[@"features"]);
                    });
                }
            }
        }
    });
}



@end
