//
//  WebViewController.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/27.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *url;
@end

@implementation WebViewController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    
    self.url = url;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载中...";
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];

    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    self.webView.scrollView.contentInset = UIEdgeInsetsZero;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.webView.allowsBackForwardNavigationGestures = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self loadUrl:self.url];
    
    [self.view addSubview:self.webView];
}

- (void)loadUrl:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = self.view.bounds;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    self.title = self.webView.title;
}

@end
