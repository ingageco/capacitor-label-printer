#import <Capacitor/Capacitor.h>
#import <ExternalAccessory/ExternalAccessory.h>
#import "BRUserDefaults.h"
#import <BRLMPrinterKit/BRPtouchNetworkManager.h>
#import <BRLMPrinterKit/BRPtouchPrinterKit.h>
#import "BRWLANPrintOperation.h"

// Keep your existing #define statements

@interface BrotherPrinterPlugin : CAPPlugin <BRPtouchNetworkDelegate>

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *brotherDeviceList;
@property (nonatomic, strong) BRPtouchNetworkManager *networkManager;
@property (nonatomic, strong) BRPtouchPrinter *ptp;
@property (nonatomic, strong) NSString *customPaperFilePath;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) void (^callback)(NSArray *, NSError *);

// Declare your plugin methods here
- (void)findNetworkPrinters:(CAPPluginCall*)call;
- (void)findPrinters:(CAPPluginCall*)call;
- (void)setPrinter:(CAPPluginCall*)call;
- (void)printViaSDK:(CAPPluginCall*)call;
- (void)sendUSBConfig:(CAPPluginCall*)call;

@end