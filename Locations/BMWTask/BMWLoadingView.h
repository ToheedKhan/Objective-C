//
//  BMWLoadingView.h
//  BMWTask
//
//  Created by Toheed Khan on 27/01/16.
//  Copyright © 2016 Toheed Khan. All rights reserved.
//

@import UIKit;

@interface BMWLoadingView : UIView
- (instancetype)initBMWLoadingView;
- (instancetype)initBMWLoadingViewWithText:(NSString *)text;

- (void)showLoadingView;
- (void)hideLoadingView;
@end
