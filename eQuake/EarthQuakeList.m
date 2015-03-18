//
//  EarthQuakeList.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "EarthQuakeList.h"
#import "EarthQuakeCellTableViewCell.h"

#define cellName @"EarthQuakeCellTableViewCell"

@interface EarthQuakeList ()

@end

@implementation EarthQuakeList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Earth Quakes";
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.earthQuakes = @[@"1", @"2", @"3"];
    
    UINib * nib = [UINib nibWithNibName:cellName bundle: nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellName];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.earthQuakes count];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self cmdEarthQuakeSelected];
}


-(void)cmdEarthQuakeSelected
{
    
}

- (void) reloadData
{
    [self.tableView reloadData];
}


@end
