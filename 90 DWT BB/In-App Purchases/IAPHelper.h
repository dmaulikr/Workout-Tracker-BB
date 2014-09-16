//
//  IAPHelper.h
//  90 DWT BB
//
//  Created by Jared Grant on 9/15/14.
//  Copyright (c) 2014 Jared Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAPHelper : NSObject
- (void)requestProductsWithProductIdentifiers:(NSSet *)productIdentifiers;
@end