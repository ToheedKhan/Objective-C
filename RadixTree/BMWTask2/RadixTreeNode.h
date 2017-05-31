//
//  RadixTreeNode.h
//  BMWTask2
//
//  Created by Toheed Khan on 08/02/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import Foundation;

@interface RadixTreeNode : NSObject

@property (nonatomic, strong) NSMutableArray * children;
@property (nonatomic, strong) NSString *       key;
@property (nonatomic, assign) BOOL      isRoot;
@property (nonatomic, assign) BOOL      isRepresentAWord;

- (NSUInteger)matchedCharactersCount:(NSString *)value;

@end

//extern NSString *const kBMWLocationID ;