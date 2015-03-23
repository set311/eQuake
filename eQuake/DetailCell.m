//
//  DetailCell.m
//  eQuake
//
//  Created by Jesus Cagide on 3/22/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import "DetailCell.h"



@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadData{
    self.key.text = self.viewModel[@"key"];
    self.value.text = self.viewModel[@"value"];
}

@end
