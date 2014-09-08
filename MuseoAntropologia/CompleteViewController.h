//
//  CompleteViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 25/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteViewController : UIViewController
@property (strong, nonatomic) NSString* general;
@property (strong, nonatomic) NSString* reservation;

@property (strong, nonatomic) IBOutlet UILabel *datiPersonali;
@property (strong, nonatomic) IBOutlet UILabel *datiVisita;
@property (strong, nonatomic) UINavigationController* controller;
@end
