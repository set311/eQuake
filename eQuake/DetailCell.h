//
//  DetailCell.h
//  eQuake
//
//  Created by Jesus Cagide on 3/22/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel* key;
@property(nonatomic,weak)IBOutlet UILabel* value;

@property(nonatomic, strong)id viewModel;

-(void)reloadData;

@end


