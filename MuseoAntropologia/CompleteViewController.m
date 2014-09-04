//
//  CompleteViewController.m
//  MuseoAntropologia
//
//  Created by Ulysses D. on 25/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "CompleteViewController.h"
#import "MapViewController.h"

@interface CompleteViewController ()

@end

@implementation CompleteViewController
@synthesize controller = _controller;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Prenotazione completata";
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MapViewController *dest = (MapViewController *) [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [_controller popToRootViewControllerAnimated:NO];
    
    [_controller setViewControllers: @[dest]  animated: NO ];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(IBAction) pop{
    
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MapViewController *dest = (MapViewController *) [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    
    [_controller popToRootViewControllerAnimated:NO];
    
    [_controller setViewControllers: @[dest]  animated: NO ];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
