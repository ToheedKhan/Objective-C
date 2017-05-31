//
//  BMWLocationManager.m
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLocationManager.h"
#import "HttpClient.h"
#import "NSError+BMWAdditions.h"
#import "BMWUtility.h"
#import "BMWGlobalConstants.h"
#import "BMWLocation.h"

NSString * const kBMWLocationsAPI     = @"Locations";

@interface BMWLocationManager ()
@property (nonatomic, strong) HttpClient *httpClient;
@end

@implementation BMWLocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

+ (BMWLocationManager*)sharedInstance
{
    static BMWLocationManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BMWLocationManager alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - Getters

- (HttpClient *)httpClient {
    if (!_httpClient) {
        _httpClient = [[HttpClient alloc] init];
    }
    return _httpClient;
}

#pragma mark - Public
- (void)fetchNearByLocationsWithCompletionHandler:(void (^)(NSArray *locations, NSError *error))completionBlock
{
    [self.httpClient getRequestWithUrl:kBMWLocationsAPI completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = [httpResponse statusCode];
        
        if (statusCode == 200) {
            if (!error) {
                id resp = data;
                if ( data && [data isKindOfClass:[NSData class]])
                {
                    resp = [BMWUtility parseJSONData:data];
                }
                if ([resp isKindOfClass:[NSArray class]])
                {
                    NSMutableArray * locations = [[NSMutableArray alloc] init];
                    DLog(@"Locations %@", resp);
                    
                    __block BMWLocation *bmwLocation;
                    [resp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
                        bmwLocation = [[BMWLocation alloc] initLocationWithDictionary:obj];
                        
                        [locations addObject:bmwLocation];
                    }];
                    
                    completionBlock(locations, nil);
                }
                else {
                    NSError *error = [NSError bmwErrorForCode:BMWErrorInvalidResponse];
                    completionBlock(nil, error);
                }
                
            }
        }
        else {
            NSError *error = [NSError bmwErrorForCode:BMWErrorUnknown];
            completionBlock(nil, error);
        }

    }];
}

@end
