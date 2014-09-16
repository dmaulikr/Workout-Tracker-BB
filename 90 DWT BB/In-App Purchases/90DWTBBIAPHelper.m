//
//  90DWTBBIAPHelper.m
//  90 DWT BB
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "90DWTBBIAPHelper.h"
#import "IAPProduct.h"

@implementation _0DWTBBIAPHelper

+ (_0DWTBBIAPHelper *)sharedInstance {
    
    static dispatch_once_t once;
    static _0DWTBBIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    
    IAPProduct * workoutEditor = [[IAPProduct alloc] initWithProductIdentifier:@"com.grantsoftware.90DWTBB.workouteditor"];
    
    NSMutableDictionary * products = [ @{workoutEditor.productIdentifier: workoutEditor} mutableCopy];
    
    if ((self = [super initWithProducts:products])) {
    }
    return self;
}

@end
