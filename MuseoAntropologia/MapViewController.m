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




@implementation MapViewController
@synthesize mapView;

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
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [mapView setDelegate:self];
    
    MKCoordinateRegion region;
    region.center.latitude = 41.90418398082423;
    region.center.longitude = 12.516314122962171;
    region.span.longitudeDelta = 0.01;
    region.span.latitudeDelta =0.01;
    [mapView setRegion:region animated:YES];
    
    
    MapAnnotation *museoAnnotation = [[MapAnnotation alloc] init];
    museoAnnotation.coordinate=region.center;
    museoAnnotation.title=@"Museo di Antropologia";
    
    
    [mapView addAnnotation:museoAnnotation];
    
    }


-(MKAnnotationView *) mapView: (MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *MyPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    MyPin.pinColor = MKPinAnnotationColorRed;
    
    UIButton *advertButton= [ UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    [advertButton setImage:[[UIImage imageNamed:@"icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    
    
    [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
    MyPin.rightCalloutAccessoryView = advertButton;
    MyPin.draggable = NO;
    MyPin.highlighted = YES;
    MyPin.animatesDrop = TRUE;
    MyPin.canShowCallout = YES;
    return MyPin;
    
}

-(void) button:(id)sender {
    NSString *urlString = @"http://maps.apple.com/maps?daddr=41.90418398082423,12.516314122962171";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)interno
{
    [mapView setHidden: YES];
    [_esterno_btn setTintColor:[UIColor lightGrayColor]];
    [_interno_btn setTintColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]];
    
}

- (IBAction)esterno
{
    [mapView setHidden: NO];
    [_interno_btn setTintColor:[UIColor lightGrayColor]];
    [_esterno_btn setTintColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1]];
    
}
@end
