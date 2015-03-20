//
//  DetailEarthQuakeViewController.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "DetailEarthQuakeViewController.h"
#import <MapKit/MapKit.h>
#import "ZSPinAnnotation.h"
#import "MKPointAnnotation+CustomColor.h"

@interface DetailEarthQuakeViewController ()

@end

@implementation DetailEarthQuakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.magnitudeIndicator.layer setCornerRadius:30];
    [self.magnitudeIndicator.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.magnitudeIndicator.layer setShadowOpacity:0.7];
    [self.magnitudeIndicator.layer setShadowRadius:3.0];
    [self.magnitudeIndicator.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
        [self.delegate getMapInformationForEarthquake: self.earthQuake withCallback: ^(MKShape * shape) {
        if ([shape isKindOfClass:[MKPointAnnotation class]]) {
            
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta = 1;
            span.longitudeDelta = 1;
            region.span = span;
            region.center = shape.coordinate;
            
            [self.mapView addAnnotation:shape];
            [self.mapView setRegion:region animated:TRUE];
            [self.mapView regionThatFits:region];
            
        } else if ([shape conformsToProtocol:@protocol(MKOverlay)]) {
            [self.mapView addOverlay:(id <MKOverlay>) shape];
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Don't mess with user location
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *defaultPinID = @"StandardIdentifier";
    
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeStandard;
    pinView.annotationColor = [annotation isKindOfClass:[MKPointAnnotation class]] ? [((MKPointAnnotation*)annotation) customColor] : [UIColor redColor];
    pinView.canShowCallout = YES;
    
    return pinView;
}


@end
