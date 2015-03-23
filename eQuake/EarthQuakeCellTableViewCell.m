//
//  EarthQuakeCellTableViewCell.m
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "EarthQuakeCellTableViewCell.h"

@interface EarthQuakeCellTableViewCell()

@property(nonatomic, weak) IBOutlet UIView*  magnitudIndicator;

@end

@implementation EarthQuakeCellTableViewCell

- (void)awakeFromNib {

}

-(void)reloadData
{
    [self.location setText:[self.earthQuake valueForKeyPath:@"properties.place"]];
    
    [self.magnitud setText:[NSString stringWithFormat: @"%0.2f",
                            [[self.earthQuake valueForKeyPath:@"properties.mag"] floatValue]]];
    
    [self.magnitudIndicator setBackgroundColor:self.magnitudColor];
    [self.magnitudIndicator.layer setCornerRadius:8];
}

@end
