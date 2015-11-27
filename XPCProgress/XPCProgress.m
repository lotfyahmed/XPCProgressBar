//
//  XPCProgress.m
//  XPCProgress
//
//  Created by Ahmed Lotfy on 11/26/15.
//  Copyright © 2015 Ahmed Lotfy. All rights reserved.
//

#import "XPCProgress.h"
#include <stdlib.h>

@implementation XPCProgress

- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection {
    // This method is where the NSXPCListener configures, accepts, and resumes a new incoming NSXPCConnection.
    // Configure the connection.
    // First, set the interface that the exported object implements.
    newConnection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(XPCProgressProtocol)];
    newConnection.exportedObject = self;

    self.xpcConnection = newConnection;
    // Resuming the connection allows the system to deliver more incoming messages.
    [newConnection resume];
    
    // Returning YES from this method tells the system that you have accepted this connection. If you want to reject the connection for some reason, call -invalidate on the connection and return NO.
    return YES;
}

// This implements the example protocol. Replace the body of this class with the implementation of this service's protocol.
-(void) startProgressWithReply:(void(^)(NSInteger))reply{
    NSInteger number = arc4random_uniform(100);
    reply(number);
}
@end
