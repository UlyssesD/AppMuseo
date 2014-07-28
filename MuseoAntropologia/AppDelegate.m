//
//  AppDelegate.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 25/06/14.
//  
//

#import "AppDelegate.h"
#import "Constants.h"
#import "CraniViewController.h"

@implementation AppDelegate
{
    CLLocationManager *_locationManager;
//    NSUserDefaults *defaults;
    
}


@synthesize defaults;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    // Change the background color of navigation bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"locked1"] == nil) {
        [defaults setBool:YES forKey:@"locked1"];
        [defaults setBool:YES forKey:@"locked2"];
        [defaults setBool:YES forKey:@"locked3"];
        [defaults setBool:YES forKey:@"locked4"];
        [defaults setBool:YES forKey:@"locked5"];
        [defaults synchronize];
    }
    
    // Change the font style of the navigation bar
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"STHeitiTC-Light" size:21.0], NSFontAttributeName, nil]];
    
//    locked1 = true;
//    locked2 = true;
//    locked3 = true;
//    locked4 = true;
//    locked5 = true;
    
    
    NSLog(@"applicationDidFinishLaunching");
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLBeaconRegion *region;
    //qui si definisce la regione dei beacon, questa è quella del beacon 1.
    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"] major: 1 minor: 9 identifier: Ceprano];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    
//    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    if(localNotification)
        application.applicationIconBadgeNumber = 0;

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    //quando sei dentro l'area di un beacon, quello definito dalla region
    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        
        
        //local notification
        //inserire if sullo stato del cranio da sbloccare (se è già sbloccato non entra)
        //SBLOCCO CEPRANO
        if([region.identifier isEqualToString:Ceprano] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked1"])
        {
            //test alert in background
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Ceprano"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            
            UILocalNotification *localNotif = [[UILocalNotification alloc] init];
            if (localNotif) {
//                localNotif.alertBody = [NSString stringWithFormat:
//                                    NSLocalizedString(@"Hai sbloccato il cranio di %1$@! Corri a vederlo!",nil),region.identifier];
                localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
                localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
            }
            [defaults setBool:NO forKey:@"locked1"];
            [defaults synchronize];
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

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;
    
}

@end
