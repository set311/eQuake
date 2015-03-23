//
//  EarthQuakeBusinessController.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "EarthQuakeBusinessController.h"
#import "GeoJSONSerialization.h"
#import "MKPointAnnotation+CustomColor.h"
#import "ColorMagnitudServices.h"
#import "DetailEarthQuakeViewController.h"


#define url @"http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"

@interface EarthQuakeBusinessController()

@property(nonatomic, strong) NSDictionary *geoJSON;
@property(nonatomic, strong) NSArray *shapes;

@property(nonatomic, strong) dispatch_queue_t queue;
@property(nonatomic, copy) NSString *tempPath;

@property(nonatomic, strong) ColorMagnitudServices *magnitudColor;

@property(nonatomic, strong) DetailEarthQuakeViewController *detailView;

@property(nonatomic, strong) NSDateFormatter *dayFormat;
@property(nonatomic, strong) NSDateFormatter *timeFormat;

@end

@implementation EarthQuakeBusinessController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.queue = dispatch_queue_create("Earthquakes", DISPATCH_QUEUE_CONCURRENT);
        self.tempPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/all_hour.geojson"];
        
        self.magnitudColor = [ColorMagnitudServices new];
        self.detailView = [DetailEarthQuakeViewController new];
        [self.detailView setDelegate:self];
        
        self.dayFormat = [[NSDateFormatter alloc] init];
        [self.dayFormat setDateFormat:@"MM/dd/yyyy"];
        
        self.timeFormat = [[NSDateFormatter alloc] init];
        [self.timeFormat setDateFormat:@"HH:mm"];

        
    }
    return self;
}

- (void)loadURL:(NSString*)theURL withCallback:(void (^)(NSArray*))earthQuakesDetail {

    dispatch_barrier_async(self.queue, ^{
        NSError * error = nil;
        NSData * data = [NSData dataWithContentsOfURL:[[NSURL alloc] initWithString:theURL] options:nil error:&error];
    
        if(data) {
            NSError * interpretationError = nil;
            self.geoJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&interpretationError];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                double timeValue = [self.geoJSON[@"properties"][@"time"] doubleValue];
                               
                NSDate * completeDate = [NSDate dateWithTimeIntervalSince1970: (timeValue / 1000)];
                
                NSString* date =[self.dayFormat stringFromDate:completeDate];
                
                NSString* time =[self.timeFormat stringFromDate:completeDate];
;
                NSArray* details = @[
                                     @{@"key":@"Time",
                                       @"value":time},
                                     @{@"key":@"Date",
                                       @"value":date},
                                     @{@"key":@"Place",
                                       @"value":self.geoJSON[@"properties"][@"place"]}
                                     ];
                
                    earthQuakesDetail(details);
                    });
                }
    });
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


- (void)getMapInformationForEarthquake:(id)earthquakeModel withCallback:(void (^)(id))shapeCallback {
    dispatch_barrier_async(self.queue, ^{
        NSUInteger indexOfObject = [self.geoJSON[@"features"] indexOfObject:earthquakeModel];
        MKPointAnnotation * shape = [self.shapes count] > indexOfObject ? self.shapes[indexOfObject] : nil;
        shape.customColor = [self.magnitudColor getColorForMagnitude: [self getMagnitudeFromModel:earthquakeModel]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            shapeCallback(shape);
        });
    });
}

- (void) getMapInformationWithEarthquakesUsingCallback: (void (^)(id))shapeCallback {
    for(id earthquakeModel in self.geoJSON[@"features"]) {
        [self getMapInformationForEarthquake: earthquakeModel withCallback:shapeCallback];
    }
}

- (float)getMagnitudeFromModel: (id) model{
    return [[model valueForKeyPath:@"properties.mag"] floatValue];
}


-(UIViewController*)nextViewControllerWithModel:(id) model
{
    [self.detailView setEarthQuake:model];

    
    return self.detailView;
}

-(UIColor *) getColorForMagnitude: (float) magnitude
{
    return  [self.magnitudColor getColorForMagnitude:magnitude];
}

@end
