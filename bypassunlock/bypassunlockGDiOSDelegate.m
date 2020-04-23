//
//  bypassunlockGDiOSDelegate.m
//  bypassunlock
//
//  Created by jinren on 4/23/20.
//  Copyright © 2020 jinren. All rights reserved.
//

#import "bypassunlockGDiOSDelegate.h"

@interface bypassunlockGDiOSDelegate ()


@property (nonatomic, assign) BOOL hasAuthorized;							
                        

-(instancetype)init;
-(void)didAuthorize;						
                        
@end

@implementation bypassunlockGDiOSDelegate

+ (instancetype)sharedInstance {

    static bypassunlockGDiOSDelegate *gdiOSDelegate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gdiOSDelegate = [[bypassunlockGDiOSDelegate alloc] init];
    });
    return gdiOSDelegate;							
                            
}


- (instancetype)init {
    self = [super init];
    if (self) {

        // Do any additional setup						
                                
    }
    return self;
}

- (void)setRootViewController:(ViewController *)rootViewController {

    _rootViewController = rootViewController;
    [self didAuthorize];							
                            
}


- (void)setAppDelegate:(AppDelegate *)appDelegate {

    _appDelegate = appDelegate;
    [self didAuthorize];							
                            
}


- (void)didAuthorize {

    if (self.hasAuthorized && self.rootViewController && self.appDelegate)
    {
        [self.appDelegate didAuthorize];
    }						
                            
}



#pragma mark - BlackBerry Dynamics SDK Delegate Methods
- (void)handleEvent:(GDAppEvent *)anEvent {

    /* Called from BlackBerry Dynamics SDK when events occur, such as system startup. */
    switch (anEvent.type)
    {
        case GDAppEventAuthorized:
        {
            [self onAuthorized:anEvent];
            break;
        }
        case GDAppEventNotAuthorized:
        {
            [self onNotAuthorized:anEvent];
            break;
        }
        case GDAppEventRemoteSettingsUpdate:
        {
            //A change to application-related configuration or policy settings.
            break;
        }
        case GDAppEventServicesUpdate:
        {
            //A change to services-related configuration.
            break;
        }
        case GDAppEventPolicyUpdate:
        {
            //A change to one or more application-specific policy settings has been received.
            break;
        }
        case GDAppEventEntitlementsUpdate:
        {
            //A change to the entitlements data has been received.
            break;
        }
        default:
        {
            NSLog(@"Unhandled Event");
            break;
        }
    }
}

- (void)onNotAuthorized:(GDAppEvent *)anEvent {

    /* Handle the BlackBerry Dynamics SDK not authorized event. */
    switch (anEvent.code) {
        case GDErrorActivationFailed:
        case GDErrorProvisioningFailed:
        case GDErrorPushConnectionTimeout:
        case GDErrorSecurityError:
        case GDErrorAppDenied:
        case GDErrorAppVersionNotEntitled:
        case GDErrorBlocked:
        case GDErrorWiped:
        case GDErrorRemoteLockout: 
        case GDErrorPasswordChangeRequired: {
            // an condition has occured denying authorization, an application may wish to log these events
            NSLog(@"onNotAuthorized %@", anEvent.message);
            break;
        }
        case GDErrorIdleLockout: {
            // idle lockout is benign & informational
            break;
        }
        default: 
            NSAssert(false, @"Unhandled not authorized event");
            break;
    }
}


- (void)onAuthorized:(GDAppEvent *)anEvent {

    /* Handle the BlackBerry Dynamics SDK authorized event. */                            
    switch (anEvent.code) {
        case GDErrorNone: {
            if (!self.hasAuthorized) {
                // launch application UI here
                NSString *storyboardName = nil;
                storyboardName = @"Main";
        
                UIStoryboard *uiStoryboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
                UIViewController *uiViewController = [uiStoryboard instantiateInitialViewController];
        
                self.appDelegate.window.rootViewController = uiViewController;
        
                self.hasAuthorized = YES;
        
                [self didAuthorize];
        
            }
            break;
        }
        default:
            NSAssert(false, @"Authorized startup with an error");
            break;
    }
}


@end
