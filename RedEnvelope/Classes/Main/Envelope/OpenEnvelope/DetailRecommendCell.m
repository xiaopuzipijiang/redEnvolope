//
//  DetailRecommendCell.m
//  RedEnvelope
//
//  Created by 袁江 on 2018/7/16.
//  Copyright © 2018年 Envelope. All rights reserved.
//

#import "DetailRecommendCell.h"
#import <WebKit/WebKit.h>

@interface DetailRecommendCell () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        self.separatorMode = DMTableViewCellSeparatorModeNone;
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        self.webView.scrollView.contentInset = UIEdgeInsetsZero;
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        self.webView.allowsBackForwardNavigationGestures = YES;
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.scrollView.scrollEnabled = NO;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hongbao.kanqibao.com/feed"]];
        [self.webView loadRequest:request];
        
        [self.contentView addSubview:self.webView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.webView.frame = self.bounds;
    self.webView.height = self.height + 500;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if (self.delegate)
    {
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id data, NSError * _Nullable error) {
            CGFloat height = [data floatValue];
            //ps:js可以是上面所写，也可以是document.body.scrollHeight;在WKWebView中前者offsetHeight获取自己加载的html片段，高度获取是相对准确的，但是若是加载的是原网站内容，用这个获取，会不准确，改用后者之后就可以正常显示，这个情况是我尝试了很多次方法才正常显示的
            [self.delegate updateCellHeight:self height:height];
            
        }];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (webView.isLoading)
    {
        decisionHandler(WKNavigationActionPolicyAllow);
        
        return;
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:navigationAction.request.URL resolvingAgainstBaseURL:NO];
    
    if ([components.scheme isEqualToString:@"hongbao"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = 'type'"];
        NSURLQueryItem *type = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];
        
        if ([type.value containsString:@"webview"])
        {
            predicate = [NSPredicate predicateWithFormat:@"name = 'url'"];
            NSURLQueryItem *url = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];

            if (self.delegate)
            {
                [self.delegate detailRecommendCell:self navigate:url.value];
            }
        }
    }
    else
    {
        [self.delegate detailRecommendCell:self navigate:navigationAction.request.URL.absoluteString];
    }
    
    decisionHandler(WKNavigationActionPolicyCancel);
}

@end
