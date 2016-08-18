//
//  RechargeVC.h
//  shop
//
//  Created by zhangwenqiang on 16/8/18.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "BaseViewController.h"
#import <StoreKit/StoreKit.h>

enum{
    IAP0p20=20,
    IAP1p100,
    IAP4p600,
    IAP9p1000,
    IAP24p6000,
}buyCoinsTag;

@interface RechargeVC : BaseViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate>{
    
    int buyType;
}

-(void) requestProUpgradeProductData;

-(void)RequestProductData;

-(void)buy:(int)type;

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction;

-(void) completeTransaction: (SKPaymentTransaction *)transaction;

-(void) failedTransaction: (SKPaymentTransaction *)transaction;

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction;

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error;

-(void) restoreTransaction: (SKPaymentTransaction *)transaction;

-(void)provideContent:(NSString *)product;

-(void)recordTransaction:(NSString *)product;

@end
