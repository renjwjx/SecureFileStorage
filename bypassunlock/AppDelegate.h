//
//  AppDelegate.h
//  bypassunlock
//
//  Created by jinren on 4/23/20.
//  Copyright © 2020 jinren. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GD.Runtime;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
                            
// GD methods
- (void)didAuthorize;

@end
