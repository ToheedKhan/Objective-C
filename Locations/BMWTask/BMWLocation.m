//
//  BMWLocation.m
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLocation.h"
#import "BMWGlobalConstants.h"
#import "NSDate+BMWExtension.h"

@implementation BMWLocation

- (instancetype)initLocationWithID:(NSUInteger)locID
                              name:(NSString *)name_
                          latitude:(double)latitude_
                          longitude:(double)longitude_
                           address:(NSString *)address_
                    andArrivalTime:(NSDate *)arrivalTime_ {
    
    self = [super init];
    
    if (self) {
        _locationID = locID;
        _name = name_;
        _latitude = latitude_;
        _longitude = longitude_;
        _address = address_;
        _arrivalTime = arrivalTime_;
    }
    return self;
}

- (instancetype)initLocationWithDictionary:(NSDictionary *)locationDic {
    
    self = [super init];
    
    if (self) {
        _locationID = [locationDic[kBMWLocationID] integerValue];
        _name = locationDic [kBMWLocationName];
        _latitude = [locationDic[kBMWLocationLatitude] doubleValue];
        _longitude = [locationDic[kBMWLocationLongitude] doubleValue];
        _address = locationDic[kBMWLocationAddress];
        _arrivalTime = [NSDate dateFromISODateTimeString:locationDic[kBMWLocationArrivalTime]];
    }
    return self;

}

@end
