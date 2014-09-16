//
//  IAPHelper.m
//  90 DWT BB
//
//  Created by Jared Grant on 9/15/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

// 1
#import "IAPHelper.h"
#import "IAPProduct.h"
@import StoreKit;
// 2
@interface IAPHelper () <SKProductsRequestDelegate>
@end
@implementation IAPHelper {
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler; // 3
}

- (id)initWithProducts:(NSMutableDictionary *)products {
    if ((self = [super init])) {
        _products = products;
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    // 1
    _completionHandler = [completionHandler copy];
    // 2
    NSMutableSet * productIdentifiers = [NSMutableSet setWithCapacity:_products.count];
    
    for (IAPProduct * product in _products.allValues) {
        
        product.availableForPurchase = NO;
        [productIdentifiers addObject:product.productIdentifier];
    }
    // 3
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    // 1
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        IAPProduct * product =
        _products[skProduct.productIdentifier];
        product.skProduct = skProduct;
        product.availableForPurchase = YES;
    }
    
    // 2
    for (NSString * invalidProductIdentifier in response.invalidProductIdentifiers) {
        IAPProduct * product =
        _products[invalidProductIdentifier];
        product.availableForPurchase = NO;
        NSLog(@"Invalid product identifier, removing: %@", invalidProductIdentifier);
    }
    
    // 3
    NSMutableArray * availableProducts = [NSMutableArray array];
    for (IAPProduct * product in _products.allValues) {
        if (product.availableForPurchase) {
            [availableProducts addObject:product];
        }
    }
    
    _completionHandler(YES, availableProducts);
    _completionHandler = nil;
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products: %@", error.localizedDescription);
    _productsRequest = nil;
    
    // 5
    _completionHandler(FALSE, nil);
    _completionHandler = nil;
}

@end