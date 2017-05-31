//
//  HttpClient.m
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "HttpClient.h"

NSString * const kBMWServerBaseUrl    = @"https://localsearch.azurewebsites.net/api/";

@implementation HttpClient

- (void)getRequestWithUrl:(NSString*)url completionHandler:(BMWRequestCompletionHandler)completionBlock
{
    NSURL* requestUr = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBMWServerBaseUrl, url]];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    sessionConfig.timeoutIntervalForRequest = 30.0;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUr];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithRequest:request completionHandler:completionBlock] resume];
}

@end
