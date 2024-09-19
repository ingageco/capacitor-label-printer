//
//  BRWLANPrintOperation.m
//  SDK_Sample_Ver2
//
//  Created by Kusumoto Naoki on 2015/08/18.
//  Copyright (c) 2015年 Kusumoto Naoki. All rights reserved.
//

#import "BRUserDefaults.h"
#import "BRWLANPrintOperation.h"

@interface BRWLANPrintOperation () {
}
@property(nonatomic, assign) BOOL isExecutingForWLAN;
@property(nonatomic, assign) BOOL isFinishedForWLAN;

@property(nonatomic, weak) BRPtouchPrinter *ptp;
@property(nonatomic, strong) BRPtouchPrintInfo *printInfo;
@property(nonatomic, assign) CGImageRef imgRef;
@property(nonatomic, assign) int numberOfPaper;
@property(nonatomic, strong) NSString *ipAddress;

@end

@implementation BRWLANPrintOperation

@synthesize resultStatus = _resultStatus;
@synthesize errorCode = _errorCode;
@synthesize dict = _dict;


- (id)initWithOperation:(BRPtouchPrinter *)targetPtp
              printInfo:(BRPtouchPrintInfo *)targetPrintInfo
                 imgRef:(CGImageRef)targetImgRef
          numberOfPaper:(int)targetNumberOfPaper
              ipAddress:(NSString *)targetIPAddress
               withDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ptp = targetPtp;
        self.printInfo = targetPrintInfo;
        self.imgRef = targetImgRef;
        self.numberOfPaper = targetNumberOfPaper;
        self.ipAddress = targetIPAddress;
        _dict = dict;

    }

    return self;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
   // NSLog(@"==== in automaticallyNotifiesObserversForKey with callback id             = %@  ", key);
    if ([key isEqualToString:@"communicationResultForWLAN"] ||
            [key isEqualToString:@"isExecutingForWLAN"] ||
            [key isEqualToString:@"isFinishedForWLAN"]) {
        return YES;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

- (void)main {
    self.isExecutingForWLAN = YES;

    // Set up the printer
    [self.ptp setIPAddress:self.ipAddress];
    [self.ptp setPrintInfo:self.printInfo];

    // Attempt to print
    _errorCode = [self.ptp printImage:self.imgRef copy:self.numberOfPaper];
    NSLog(@"==== in main error code in instance is %d", self.errorCode);

    if (_errorCode == ERROR_NONE_) {
        self.communicationResultForWLAN = YES;
        PTSTATUSINFO resultstatus;
        [self.ptp getPTStatus:&resultstatus];
        _resultStatus = resultstatus;
    } else {
        self.communicationResultForWLAN = NO;
        NSLog(@"Printing failed with error code: %d", _errorCode);
    }

    self.isExecutingForWLAN = NO;
    self.isFinishedForWLAN = YES;
}
@end
