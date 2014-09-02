//
//  CalendarViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 02/09/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

extern NSMutableArray *jsonArray;
#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController
@property(strong, nonatomic) NSString * pNumber;
-(NSString *)checkData: (NSString *) dataSelected;
@end
