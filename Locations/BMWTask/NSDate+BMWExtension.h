//
//  NSDate+BMWExtension.h
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

@interface NSDate (BMWExtension)

+ (NSDate *)dateFromISODateTimeString:(NSString *) isoDateString;
//+ (NSString *)dateStringFromDateInSystemTimeZone:(NSDate *)date;
//+ (NSString *)dateStringFromDateInLocalTimeZone:(NSDate *)date;
+ (NSString *)dateStringFromDateInDefaultTimeZone:(NSDate *)date;
//+ (NSString *)dateStringFromDate:(NSDate *)date
//                    withTimeZone:(NSTimeZone *)timeZone;
@end
