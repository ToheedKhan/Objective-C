//
//  BMWGlobalConstants.h
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;
@import UIKit;

#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

#define IS_iOS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#pragma mark - Sever Constants

#pragma mark  Location API

extern NSString *const kBMWLocationID ;
extern NSString *const kBMWLocationName ;
extern NSString *const kBMWLocationLatitude;
extern NSString *const kBMWLocationLongitude;
extern NSString *const kBMWLocationAddress;
extern NSString *const kBMWLocationArrivalTime;

#pragma mark Enum constants

typedef NS_ENUM(NSUInteger, BMWLocationSortingOption) {
    BMWLocationSortingOptionName                 = 1,
    BMWLocationSortingOptionArrivalTime          = 2,
    BMWLocationSortingOptionDistance             = 3
};

#pragma mark - Storyboard Segue Identifier

extern NSString *const kBMWLocationDetailSegue;
