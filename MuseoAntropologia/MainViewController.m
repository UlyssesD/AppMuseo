//
//  MainViewController.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 25/06/14.
//  
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Museo \"Giuseppe Sergi\"";
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    AppDelegate *myAppDelegate =(AppDelegate *) [[UIApplication sharedApplication] delegate];
    myAppDelegate.nav = self.navigationController;
    
    
    NSLog(@"%@",self.navigationController);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
