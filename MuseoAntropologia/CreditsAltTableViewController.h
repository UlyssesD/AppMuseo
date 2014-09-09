//
//  CreditsAltTableViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 08/09/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CreditsAltTableViewController : UITableViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
