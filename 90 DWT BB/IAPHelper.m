//
//  IAPHelper.m
//  90 DWT BB
//
//  Created by Jared Grant on 9/15/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

// 1
#import "IAPHelper.h"
@import StoreKit;
// 2
@interface IAPHelper () <SKProductsRequestDelegate>
@end
@implementation IAPHelper {
    SKProductsRequest * _productsRequest; // 3
}
- (void)requestProductsWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    // 4
    _productsRequest = [[SKProductsRequest alloc]initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products: %@",error.localizedDescription);
    _productsRequest = nil;
}
@end