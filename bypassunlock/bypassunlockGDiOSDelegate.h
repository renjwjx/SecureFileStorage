//
//  bypassunlockGDiOSDelegate.h
//  bypassunlock
//
//  Created by jinren on 4/23/20.
//  Copyright © 2020 jinren. All rights reserved.
//

@import GD.Runtime;
#import "AppDelegate.h"
#import "ViewController.h"

@interface bypassunlockGDiOSDelegate : NSObject <GDiOSDelegate>

@property (weak, nonatomic) ViewController *rootViewController;
@property (weak, nonatomic) AppDelegate *appDelegate;
@property (assign,nonatomic,readonly) BOOL hasAuthorized;
                            
+(instancetype)sharedInstance;
                        
@end
