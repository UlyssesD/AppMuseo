//
//  MapViewController.m
//  MuseoAntropologia
//
//  Created by Ulysses D. on 28/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"
#import "SWRevealViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.title = @"Come Raggiungerci";
    CGRect frame = CGRectMake(0, 0, 100, 44);
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
    
    
    MKCoordinateRegion region;
    region.center.latitude = 41.90418398082423;
    region.center.longitude = 12.516314122962171;
    region.span.longitudeDelta = 0.01;
    region.span.latitudeDelta =0.01;
    [_mapView setRegion:region animated:YES];
    
    
    MapAnnotation *museoAnnotation = [MapAnnotation alloc];
    museoAnnotation.coordinate=region.center;
    museoAnnotation.title=@"Museo di Antropologia";



    [self.mapView addAnnotation:museoAnnotation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)trovaPercorso:(id)sender {
    NSString *urlString = @"http://maps.apple.com/maps?daddr=41.90418398082423,12.516314122962171";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
@end
