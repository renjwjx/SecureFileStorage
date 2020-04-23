//
//  ViewController.m
//  bypassunlock
//
//  Created by jinren on 4/23/20.
//  Copyright © 2020 jinren. All rights reserved.
//

#import "ViewController.h"
#import "bypassunlockGDiOSDelegate.h"
#import <GD/GDFileManager.h>
#import <GD/GDServices.h>
@interface ViewController ()

@property (strong, nonatomic) NSString* secureFilePath;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [bypassunlockGDiOSDelegate sharedInstance].rootViewController = self;
    
    NSArray* directory = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString* applicationSuppport = [directory firstObject];

    NSString* secureFilePath = [applicationSuppport stringByAppendingPathComponent:@"secure-curl-master.zip"];
    
    if (![[GDFileManager defaultManager] fileExistsAtPath:secureFilePath])
    {
        NSString* pdfPath = [[NSBundle mainBundle] pathForResource:@"curl-master" ofType:@"zip"];
        NSData* originPDFData = [NSData dataWithContentsOfFile:pdfPath];

        BOOL secureFileCreated = [[GDFileManager defaultManager] createFileAtPath:secureFilePath contents:originPDFData attributes:nil];
        NSLog(@"secureFileCreated: %d", secureFileCreated);
    }
    self.secureFilePath = secureFilePath;
    
}


- (void)didReceiveMemoryWarning {
}


- (IBAction)sendFiles:(id)sender {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@[@"test@blackberry.com"] forKey:@"to"];
    [params setObject:@"test secure file" forKey:@"subject"];
    [params setObject:@"This is for Test" forKey:@"body"];
    NSArray * securityAttachments = @[self.secureFilePath];
    NSError* err = nil;
    [GDServiceClient sendTo:@"com.good.gcs.g3" withService:@"com.good.gfeservice.send-email" withVersion:@"1.0.0.0" withMethod:@"sendEmail" withParams:params withAttachments:securityAttachments bringServiceToFront:GDEPreferPeerInForeground requestID:nil error:&err];
    
    NSLog(@"send to BB work, %@", err);

}


@end
