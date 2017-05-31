//
//  HttpClient.h
//  BMWTask
//
//  Created by Toheed Khan on 25/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

@interface HttpClient : NSObject

typedef void (^BMWRequestCompletionHandler)(NSData *data, NSURLResponse *response, NSError *error);

- (void)getRequestWithUrl:(NSString*)url completionHandler:(BMWRequestCompletionHandler)completionBlock;

@end
