//
//  IAPHelper.h
//  90 DWT BB
//
//  Created by Jared Grant on 9/15/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestProductsCompletionHandler)
(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

@property (nonatomic, strong) NSMutableDictionary * products;

- (id)initWithProducts:(NSMutableDictionary *)products;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end