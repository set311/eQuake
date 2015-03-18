//
//  EarthQuakeList.h
//  eQuake
//
//  Created by Jesus Cagide on 3/17/15.
//  Copyright (c) 2015 cagide. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EarthQuakeList : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, assign)IBOutlet UITableView* tableView;
@property (nonatomic, strong) NSArray * earthQuakes;

- (void) reloadData;

@end
