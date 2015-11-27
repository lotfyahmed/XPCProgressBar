//
//  main.m
//  XPCProgress
//
//  Created by Ahmed Lotfy on 11/26/15.
//  Copyright © 2015 Ahmed Lotfy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPCProgress.h"


int main(int argc, const char *argv[])
{
    // Create the delegate for the service.
    XPCProgress *progressDelegate = [XPCProgress new];
    
    // Set up the one NSXPCListener for this service. It will handle all incoming connections.
    NSXPCListener *listener = [NSXPCListener serviceListener];
    listener.delegate = progressDelegate;
    
    // Resuming the serviceListener starts this service. This method does not return.
    [listener resume];
    // For mach service listeners, the resume method returns immediately so
    // we need to start our event loop manually.
    [[NSRunLoop currentRunLoop] run];
    return 0;
}
