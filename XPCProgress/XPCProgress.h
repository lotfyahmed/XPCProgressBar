//
//  XPCProgress.h
//  XPCProgress
//
//  Created by Ahmed Lotfy on 11/26/15.
//  Copyright © 2015 Ahmed Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCProgressProtocol.h"

// This object implements the protocol which we have defined. It provides the actual behavior for the service. It is 'exported' by the service to make it available to the process hosting the service over an NSXPCConnection.
@interface XPCProgress : NSObject <NSXPCListenerDelegate, XPCProgressProtocol>

@property (strong, nonatomic) NSXPCConnection * xpcConnection;
@end
