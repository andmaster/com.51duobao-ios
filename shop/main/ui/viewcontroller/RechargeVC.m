//
//  RechargeVC.m
//  shop
//
//  Created by zhangwenqiang on 16/8/18.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "RechargeVC.h"

//在内购项目中创的商品单号
#define ProductID_IAP0p20 @"Nada.JPYF01"//20
#define ProductID_IAP1p100 @"Nada.JPYF02" //100
#define ProductID_IAP4p600 @"Nada.JPYF03" //600
#define ProductID_IAP9p1000 @"Nada.JPYF04" //1000
#define ProductID_IAP24p6000 @"Nada.JPYF05" //6000

@interface RechargeVC()

@end

@implementation RechargeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"宝石充值";
    
    UIBarButtonItem* backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(didBack:)];
    
    [backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    [self buy:IAP0p20];
}

-(void)didBack:(UIBarButtonItem*)barButtonItem{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)buy:(int)type{
    
    buyType = type;
    
    if ([SKPaymentQueue canMakePayments]) {
        
        [self RequestProductData];
        
        NSLog(@"允许程序内付费购买");
    }
    else {
        
        NSLog(@"不允许程序内付费购买");
        
        UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您的手机没有打开程序内付费购买"
                                                           delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
        
        [alerView show];
        
    }
}

-(void)RequestProductData{
    
    NSLog(@"---------请求对应的产品信息------------");
    
    NSArray *product = nil;
    
    switch (buyType) {
            
        case IAP0p20:
            
            product=[[NSArray alloc] initWithObjects:@"com.ddyyyg.shop1126308815"/*ProductID_IAP0p20*/,nil];
            break;
            
        case IAP1p100:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP1p100,nil];
            break;
            
        case IAP4p600:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP4p600,nil];
            break;
            
        case IAP9p1000:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP9p1000,nil];
            break;
            
        case IAP24p6000:
            product=[[NSArray alloc] initWithObjects:ProductID_IAP24p6000,nil];
            break;
            
        default:
            break;
    }
    
    NSSet *nsset = [NSSet setWithArray:product];
    
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    
    request.delegate=self;
    
    [request start];
    
}

//<SKProductsRequestDelegate> 请求协议
//收到的产品信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"-----------收到产品反馈信息--------------");
    
    NSArray *products = response.products;
    
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    
    NSLog(@"产品付费数量: %d", (int)[products count]);
    
    // populate UI
    /*for(SKProduct * product in products){
        
        Log(@"product info");
        
        Log(@"SKProduct 描述信息%@", [product description]);
        
        Log(@"产品标题 %@" , product.localizedTitle);
        
        Log(@"产品描述信息: %@" , product.localizedDescription);
        
        Log(@"价格: %@" , product.price);
        
        Log(@"Product id: %@" , product.productIdentifier);
    }*/
    
    SKPayment *payment = nil;
    
    switch (buyType) {
            
        case IAP0p20:
            //payment  = [SKPayment paymentWithProductIdentifier:@"com.ddyyyg.shop1126308815"/*ProductID_IAP0p20*/];    //支付25
            //[SKPayment paymentWithProduct:<#(nonnull SKProduct *)#>]
            break;
        case IAP1p100:
           //payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP1p100];    //支付108
            break;
        case IAP4p600:
            //payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP4p600];    //支付618
            break;
        case IAP9p1000:
            //payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP9p1000];    //支付1048
            break;
        case IAP24p6000:
            //payment  = [SKPayment paymentWithProductIdentifier:ProductID_IAP24p6000];    //支付5898
            break;
        default:
            break;
    }
    
    NSLog(@"---------发送购买请求------------");
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
- (void)requestProUpgradeProductData{
    
    NSLog(@"------请求升级数据---------");
    
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.productid"];
    
    SKProductsRequest* productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    
    productsRequest.delegate = self;
    
    [productsRequest start];
    
}
//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"-------弹出错误信息----------");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
    
}

-(void) requestDidFinish:(SKRequest *)request{
    
    NSLog(@"----------反馈信息结束--------------");
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}

//<SKPaymentTransactionObserver> 千万不要忘记绑定，代码如下：
//----监听购买结果
//[[SKPaymentQueue defaultQueue] addTransactionObserver:self];

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions/*交易结果*/{
    
    NSLog(@"-----paymentQueue--------");
    for (SKPaymentTransaction *transaction in transactions){
        
        switch (transaction.transactionState){
                
            case SKPaymentTransactionStatePurchased:{//交易完成
                
                [self completeTransaction:transaction];
                
                NSLog(@"-----交易完成 --------");
                
                UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@""
                                                                    message:@"购买成功"
                                                                   delegate:nil
                                                          cancelButtonTitle:NSLocalizedString(@"关闭",nil)
                                                          otherButtonTitles:nil];
                
                [alerView show];
                
            }
                break;
                
            case SKPaymentTransactionStateFailed:/*交易失败*/{
                
                [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                UIAlertView *alerView2 =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:@"购买失败，请重新尝试购买"
                                                                    delegate:nil
                                                           cancelButtonTitle:NSLocalizedString(@"关闭",nil)
                                                           otherButtonTitles:nil];
                
                [alerView2 show];
                
            }
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                
                [self restoreTransaction:transaction];
                
                NSLog(@"-----已经购买过该商品 --------");
                
            case SKPaymentTransactionStatePurchasing://商品添加进列表
                
                NSLog(@"-----商品添加进列表 --------");
                
                break;
                
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction{
    
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        
        NSString *bookid = [tt lastObject];
        
        if ([bookid length] > 0) {
            
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
    }
    
    // Remove the transaction from the payment queue.
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

//记录交易
-(void)recordTransaction:(NSString *)product{
    
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    
    NSLog(@"-----下载--------");
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled){
        
        
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction{
    
    NSLog(@" 交易恢复处理");
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    
    NSLog(@"-------paymentQueue----");
}

#pragma mark connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    switch([(NSHTTPURLResponse *)response statusCode]) {
        case 200:
        case 206:
            break;
        case 304:
            break;
        case 400:
            break;
        case 404:
            break;
        case 416:
            break;
        case 403:
            break;
        case 401:
        case 500:
            break;
        default:
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"test");
}

-(void)dealloc{
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
}

@end
