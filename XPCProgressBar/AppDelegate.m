//
//  AppDelegate.m
//  XPCProgressBar
//
//  Created by Ahmed Lotfy on 11/26/15.
//  Copyright © 2015 Ahmed Lotfy. All rights reserved.
//

#import "AppDelegate.h"
#import "XPCProgressProtocol.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSXPCConnection * connection;
@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self.progressIndicator startAnimation:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.connection invalidate];
}

- (IBAction)startAction:(NSButton *)sender {
    [self openConnectionToXPC];
    __block NSInteger value = 50;
    id<XPCProgressProtocol>proxyObject = [self.connection remoteObjectProxy];
    for (NSInteger i = 0; i < SECONDS; i++) {
        [proxyObject startProgressWithReply:^(NSInteger response) {
            value = response;
            [self updateProgress:value];
        }];
    }
}

- (void)openConnectionToXPC{
    self.connection = [[NSXPCConnection alloc] initWithServiceName:@"com.badrit.XPCProgress"];
    NSXPCInterface * remoteInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCProgressProtocol)];
    [self.connection setRemoteObjectInterface:remoteInterface];
    NSXPCInterface * exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCProgressProtocol)];
    [self.connection setExportedInterface:exportedInterface];
    self.connection.exportedObject = self;
    [self.connection resume];
}

#pragma Progress Delegate
- (void)updateProgress:(NSInteger)value{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.progressIndicator setDoubleValue:value];
        sleep(1);
    }];
}

- (void)finished{
    [self.connection invalidate];
}

@end
