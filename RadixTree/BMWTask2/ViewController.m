//
//  ViewController.m
//  BMWTask2
//
//  Created by Toheed Khan on 08/02/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "ViewController.h"
#import "RadixTree.h"

@interface ViewController ()

@property (nonatomic, strong) RadixTree *wordsTree;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self saveWords];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RadixTree *)wordsTree {
    if (!_wordsTree) {
        _wordsTree = [[RadixTree alloc] init];
    }
    return _wordsTree;
}

- (void)saveWords {
    
//    NSArray *words = @[@"Ant", @"Ant"];
    NSArray *words = @[@"Ant", @"Autocrate", @"Automatic", @"Automatic", @"Analogy", @"Autograph", @"Boy", @"Bible", @"Body", @"Bool", @"Cat", @"Casteism", @"Auto", @"caste"];
//     NSArray *words = @[@"Automobile", @"Auto", @"Auto", @"Automobile", @"Autocrate"];
    __weak ViewController *weakSelf = self;
    
    [words enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj = [obj lowercaseString];
      BOOL success =  [weakSelf.wordsTree insertString:obj];
        
        if (success == NO) {
            NSLog(@"Duplicate %@", obj);
        }

    }];
    NSLog(@"Word Tree %@", [self.wordsTree description]);
}

@end
