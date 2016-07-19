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
#import "BridgeController.h"

@interface ViewController ()<NJKWebViewProgressDelegate>

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGRect mainFrame;
@property(nonatomic, assign) CGRect statusFrame;
@property(nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property(nonatomic, strong) NJKWebViewProgress *progressProxy;
@property(nonatomic, strong) WebViewJavascriptBridge* bridge;
@property(nonatomic, strong) NSMutableArray* tabUrls;
@property(nonatomic, strong) NSMutableArray* cachaUrl;
@property(nonatomic, assign) BOOL loadingSuccess;
@property(nonatomic, strong) UIButton* payButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setLeftBarButtonItem:self.navigationController.leftBarButtonItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.webView];
    [self.navigationController.backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
    [WXApiManager sharedManager].delegate = [BridgeController share];
    //UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.payButton];
    //self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSURLRequest* URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:HOST]];
    [self.webView loadRequest:URLRequest];
    //[self registerProgressProxy];
    [[BridgeController share] registerHandler:self.bridge viewController:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

/* 加载URL精度条 */
- (void)registerProgressProxy{
    self.webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
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

-(void)pay:(UIButton*)button{
//    [[BridgeController share] executUnifiedOrder:@{@"money":@"123"}];
    [[BridgeController share] sendWxAuth];
}


#pragma mark -- UIWebViewDeletage --
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return !([request.URL.absoluteString compare:self.cachaUrl[0]] == NSOrderedSame);
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.cachaUrl replaceObjectAtIndex:0 withObject:webView.request.URL.absoluteString];
    [self loadingTitle];
    NSString* URLString = webView.request.URL.absoluteString;
    self.navigationController.backButton.hidden = [self.tabUrls containsObject:URLString];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self loadingTitle];
    if([error code] == NSURLErrorCancelled){ return; }
}

/* 加载网页上的title */
- (void)loadingTitle{
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark -- NJKWebViewProgressDelegate --
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [self loadingTitle];
    [self.webViewProgressView setProgress:progress animated:YES];
}


#pragma mark -- getter --

-(UIButton *)payButton{
    if (_payButton == nil) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(0, 0, 72, 48);
        [_payButton setTitle:@"微信支付/登录" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

-(UIWebView *)webView{
    if (_webView == nil) {
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        _webView = [[UIWebView alloc] initWithFrame:frame];
        _webView.backgroundColor = [UIColor whiteColor];
        //_webview.dataDetectorTypes=UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
        [_webView.scrollView setShowsVerticalScrollIndicator:NO];//隐藏垂直滚动条
        _webView.scalesPageToFit = YES;
        [_webView didNotLeftOrRightScrollForWebView];
        [_webView clearBackColorForWebView];
    }
    return _webView;
}

-(WebViewJavascriptBridge *)bridge{
    if (_bridge == nil) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [_bridge setWebViewDelegate:self];
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

-(NJKWebViewProgress *)progressProxy{
    if (_progressProxy == nil) {
        _progressProxy = [[NJKWebViewProgress alloc] init];
    }
    return _progressProxy;
}

-(NSMutableArray *)tabUrls{
    if (_tabUrls == nil) {
        _tabUrls = [NSMutableArray array];
        [_tabUrls addObject:HOST];
        [_tabUrls addObject:[HOST stringByAppendingString:@"/"]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",MOBILE]];
        [_tabUrls addObject:[HOST stringByAppendingString:MOBILE]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",GOODSLIST]];
        [_tabUrls addObject:[HOST stringByAppendingString:GOODSLIST]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",LOTTERY]];
        [_tabUrls addObject:[HOST stringByAppendingString:LOTTERY]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",CARTLIST]];
        [_tabUrls addObject:[HOST stringByAppendingString:CARTLIST]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",LOGINURL]];
        [_tabUrls addObject:[HOST stringByAppendingString:LOGINURL]];
        [_tabUrls addObject:[HOST stringByAppendingFormat:@"%@/",HOME]];
        [_tabUrls addObject:[HOST stringByAppendingString:HOME]];
        
//        tabUrls.add("data:text/html,chromewebdata");
//        tabUrls.add("file:///android_asset/html/error.html");
//
    }
    return _tabUrls;
}

- (NSMutableArray *)cachaUrl{
    if (_cachaUrl == nil) {
        _cachaUrl = [NSMutableArray array];
        [_cachaUrl addObject:HOST];
    }
    return _cachaUrl;
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

-(void)dealloc{
    _tabUrls = nil;
    _cachaUrl = nil;
}

@end
