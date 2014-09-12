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
#import "TourVirtualeTableViewController.h"
#import "SWRevealViewController.h"
#import "MapViewController.h"

@implementation AppDelegate
{
    CLLocationManager *_locationManager;
    SWRevealViewController *revealViewController;
    BOOL isActive;
    //    NSUserDefaults *defaults;
    
    //region beacon crani
    CLBeaconRegion *region1; //Ceprano
    CLBeaconRegion *region2; //Saccopastore 1 e 2
    CLBeaconRegion *region3; //Maiella
    CLBeaconRegion *region4; //Guattari
    //CLBeaconRegion *region5;
    
}


@synthesize defaults;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    revealViewController = (SWRevealViewController *)self.window.rootViewController;
    // Change the background color of navigation bar
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    pageControl.frame = CGRectMake(0, 0, 320, 10);
    defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"locked1"] == nil) {
        [defaults setBool:YES forKey:@"locked1"]; //Ceprano
        [defaults setBool:YES forKey:@"locked2"]; //Saccopastore1
        [defaults setBool:YES forKey:@"locked3"]; //Saccopastore2
        [defaults setBool:YES forKey:@"locked4"]; //Guattarei
        [defaults setBool:YES forKey:@"locked5"]; //Ceprano
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
    //    locked5 = true;eee
    //test
    
    
    
    NSLog(@"applicationDidFinishLaunching");
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    /*
     uuid sapienzaaps 14A184BD-26B6-4D40-B14E-DEF5EB92B3DA
     */
    
    //Beacon 1.1 - CEPRANO
    //qui si definisce la regione dei beacon, questa è quella del beacon 1.
    region1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 1 identifier: Ceprano ];
    region1.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region1];
    [_locationManager startRangingBeaconsInRegion: region1];
    
    //Beacon 1.2 - SACCOPASTORE 1 e 2
//    CLBeaconRegion *region2;
    //qui si definisce la regione dei beacon, questa è quella del beacon 2.
    region2 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 2 identifier: Saccop1];
    region2.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region2];
    [_locationManager startRangingBeaconsInRegion: region2];
    
    //Beacon 1.3 - MAIELLA
//    CLBeaconRegion *region3;
    //qui si definisce la regione dei beacon, questa è quella del beacon 3.
    region3 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 3 identifier: Maiella];
    region3.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region3];
    [_locationManager startRangingBeaconsInRegion: region3];
    
    
    //Beacon 1.4 - GUATTARI
//    CLBeaconRegion *region4;
    //qui si definisce la regione dei beacon, questa è quella del beacon 4.
    region4 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 4 	identifier: Guattari];
    region4.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region4];
    [_locationManager startRangingBeaconsInRegion: region4];
    
    //Beacon 1.5 - EX -MAIELLA
//    CLBeaconRegion *region5;
    //qui si definisce la regione dei beacon, questa è quella del beacon 5.
//    region5 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 5 	identifier: Maiella];
//    region5.notifyEntryStateOnDisplay = YES;
//    [_locationManager startMonitoringForRegion:region5];
//    [_locationManager startRangingBeaconsInRegion: region5];
    
    //Beacon 1.6 - BEACON ENTRATA MUSEO
    CLBeaconRegion *region6;
    //qui si definisce la regione dei beacon, questa è quella del beacon 6.
    region6 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 6 	identifier:Entrata ];
    region6.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region6];
    
    //Beacon 1.7 - BEACON ENTRATA MUSEO
