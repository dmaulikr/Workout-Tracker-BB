//
//  IAPProduct.m
//  90 DWT BB
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import "IAPProduct.h"

@implementation IAPProduct

- (id)initWithProductIdentifier:(NSString *)productIdentifier {
    if ((self = [super init])) {
        self.availableForPurchase = NO;
        self.productIdentifier = productIdentifier;
        self.skProduct = nil;
    }
    return self;
}

- (BOOL)allowedToPurchase {
    if (!self.availableForPurchase) return NO;
    return YES;
}
@end
