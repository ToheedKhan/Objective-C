//
//  NSError+BMWAdditions.h
//  BMWTask
//
//  Created by Toheed Khan on 26/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

#pragma mark - PG Monetize Error Domain

extern NSString *const BMWErrorDomain;

#pragma mark Error Messages
extern NSString *const BMWErrorNoAdsAvailableMsg;


#pragma mark - Error Codes

typedef NS_ENUM(NSUInteger, BMWErrorCode) {
    BMWErrorUnknown                                = -1,
    BMWErrorNoInternetConnection                   = 101,
    BMWErrorRequestTimeout                         = 102,
    BMWErrorInvalidResponse                        = 103,
};

@interface NSError (BMWAdditions)
+ (NSError *)bmwErrorForCode:(NSInteger)code;
@end
