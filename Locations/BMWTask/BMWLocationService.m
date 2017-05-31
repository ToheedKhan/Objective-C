//
//  BMWLocationService.m
//  BMWTask
//
//  Created by Toheed Khan on 27/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLocationService.h"
#import "BMWGlobalConstants.h"

@interface BMWLocationService ()

@property (strong, nonatomic, readwrite) CLLocation *        currentLocation;

@end

@implementation BMWLocationService

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 30; // Meters.
    }
    
    return self;
}

+ (BMWLocationService *)sharedInstance
{
    static BMWLocationService *sharedLocationControllerInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedLocationControllerInstance = [[self alloc] init];
    });
    
    return sharedLocationControllerInstance;
}

#pragma mark - 
- (void)startUpdatingLocation
{
    if(IS_iOS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
//        [self.locationManager requestAlwaysAuthorization];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
   
    DLog(@"Starting location updates...");

    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        
    } else if (status == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                        message:@"This app needs you to authorize locations services to work."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    } else
        DLog(@"Wrong location status");
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    DLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations
{
    CLLocation *location = [locations lastObject];
    DLog(@"Latitude %+.6f, Longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    self.currentLocation = location;
}

@end
