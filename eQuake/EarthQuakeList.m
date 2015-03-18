//
//  EarthQuakeList.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "EarthQuakeList.h"
#import "EarthQuakeCellTableViewCell.h"
#import "ColorMagnitudServices.h"

#define cellName @"EarthQuakeCellTableViewCell"

@interface EarthQuakeList ()

@property(nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation EarthQuakeList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    self.magnitudColorServices = [ColorMagnitudServices new];
    
    self.title = @"Earth Quakes";
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    UINib * nib = [UINib nibWithNibName:cellName bundle: nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellName];
    
    [self reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EarthQuakeCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    id earthQuakeModel = self.earthQuakes[(NSUInteger) indexPath.row];
    [cell setEarthQuake:earthQuakeModel];
    float magnitud = [[earthQuakeModel valueForKeyPath:@"properties.mag"] floatValue];
    [cell setMagnitudColor: [self.magnitudColorServices getColorForMagnitude: magnitud]];
    
    [cell reloadData];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.earthQuakes count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cmdEarthQuakeSelected:indexPath.row];
}

-(void)cmdEarthQuakeSelected:(NSInteger)index
{
    [self.navigationController pushViewController:[self.delegate nextViewControllerWithModel:self.earthQuakes[index]] animated:YES];
}

- (void)reloadData
{
    [self.delegate loadEarthquakesInformationWithCallback:^(NSArray * earthquakes) {
        self.earthQuakes = earthquakes;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

@end
