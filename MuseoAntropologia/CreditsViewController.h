//
//  CreditsViewController.h
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 25/06/14.
//  
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CreditsViewController :  UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
