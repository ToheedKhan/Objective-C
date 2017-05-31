//
//  RadixTreeNode.m
//  BMWTask2
//
//  Created by Toheed Khan on 08/02/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "RadixTreeNode.h"

@implementation RadixTreeNode
-(instancetype)init {
    self = [super init];
    if (self) {
        _children = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSUInteger)matchedCharactersCount:(NSString *)value {
    int matchedCharactersCount = 0;
    
    while (matchedCharactersCount < value.length && matchedCharactersCount < self.key.length) {
        if ([value characterAtIndex:matchedCharactersCount] != [self.key characterAtIndex:matchedCharactersCount]) {
            break;
        }
        
        matchedCharactersCount++;
    }
    
    return matchedCharactersCount;
}

@end
