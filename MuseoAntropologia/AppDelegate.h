//
//  AppDelegate.h
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 25/06/14.
//  
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//bool locked1;
//bool locked2;
//bool locked3;
//bool locked4;
//bool locked5;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
//@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSUserDefaults *defaults;

@end
