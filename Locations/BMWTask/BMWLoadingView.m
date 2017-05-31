//
//  BMWLoadingView.m
//  BMWTask
//
//  Created by Toheed Khan on 27/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

#import "BMWLoadingView.h"

@interface BMWLoadingView ()

@property (nonatomic, retain) UIActivityIndicatorView * activityView;

@end

@implementation BMWLoadingView

- (instancetype)initBMWLoadingView {
    return [self initBMWLoadingViewWithText:@"Loading..."];
}

- (instancetype)initBMWLoadingViewWithText:(NSString *)text
{
    self = [super initWithFrame:CGRectMake(0, 0, 120, 120)];
    
    if (self) {
        [self configureViewWithText:text];
    }
    return self;
}

- (void)showLoadingView {
    self.hidden = NO;
    [self.activityView startAnimating];
}

- (void)hideLoadingView {
    self.hidden = YES;

    [self.activityView stopAnimating];
}

#pragma mark - Private

- (void)configureViewWithText:(NSString *)text {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10.0;
    self.hidden = YES;
    
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityView.frame = CGRectMake((self.center.x -_activityView.bounds.size.width/2), 20, _activityView.bounds.size.width, _activityView.bounds.size.height);
    [self addSubview:_activityView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (_activityView.frame.origin.y +_activityView.bounds.size.height + 20), self.frame.size.width, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = text;
    
    [self addSubview:loadingLabel];
}

@end
