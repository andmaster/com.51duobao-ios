//
//  ViewController.m
//  shop
//
//  Created by zhangwenqiang on 16/6/5.
//  Copyright © 2016年 ishi. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "BridgeController.h"
#import "WKWebView+Tools.h"

@interface ViewController ()

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGRect mainFrame;
@property(nonatomic, assign) CGRect statusFrame;
@property(nonatomic, strong) BridgeController * bridgeController;
@property(nonatomic, strong) WKWebViewJavascriptBridge * bridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    
    [self.view addSubview:self.webView];
    
    [WXApiManager sharedManager].delegate = self.bridgeController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)didBackBarItem:(UIBarButtonItem*)button{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

#pragma mark -- self`s method --

-(void)didRightBarItem:(UIBarButtonItem*)rightBarButtonItem{
    
    //[[BridgeController share] executUnifiedOrder:@{@"money":@"123"}];
    
    //[[BridgeController share] sendWxAuth];
    
    NSString * URLString = [HOST stringByAppendingString:SEARCH];
    
    NSURLRequest* URLRequest = URLREQUEST(URLString);
    
    [self.webView loadRequest:URLRequest];
}

#pragma mark -- getter --

-(UIBarButtonItem *)backBarButtonItem{
    
    if (_backBarButtonItem == nil) {
        
        _backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"back-arrow")
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(didBackBarItem:)];
        
        [_backBarButtonItem setTintColor:[UIColor colorWithPatternImage:IMAGE(@"back-arrow")]];
    }
    
    return _backBarButtonItem;
}

-(UIBarButtonItem *)rightBarButtonItem{
    
    if (_rightBarButtonItem == nil) {
        
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:IMAGE(@"search")
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(didRightBarItem:)];
        
        [_rightBarButtonItem setTintColor:[UIColor colorWithPatternImage:IMAGE(@"search")]];
        
    }
    
    return _rightBarButtonItem;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    
    NSLog(@"scrollViewDidScrollToTop");
}

-(WKWebView *)webView{
    
    if (_webView == nil) {
        
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        
        //_webView = [[DLPanableWebView alloc] initWithFrame:frame];
        
        _webView = [[WKWebView alloc] initWithFrame:frame];
        
        _webView.backgroundColor = [UIColor whiteColor];
        
        // _webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
        
        [_webView.scrollView setShowsVerticalScrollIndicator:NO];//隐藏垂直滚动条
        
        // [_webView didNotLeftOrRightScrollForWebView];
        
        // [_webView clearBackColorForWebView];
        
        //_webView.enablePanGesture = YES; //DLPanableWebView
        
        //滑动返回看这里
        _webView.allowsBackForwardNavigationGestures = YES;
        
        [_webView loadRequest:URLREQUEST(HOST)];
        
        [self.bridgeController registerHandler:self.bridge viewController:self];

    }
    return _webView;
}

-(BridgeController *)bridgeController{
    if (_bridgeController == nil) {
        _bridgeController = [[BridgeController alloc] init];
    }
    return _bridgeController;
}

-(WKWebViewJavascriptBridge *)bridge{
    
    if (_bridge == nil) {
        
        _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
        
        [_bridge setWebViewDelegate:[[WKWebViewDeletage alloc] initWithVC:self]];
    }
    return _bridge;
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
    
}

@end
