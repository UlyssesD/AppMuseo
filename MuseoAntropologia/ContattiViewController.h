//
//  ContattiViewController.h
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 10/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContattiViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
