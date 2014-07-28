//
//  BDAppDelegate.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDAppDelegate.h"


@implementation BDAppDelegate
{
    CLLocationManager *_locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"applicationDidFinishLaunching");

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLBeaconRegion *region;
    //qui si definisce la regione dei beacon, questa è quella del beacon 1.
    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"] major: 1 minor: 9 identifier: @"region1"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    //[_locationManager stopRangingBeaconsInRegion:region];
    //[_locationManager startRangingBeaconsInRegion:region];
    
    
    return YES;
}


- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    //quando sei dentro l'area di un beacon, quello definito dalla region
    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        
        //test allert in background
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Baecon region" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
        
        //local notification
        //inserire if sullo stato del cranio da sbloccare (se è già sbloccato non entra)
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            if (localNotif) {
                localNotif.alertBody = [NSString stringWithFormat:
                                        NSLocalizedString(@"TEST", nil)];
                localNotif.alertAction = NSLocalizedString(@"ok", nil);
                [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
            }
            //inserire comando sblocco beacon
        
    }
    else if(state == CLRegionStateOutside) {
        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
        
        //test allert in background
        
        
    }
    else {
        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // I commented out the line below because otherwise you see this every second in the logs
    // NSLog(@"locationManager didRangeBeacons");
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
}
@end

