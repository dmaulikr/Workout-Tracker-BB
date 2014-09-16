//
//  IAPProduct.h
//  90 DWT BB
//
//  Created by Grant, Jared on 9/16/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKProduct;

@interface IAPProduct : NSObject

- (id)initWithProductIdentifier:(NSString *)productIdentifier;
- (BOOL)allowedToPurchase;

@property (nonatomic, assign) BOOL availableForPurchase;
@property (nonatomic, strong) NSString * productIdentifier;
@property (nonatomic, strong) SKProduct * skProduct;
@property (nonatomic, assign) BOOL purchaseInProgress;

@end
