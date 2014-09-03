//
//  MapViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 28/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>{
    
    IBOutlet MKMapView *mapView;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *esterno_btn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *interno_btn;



- (IBAction)interno;

- (IBAction)esterno;

@end