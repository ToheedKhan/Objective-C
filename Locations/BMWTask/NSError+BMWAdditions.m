//
//  NSError+BMWAdditions.m
//  BMWTask
//
//  Created by Toheed Khan on 26/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "NSError+BMWAdditions.h"

#pragma mark - PG Monetize Error Domain

NSString *const BMWErrorDomain                        = @"com.BMW.app";

#pragma mark PG Monetize Error Msg

NSString *const BMWUnknownErrorMsg                             = @"Unable to process the request. Unknown error occurred from server. Please try again later";
NSString *const BMWNoInternetConnectionErrorMsg                = @"The Internet connection appears to be offline.";
NSString *const BMWErrorRequestTimeoutMsg                      = @"Request timeout";
NSString *const BMWErrorInvalidResponseMsg                     = @"Invalid response data.";


@implementation NSError (BMWAdditions)

+ (NSError *)bmwErrorForCode:(NSInteger)code {
    
    NSString *errorDesc = nil;
    NSInteger errorCode;
    
    switch (code) {
        case BMWErrorUnknown:
            errorCode = BMWErrorUnknown;
            errorDesc = BMWUnknownErrorMsg;
            break;
        case BMWErrorNoInternetConnection:
            errorCode = BMWErrorNoInternetConnection;
            errorDesc = BMWNoInternetConnectionErrorMsg;
            break;
        case BMWErrorRequestTimeout:
            errorCode = BMWErrorRequestTimeout;
            errorDesc = BMWErrorRequestTimeoutMsg;
            break;
        case BMWErrorInvalidResponse:
            errorCode = BMWErrorInvalidResponse;
            errorDesc = BMWErrorInvalidResponseMsg;
            break;
        
        default:
            errorCode = BMWErrorUnknown;
            errorDesc = BMWUnknownErrorMsg;
            break;
    }
    
    return [[NSError alloc] initWithDomain:BMWErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey: errorDesc}];
}

@end
