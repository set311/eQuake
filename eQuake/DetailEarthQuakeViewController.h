//
//  DetailEarthQuakeViewController.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IDetailDelegate.h"

@interface DetailEarthQuakeViewController : UIViewController<MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)IBOutlet MKMapView * mapView;
@property(nonatomic, weak)IBOutlet UIView * magnitudeIndicator;
@property(nonatomic, weak)IBOutlet UILabel* magnitudeType;
@property(nonatomic, weak)IBOutlet UILabel* magnitudeLabel;
@property(nonatomic, weak)IBOutlet UILabel* place;

@property(nonatomic, weak)IBOutlet UITableView* tableView;

@property(nonatomic, weak)id<IDetailDelegate> delegate;
@property(nonatomic, strong) id earthQuake;

@end
