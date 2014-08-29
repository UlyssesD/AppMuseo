//
//  AnotherTableViewController.h
//  ariProva
//
//  Created by Ulysses D. on 21/07/14.
//  Copyright (c) 2014 Ulysses D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnotherTableViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UISwitch *scFlag;
@property (weak, nonatomic) IBOutlet UITableViewCell *numberSelector;
@end
