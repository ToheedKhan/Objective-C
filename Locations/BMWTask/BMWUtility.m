//
//  BMWUtility.m
//  BMWTask
//
//  Created by Toheed Khan on 26/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWUtility.h"

@implementation BMWUtility

+ (id)parseJSONData:(NSData *)responseData {
    //parse out the json data
    NSError* error = nil;
    return [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
}

@end
