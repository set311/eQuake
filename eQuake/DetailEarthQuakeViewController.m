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
#import "DetailCell.h"

#define cellName @"DetailCell"

@interface DetailEarthQuakeViewController ()

@property (nonatomic, strong) NSArray* details;

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

    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    UINib * nib = [UINib nibWithNibName:cellName bundle: nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i =0; i < [self.mapView.annotations count]; i++) {
        if ([[self.mapView.annotations objectAtIndex:i] isKindOfClass:[MKPointAnnotation class]]) {
            [self.mapView removeAnnotation:[self.mapView.annotations objectAtIndex:i]];
        }
    }
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
    
    NSString * url = [self.earthQuake valueForKeyPath:@"properties.detail"];
    
    [self.delegate loadURL:url withCallback:^(NSArray * earthquakeDetails) {
        self.details = earthquakeDetails;
        [self.tableView reloadData];
    }];
    
    float magnitud = [[self.earthQuake valueForKeyPath:@"properties.mag"] floatValue];
    
    [self.magnitudeLabel setText: [[self.earthQuake valueForKeyPath:@"properties.mag"] description] ];
    
    [self.magnitudeIndicator setBackgroundColor: [self.delegate getColorForMagnitude: magnitud]];
    
    [self.magnitudeType setText:[self.earthQuake valueForKeyPath:@"properties.magType"]];
    
    [self.place setText:[self.earthQuake valueForKeyPath:@"properties.place"]];

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
    
    // Set the type of pin to® draw and the color
    pinView.annotationType = ZSPinAnnotationTypeStandard;
    pinView.annotationColor = [UIColor redColor];
    pinView.canShowCallout = YES;
    
    return pinView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    [cell setViewModel:self.details[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadData];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.details count];
}





@end
