//
//  NSDate+BMWExtension.m
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "NSDate+BMWExtension.h"

@implementation NSDate (BMWExtension)

+ (NSDate *)dateFromISODateTimeString:(NSString *) isoDateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    return [dateFormatter dateFromString:isoDateString];
}

//+ (NSString *)dateStringFromDateInSystemTimeZone:(NSDate *)date {
//    
//    NSDateFormatter *tempDateFormatter = [[NSDateFormatter alloc] init];
//    [tempDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [tempDateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
//    return [tempDateFormatter stringFromDate:date];
//}
//
//+ (NSString *)dateStringFromDateInLocalTimeZone:(NSDate *)date {
//    
//    NSDateFormatter *tempDateFormatter = [[NSDateFormatter alloc] init];
//    [tempDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [tempDateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//    return [tempDateFormatter stringFromDate:date];
//}


+ (NSString *)dateStringFromDateInDefaultTimeZone:(NSDate *)date {
    
    NSDateFormatter *tempDateFormatter = [[NSDateFormatter alloc] init];
    [tempDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss z"];    
    [tempDateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    return [tempDateFormatter stringFromDate:date];
}

//+ (NSString *)dateStringFromDate:(NSDate *)date
//                withTimeZone:(NSTimeZone *)timeZone {
//    
//    NSDateFormatter *tempDateFormatter = [[NSDateFormatter alloc] init];
//    [tempDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    [tempDateFormatter setTimeZone:timeZone];
//    return [tempDateFormatter stringFromDate:date];
//}

@end
