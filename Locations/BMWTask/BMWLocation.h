//
//  BMWLocation.h
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

@interface BMWLocation : NSObject

@property (nonatomic, assign) NSUInteger locationID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) double     latitude;
@property (nonatomic, assign) double     longitude;
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSDate *   arrivalTime;


- (instancetype)initLocationWithID:(NSUInteger)locID
                              name:(NSString *)name_
                          latitude:(double)latitude_
                         longitude:(double)longitude_
                           address:(NSString *)address_
                    andArrivalTime:(NSDate *)arrivalTime_;

- (instancetype)initLocationWithDictionary:(NSDictionary *)locationDic;
@end
