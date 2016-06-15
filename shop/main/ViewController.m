//
//  ViewController.m
//  shop
//
//  Created by zhangwenqiang on 16/6/5.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "ViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
#import "WebViewJavascriptBridge.h"
#import "UIWebView+BlackColor.h"

@interface ViewController ()<NJKWebViewProgressDelegate>

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGRect mainFrame;
@property(nonatomic, assign) CGRect statusFrame;
@property(nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property (nonatomic, strong) NJKWebViewProgress *webViewProgress;
@property(nonatomic, strong) WebViewJavascriptBridge* bridge;
@property(nonatomic, strong) NSMutableArray* tabUrls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:self.navigationController.leftBarButtonItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.webView];
    [self.navigationController.backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
    [self webViewProgress];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURLRequest* URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    [self.webView loadRequest:URLRequest];
    [self.bridge setWebViewDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*微信支付*/
    [self.bridge registerHandler:@"PayWX" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        //responseCallback(data);//回调数据的block方法
    }];
    
    /*支付宝支付*/
    [self.bridge registerHandler:@"PayAlipay" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        //responseCallback(data);//回调数据的block方法
    }];
}

-(void) goBack:(UIButton*)button{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- self`s method --



#pragma mark -- UIWebViewDeletage --
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
   self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString* URLString = webView.request.URL.absoluteString;
    self.navigationController.backButton.hidden = [self.tabUrls containsObject:URLString];
    NSLog(@"%@",URLString);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    if([error code] == NSURLErrorCancelled){ return; }
    NSLog(@"%@",error.description);
}

#pragma mark -- NJKWebViewProgressDelegate --
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [self.webViewProgressView setProgress:progress animated:YES];
}

#pragma mark -- getter --

-(UIWebView *)webView{
    if (_webView == nil) {
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        _webView = [[UIWebView alloc] initWithFrame:frame];
        _webView.backgroundColor = [UIColor whiteColor];
        //_webview.dataDetectorTypes=UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
        [_webView.scrollView setShowsVerticalScrollIndicator:NO];//隐藏垂直滚动条
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        [_webView didNotLeftOrRightScrollForWebView];
        [_webView clearBackColorForWebView];
    }
    return _webView;
}

-(WebViewJavascriptBridge *)bridge{
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    }
    return _bridge;
}

-(NJKWebViewProgressView *)webViewProgressView{
    if (_webViewProgressView == nil) {
        CGRect bounds = self.navigationController.navigationBar.bounds;
        CGRect frame = CGRectMake(0, bounds.size.height - 2, bounds.size.width, 2);
        _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:frame];
        _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_webViewProgressView setProgress:0 animated:YES];
    }
    return _webViewProgressView;
}

-(NJKWebViewProgress *)webViewProgress{
    if (_webViewProgress == nil) {
        _webViewProgress = [[NJKWebViewProgress alloc] init];
        self.webView.delegate = _webViewProgress;
        _webViewProgress.webViewProxyDelegate = self;
        _webViewProgress.progressDelegate = self;
    }
    return _webViewProgress;
}

-(NSMutableArray *)tabUrls{
    if (_tabUrls == nil) {
        _tabUrls = [NSMutableArray array];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/"]];
        [_tabUrls addObject:HOST];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile/glist/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile/glist"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile/lottery/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/mobile/lottery"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/cart/cartlist/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/cart/cartlist"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/user/login/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/user/login"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/home/"]];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/?/mobile/home"]];
        
//        tabUrls.add("data:text/html,chromewebdata");
//        tabUrls.add("file:///android_asset/html/error.html");
//        tabUrls.add(Constants.HOST+"/");
//        tabUrls.add(Constants.HOST);
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile/");//
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile");
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile/glist/");//
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile/glist");
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile/lottery/");//
//        tabUrls.add(Constants.HOST+"/?/mobile/mobile/lottery");
//        tabUrls.add(Constants.HOST+"/?/mobile/cart/cartlist/");//
//        tabUrls.add(Constants.HOST+"/?/mobile/cart/cartlist");
//        tabUrls.add(Constants.HOST+"/?/mobile/user/login/");//
//        tabUrls.add(Constants.HOST+"/?/mobile/user/login");
//        tabUrls.add(Constants.HOST+"/?/mobile/home/");
//        tabUrls.add(Constants.HOST+"/?/mobile/home");
    }
    return _tabUrls;
}

-(CGFloat)width{
    if (_width == 0) {
        _width = self.mainFrame.size.width;
    }
    return _width;
}

-(CGFloat)height{
    if (_height == 0) {
        _height = self.mainFrame.size.height;
    }
    return _height;
}

-(CGRect)mainFrame{
    return [[UIScreen mainScreen] bounds];
}

-(CGRect)statusFrame{
    return [[UIApplication sharedApplication] statusBarFrame];
}

@end
