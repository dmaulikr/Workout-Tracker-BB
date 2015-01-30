//
//  90DWTBBIAPHelper.m
//  90 DWT BB
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "90DWTBBIAPHelper.h"

@implementation _0DWTBBIAPHelper

+ (_0DWTBBIAPHelper *)sharedInstance {
    
    static dispatch_once_t once;
    static _0DWTBBIAPHelper * sharedInstance;
    
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects: @"com.grantsoftware.90DWTBB.removeads",
                                                            @"com.grantsoftware.90DWTBB.graphview", nil];
        
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    return sharedInstance;
}

@end
