//
//  BMWLocationManager.h
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

@interface BMWLocationManager : NSObject

+ (BMWLocationManager*)sharedInstance;

- (void)fetchNearByLocationsWithCompletionHandler:(void (^)(NSArray *locations, NSError *error))completionBlock;

@end