//    CLBeaconRegion *region7;
//    //qui si definisce la regione dei beacon, questa è quella del beacon 7.
//    region7 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"14A184BD-26B6-4D40-B14E-DEF5EB92B3DA"] major: 1 minor: 7 	identifier:Piano ];
//    region7.notifyEntryStateOnDisplay = YES;
//    [_locationManager startMonitoringForRegion:region7];
    
    
    //    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    //    if(localNotification)
    application.applicationIconBadgeNumber = 0;
    isActive = YES;
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
    isActive = NO;
    
    NSLog(@"riavvio region monitoring");
    //riavvio monitoring region per bug notifiche
    [_locationManager stopMonitoringForRegion:region1];//Ceprano
    [_locationManager stopMonitoringForRegion:region2];//Saccopastore 1 e 2
    [_locationManager stopMonitoringForRegion:region3];//Mailla
    [_locationManager stopMonitoringForRegion:region4];//Guattari
    //[_locationManager stopMonitoringForRegion:region5];
    
    [_locationManager startMonitoringForRegion:region1];
    [_locationManager startMonitoringForRegion:region2];
    [_locationManager startMonitoringForRegion:region3];
    [_locationManager startMonitoringForRegion:region4];
    //[_locationManager startMonitoringForRegion:region5];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    isActive = YES;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    isActive = YES;
    
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    isActive = NO;
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
//    //stop monitor se tutti crani sbloccati
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"locked1"]&&
//       [[NSUserDefaults standardUserDefaults] boolForKey:@"locked2"]&&
//       [[NSUserDefaults standardUserDefaults] boolForKey:@"locked3"]&&
//       [[NSUserDefaults standardUserDefaults] boolForKey:@"locked4"]&&
//       [[NSUserDefaults standardUserDefaults] boolForKey:@"locked5"])
//    {
//        
//        [manager stopMonitoringForRegion:region];
//        
//    }
    //quando sei dentro l'area di un beacon, quello definito dalla region
    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        
        
        //local notification
        //inserire if sullo stato del cranio da sbloccare (se è già sbloccato non entra)
        
        if(!isActive){ //APP non attiva
            
            
            //SBLOCCO CEPRANO
            if([region.identifier isEqualToString:Ceprano] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked1"])
            {
                
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif) {
                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
                }
                
                [defaults setBool:NO forKey:@"locked1"];
                [defaults synchronize];
                
                //[manager stopMonitoringForRegion:region];
                
                
            }
            //SBLOCCO SACCOPASTORE 1 E SACCOPASTORE 2
            if([region.identifier isEqualToString:Saccop1] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked2"]  && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked3"])
            {
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif) {
                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
                }
                
                [defaults setBool:NO forKey:@"locked2"];
                [defaults setBool:NO forKey:@"locked3"];
                [defaults synchronize];
                
                //[manager stopMonitoringForRegion:region];
                
            }
//            //SBLOCCO SACCO2
//            if([region.identifier isEqualToString:Saccop2] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked3"])
//            {
//                
//                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//                if (localNotif) {
//                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
//                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
//                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
//                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
//                }
//                
//                [defaults setBool:NO forKey:@"locked3"];
//                [defaults synchronize];
//                
//                //[manager stopMonitoringForRegion:region];
//                
//            }
            //SBLOCCO GUATTARI
            if([region.identifier isEqualToString:Guattari] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked4"])
            {
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif) {
                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
                }
                [defaults setBool:NO forKey:@"locked4"];
                [defaults synchronize];
                
                //[manager stopMonitoringForRegion:region];
                
            }
            
            
            //SBLOCCO MAIELLA
            if([region.identifier isEqualToString:Maiella] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked5"])
            {
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif) {
                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Hai sbloccato il cranio di %@!",region.identifier];
                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
                }
                
                [defaults setBool:NO forKey:@"locked5"];
                [defaults synchronize];
                
                //[manager stopMonitoringForRegion:region];
                
            }
        }
        //NOTIFICA BEACON ALL'ENTRATA -> 1 AL MESE
        if([region.identifier isEqualToString:Entrata]){
            NSDate *fromDateTime = (NSDate *)[defaults objectForKey:@"dataUltimaNotificaEntrata"];
            
            NSInteger day;
            
            if(fromDateTime != nil){
                
                NSLog(@"fromdate: %@", fromDateTime);
                
                NSDate *toDateTime = [NSDate date];
                
                //diff
                NSDate *fromDate;
                NSDate *toDate;
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                
                [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                             interval:NULL forDate:fromDateTime];
                [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                             interval:NULL forDate:toDateTime];
                
                NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                                           fromDate:fromDate toDate:toDate options:0];
                
                
                day = [difference day];
            }else{
                //fromdate mai impostato -> forzo la prima notifica con valore day > 30
                NSLog(@"forzo fromdate");
                day = 31;
            }
            
            //NSLog(@"giorni diff :%d", day);
            
            if(day  > 30){
                //test alert in background
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sei arrivato davanti al museo di antropologia della Sapienza"  message:@"Entra a visitare il  museo!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif) {
                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Sei arrivato davanti al museo di antropologia della Sapienza!"];
                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
                    
                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
                }
                
                //aggiorno data ultima notifica
                NSDate *now = [NSDate date];
                [defaults setObject:now forKey:@"dataUltimaNotificaEntrata"];
                [defaults synchronize];
            }else{
                NSLog(@"meno di 30 gg dall'ultima notifica entrata");
            }
            
            
        }
        
        
        //NOTIFICA BEACON AL PRIMO PIANO -> 1 AL MESE
