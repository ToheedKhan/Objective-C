//
//  RadixTree.m
//  BMWTask2
//
//  Created by Toheed Khan on 08/02/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "RadixTree.h"
#import "RadixTreeNode.h"


@interface RadixTree ()
{
    NSInteger _count;
}

@property (nonatomic, strong) RadixTreeNode* root;

@end

@implementation RadixTree

-(instancetype) init {
    self = [super init];
    if (self) {
        _root = [[RadixTreeNode alloc] init];
        _root.key = @"";
        _root.isRoot = YES;
        _root.isRepresentAWord = NO;

        _count = 0;
    }
    
    return self;
}

- (BOOL)insertString:(NSString *)keyToBeAdded
                node:(RadixTreeNode *)node {
    NSUInteger matchedCharsCount = [node matchedCharactersCount:keyToBeAdded];
    
    //When we are either at the root node
    //or We need to go down in  the tree
    if (node.key.length == 0 || matchedCharsCount == 0 || (matchedCharsCount < keyToBeAdded.length && matchedCharsCount >= node.key.length)) {
        BOOL flag = NO;
        NSString *newText = [keyToBeAdded substringFromIndex:matchedCharsCount];
        for (RadixTreeNode *child in node.children) {
            if ([child.key characterAtIndex:0] == [newText characterAtIndex:0]) {
                flag = YES;
                [self insertString:newText node:child];
                break;
            }
        }
        
        // Add the node as the child of the current node
        if (flag == NO) {
            RadixTreeNode *n = [[RadixTreeNode alloc] init];
            n.key = newText;
            n.isRepresentAWord = YES;
            
            [node.children addObject:n];
        }
    }
    // If exact match is found, just make the current node as data node
    else if (matchedCharsCount == keyToBeAdded.length && matchedCharsCount == node.key.length) {
        if (node.isRepresentAWord) {
            return NO;
        }
        
        node.isRepresentAWord = YES;
    }
    // Split the node
    else if (matchedCharsCount > 0 && matchedCharsCount < node.key.length) {
        RadixTreeNode *n1 = [[RadixTreeNode alloc] init];
        n1.key = [node.key substringFromIndex:matchedCharsCount];
        n1.isRepresentAWord = node.isRepresentAWord;
        n1.children = node.children;
        
        node.key = [keyToBeAdded substringToIndex:matchedCharsCount];
        node.isRepresentAWord = NO;
        node.children = [[NSMutableArray alloc] initWithObjects:n1, nil];
        
        if (matchedCharsCount < keyToBeAdded.length) {
            RadixTreeNode *n2 = [[RadixTreeNode alloc] init];
            n2.key = [keyToBeAdded substringFromIndex:matchedCharsCount];
            n2.isRepresentAWord = YES;
            
            [node.children addObject:n2];
        } else {
            node.isRepresentAWord= YES;
        }
    }
    else {
        RadixTreeNode *n = [[RadixTreeNode alloc] init];
        n.key = [node.key substringFromIndex:matchedCharsCount];
        n.children = node.children;
        n.isRepresentAWord = node.isRepresentAWord;
        
        node.key = keyToBeAdded;
        node.isRepresentAWord = YES;
        
        [node.children addObject:n];
    }
    
    return YES;
}

- (void)stringRepresentationOfNode:(RadixTreeNode *)node
                           atLevel:(NSUInteger)level
                          toString:(NSMutableString *)treeStructure {
    
    [treeStructure appendString:@"\n"];

    if (level == 0) {
        [treeStructure appendString:@"\n |root"];
    }
    else {
        for (int i = 0; i < level; i++) {
            [treeStructure appendString:@" "];
        }
        
        [treeStructure appendString:@" |"];
    }
    
    for (int i = 0; i < level; i++) {
        [treeStructure appendString:@"-"];
    }
    
    if (node.isRepresentAWord) {
        [treeStructure appendFormat:@"%@*", node.key];
    }
    else {
        [treeStructure appendFormat:@"%@", node.key];
    }
    
    for (RadixTreeNode *child in node.children) {
        [self stringRepresentationOfNode:child atLevel:level+1 toString:treeStructure];
    }
    
}

- (NSString *)description {
    NSMutableString *treeStructure = [[NSMutableString alloc] init];
    
    [self stringRepresentationOfNode:_root atLevel:0 toString:treeStructure];
    
    return treeStructure;
}

#pragma mark - Public

- (BOOL)insertString:(NSString *)strToBeAdded
{
    if (![self isStringExistInTree:strToBeAdded]) {
        if ([self insertString:strToBeAdded node:_root]) {
            _count++;
            
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isStringExistInTree:(NSString *)searchStr {
    return [self findString:searchStr WithNode:_root];
}

- (BOOL)findString:(NSString *)str WithNode:(RadixTreeNode *)node {
    BOOL isFound = NO;
    
    if (node.key.length == 0) {
        for (RadixTreeNode * child in node.children) {
            NSUInteger matchedCharsCount = [child matchedCharactersCount:str];

            if (child.key.length == matchedCharsCount && matchedCharsCount == str.length) {
                isFound = YES;
            }
            else if (matchedCharsCount > 0 && matchedCharsCount < str.length) {
               isFound = [self findString:[str substringFromIndex:matchedCharsCount] WithNode:child];
            }
            else if (matchedCharsCount == 0)
                continue;
        }
    }
    else {
        NSUInteger matchedCharsCount = [node matchedCharactersCount:str];
        
        if (matchedCharsCount == str.length) {
            isFound = YES;
        }
        else {
            for (RadixTreeNode * child in node.children) {
                NSUInteger matchedCharsCount = [child matchedCharactersCount:str];
                
                if (child.key.length == matchedCharsCount && matchedCharsCount == str.length) {
                    isFound = YES;
                }
                else if (matchedCharsCount > 0 && matchedCharsCount < str.length) {
                    [self findString:[str substringFromIndex:matchedCharsCount] WithNode:child];
                }
                else if (matchedCharsCount == 0)
                    continue;
            }
        }
    }
    return isFound;
    
}

@end

