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
#import "URLSetUtil.h"

@interface ViewController ()<NJKWebViewProgressDelegate>

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGRect mainFrame;
@property(nonatomic, assign) CGRect statusFrame;
@property(nonatomic, strong) NJKWebViewProgressView *webViewProgressView;
@property(nonatomic, strong) NJKWebViewProgress *progressProxy;
@property(nonatomic, strong) WebViewJavascriptBridge* bridge;
@property(nonatomic, strong) NSMutableArray* cachaUrl;
@property(nonatomic, assign) BOOL loadingSuccess;
@property(nonatomic, strong) UIBarButtonItem* backBarButtonItem;
@property(nonatomic, strong) UIBarButtonItem* rightBarButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.webView];
    
    [self.navigationController.navigationBar addSubview:self.webViewProgressView];
    
    [WXApiManager sharedManager].delegate = [BridgeController share];
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

-(void) didBackBarItem:(UIBarButtonItem*)button{
    
    if ([self.webView canGoBack]) {
        
        [self.webView goBack];
    }
}

#pragma mark -- self`s method --

-(void)didRightBarItem:(UIBarButtonItem*)rightBarButtonItem{
    
    //[[BridgeController share] executUnifiedOrder:@{@"money":@"123"}];
    
    //[[BridgeController share] sendWxAuth];
    
    NSString* URLString = [HOST stringByAppendingString:SEARCH];
    
    NSURLRequest* URLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    [self.webView loadRequest:URLRequest];
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
    
    self.navigationItem.leftBarButtonItem = [[URLSetUtil share].URLSet containsObject:URLString] ? nil : self.backBarButtonItem;
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

-(UIBarButtonItem *)backBarButtonItem{
    
    if (_backBarButtonItem == nil) {
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"] style:UIBarButtonItemStylePlain target:self action:@selector(didBackBarItem:)];
        
       [_backBarButtonItem setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back-arrow"]]];
    }
    
    return _backBarButtonItem;
}

-(UIBarButtonItem *)rightBarButtonItem{
    
    if (_rightBarButtonItem == nil) {
        
         _rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(didRightBarItem:)];
        
        [_rightBarButtonItem setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"search"]]];

    }
    
    return _rightBarButtonItem;
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
    _cachaUrl = nil;
}

@end
