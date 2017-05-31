//
//  BMWLocationService.h
//  BMWTask
//
//  Created by Toheed Khan on 27/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;
@import CoreLocation;

//@protocol BMWLocationControllerDelegate
//
//- (void)locationControllerDidUpdateLocation:(CLLocation *)location;
//
//@end

@interface BMWLocationService : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager * locationManager;
@property (strong, nonatomic, readonly) CLLocation *        currentLocation;

+ (BMWLocationService *)sharedInstance;

- (void)startUpdatingLocation;
@end


