//
//  EarthQuakeCellTableViewCell.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarthQuakeCellTableViewCell : UITableViewCell


@property(nonatomic, weak) IBOutlet UILabel* location;
@property(nonatomic, weak) IBOutlet UILabel* state;
@property(nonatomic, weak) IBOutlet UILabel* magnitud;
@property(nonatomic, strong) UIColor* magnitudColor;
@property(nonatomic, strong) id earthQuake;


-(void)reloadData;

@end
