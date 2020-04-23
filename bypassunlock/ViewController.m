//
//  ViewController.m
//  bypassunlock
//
//  Created by jinren on 4/23/20.
//  Copyright © 2020 jinren. All rights reserved.
//

#import "ViewController.h"
#import "bypassunlockGDiOSDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [bypassunlockGDiOSDelegate sharedInstance].rootViewController = self;
                             
}


- (void)didReceiveMemoryWarning {
}


@end