//        if([region.identifier isEqualToString:Piano]){
//            NSDate *fromDateTime = (NSDate *)[defaults objectForKey:@"dataUltimaNotificaPiano"];
//            
//            NSInteger day;
//            
//            if(fromDateTime != nil){
//                
//                NSLog(@"fromdate: %@", fromDateTime);
//                
//                NSDate *toDateTime = [NSDate date];
//                
//                //diff
//                NSDate *fromDate;
//                NSDate *toDate;
//                
//                NSCalendar *calendar = [NSCalendar currentCalendar];
//                
//                [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
//                             interval:NULL forDate:fromDateTime];
//                [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
//                             interval:NULL forDate:toDateTime];
//                
//                NSDateComponents *difference = [calendar components:NSDayCalendarUnit
//                                                           fromDate:fromDate toDate:toDate options:0];
//                
//                
//                day = [difference day];
//            }else{
//                //fromdate mai impostato -> forzo la prima notifica con valore day > 30
//                NSLog(@"forzo fromdate");
//                day = 31;
//            }
//            
//            if(day  > 30){
//                //test alert in background
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sei arrivato al primo piano del museo di antropologia della Sapienza"  message:@"Entra a visitare il  museo!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                [alert show];
//                
//                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
//                if (localNotif) {
//                    localNotif.alertBody = [[NSString alloc] initWithFormat:@"Sei arrivato al primo piano del museo di antropologia della Sapienza!"];
//                    localNotif.alertAction = NSLocalizedString(@"Ok", nil);
//                    localNotif.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber]+1;
//                    
//                    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotif];
//                }
//                
//                //aggiorno data ultima notifica
//                NSDate *now = [NSDate date];
//                [defaults setObject:now forKey:@"dataUltimaNotificaPiano"];
//                [defaults synchronize];
//            }else{
//                NSLog(@"meno di 30 gg dall'ultima notifica piano");
//            }
//            
//            
//        }
        
        
        
    }
    else if(state == CLRegionStateOutside) {
        NSLog(@"locationManager didDetermineState OUTSIDE for %@", region.identifier);
        
        //test allert in background
        
        
    }
    else {
        NSLog(@"locationManager didDetermineState OTHER for %@", region.identifier);
    }
}


//- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
//{
//    NSDate *fromDate;
//    NSDate *toDate;
//
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//
//    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
//                 interval:NULL forDate:fromDateTime];
//    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
//                 interval:NULL forDate:toDateTime];
//
//    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
//                                               fromDate:fromDate toDate:toDate options:0];
//
//    return [difference day];
//}


- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    // I commented out the line below because otherwise you see this every second in the logs
    
    
    //stop monitor se tutti crani sbloccati
        
    
    
    for (id beacon in beacons) {
        
        NSLog(@"beacon n:%d",[[beacon minor] intValue]);
        
        NSInteger minorBeacon = [[beacon minor] intValue];
        //calcolo tempo ultima notifica foreground
        NSDate *fromLastNotifica = (NSDate *)[defaults objectForKey:@"ultimaNotificaApp"];
        NSInteger secondiUtlimaNotifica;
        
        
        if(fromLastNotifica != nil){
            
            NSLog(@"fromLastNot: %@", fromLastNotifica);
            
            NSDate *toDateTime = [NSDate date];
            
            NSLog(@"todata: %@", toDateTime);
            //diff
            NSDate *fromDate;
            NSDate *toDate;
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            [calendar rangeOfUnit:NSSecondCalendarUnit startDate:&fromDate
                         interval:NULL forDate:fromLastNotifica];
            [calendar rangeOfUnit:NSSecondCalendarUnit startDate:&toDate
                         interval:NULL forDate:toDateTime];
            
            NSDateComponents *difference = [calendar components:NSSecondCalendarUnit
                                                       fromDate:fromDate toDate:toDate options:0];
            
            secondiUtlimaNotifica = [difference second];
            
            NSLog(@"secondi ultima notifica : %d",secondiUtlimaNotifica);
        }else{
            //fromdate mai impostato -> forzo la prima notifica con valore secondiUtlimaNotifica > 30
            NSLog(@"forzo fromLastNot");
            secondiUtlimaNotifica = 31;
        }
        
        
        //SBLOCCO CEPRANO
        if((minorBeacon == 1) && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked1"])
        {
            if(isActive){
                if(secondiUtlimaNotifica > 30){
                    //test alert in background
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Ceprano"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    
                    [defaults setObject:[NSDate date] forKey:@"ultimaNotificaApp"];
                    [defaults synchronize];
                    
                    [defaults setBool:NO forKey:@"locked1"];
                    [defaults synchronize];
                    
                    //[manager stopRangingBeaconsInRegion:region];
                }
            }
        }
        
        
        
        //SBLOCCO SACCO1
        if((minorBeacon == 2) && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked2"] && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked3"])
        {
            if(isActive){
                if(secondiUtlimaNotifica > 30){
                    //test alert in background
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Saccopastore 1 e Saccopastore 2"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    
                    [defaults setObject:[NSDate date] forKey:@"ultimaNotificaApp"];
                    [defaults synchronize];
                    
                    [defaults setBool:NO forKey:@"locked2"];
                    [defaults setBool:NO forKey:@"locked3"];
                    [defaults synchronize];
                    
                    //[manager stopRangingBeaconsInRegion:region];
                }
                
            }
        }
//        //SBLOCCO SACCO2
//        if((minorBeacon == 3) && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked3"])
//        {
//            if(isActive){
//                if(secondiUtlimaNotifica > 30){
//                    //test alert in background
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Saccopastore 2"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                    [alert show];
//                    
//                    [defaults setObject:[NSDate date] forKey:@"ultimaNotificaApp"];
//                    [defaults synchronize];
//                    
//                    [defaults setBool:NO forKey:@"locked3"];
//                    [defaults synchronize];
//                    
//                    //[manager stopRangingBeaconsInRegion:region];
//                }
//            }
//        }
        //SBLOCCO GUATTARI
        if( (minorBeacon == 4) && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked4"])
        {
            if(isActive){
                if(secondiUtlimaNotifica > 30){
                    //test alert in background
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Guattari"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    
                    [defaults setObject:[NSDate date] forKey:@"ultimaNotificaApp"];
                    [defaults synchronize];
                    
                    
                    [defaults setBool:NO forKey:@"locked4"];
                    [defaults synchronize];
                    
                    //[manager stopRangingBeaconsInRegion:region];
                }
            }
        }
        
        
        //SBLOCCO MAIELLA
        
        if((minorBeacon == 3) && [[NSUserDefaults standardUserDefaults] boolForKey:@"locked5"])
        {
            if(isActive){
                if(secondiUtlimaNotifica > 30){
                    //test alert in background
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hai sbloccato il cranio di Maiella"  message:@"Guardalo subito nella sezione Augmented Tour!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                    
                    [defaults setObject:[NSDate date] forKey:@"ultimaNotificaApp"];
                    [defaults synchronize];
                    
                    [defaults setBool:NO forKey:@"locked5"];
                    [defaults synchronize];
                    
                    
                    //[manager stopRangingBeaconsInRegion:region];
                }
            }
        }
        
    }
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;//badge notifiche beacon trovati
    
    //quando riceve notifica apre view sezione crani
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    MapViewController *dest = (MapViewController *) [storyBoard instantiateViewControllerWithIdentifier:@"TourViewController"];
    
    [self.nav popToRootViewControllerAnimated:NO];
    
    [self.nav setViewControllers: @[dest]  animated: NO ];
    
    
    
}

@end
