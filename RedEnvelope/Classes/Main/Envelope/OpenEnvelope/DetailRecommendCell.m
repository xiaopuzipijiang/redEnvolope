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
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UIButton *typeIcon;
//@property (nonatomic, strong) UILabel *descLabel;
//@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation DetailRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        
        self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        self.webView.scrollView.contentInset = UIEdgeInsetsZero;
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        self.webView.allowsBackForwardNavigationGestures = YES;
        self.webView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.webView];

        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hongbao.kanqibao.com/feed"]];
        [self.webView loadRequest:request];
        
        
//        self.titleLabel = [[UILabel alloc] init];
//        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//        self.titleLabel.textColor = DMMainTextColor;
//        [self.contentView addSubview:self.titleLabel];
//        self.titleLabel.text = @"点击啊链家分；阿法\nflajf;af短发";
//        self.titleLabel.numberOfLines = 2;
//
//        self.typeIcon = [[UIButton alloc] init];
//        [self.typeIcon setTitle:@"广告" forState:UIControlStateNormal];
//        self.typeIcon.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//
//        self.descLabel = [[UILabel alloc] init];
//        self.descLabel.font = [UIFont systemFontOfSize:14.0f];
//        self.descLabel.textColor = DM153GRAYCOLOR;
//        [self.contentView addSubview:self.titleLabel];
//        self.descLabel.text = @"小字典";
//
//        self.coverImageView = [[UIImageView alloc] init];
//        self.coverImageView.backgroundColor = [UIColor greenColor];
//
//        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.typeIcon];
//        [self.contentView addSubview:self.descLabel];
//        [self.contentView addSubview:self.coverImageView];
//
//        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(@-15);
//            make.top.equalTo(@10);
//            make.bottom.equalTo(@-10);
//            make.width.mas_equalTo(120);
//            make.height.mas_equalTo(70);
//        }];
//
//        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@15);
//            make.top.equalTo(@10);
//            make.right.equalTo(@-180);
//        }];
//
//        [self.typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@15);
//            make.bottom.equalTo(@-10);
//        }];
//
//        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.typeIcon.mas_right).with.offset(10);
//            make.centerY.equalTo(self.typeIcon);
//        }];

        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.webView.frame = self.bounds;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    if (self.delegate)
    {
        [self.delegate updateCellHeight:self height:self.webView.scrollView.contentSize.height];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:navigationAction.request.URL resolvingAgainstBaseURL:NO];
    
    if ([components.scheme isEqualToString:@"hongbao"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = 'type'"];
        NSURLQueryItem *type = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];
        
        if ([type.value isEqualToString:@"webview"])
        {
            predicate = [NSPredicate predicateWithFormat:@"name = 'url'"];
            NSURLQueryItem *url = (NSURLQueryItem *)[[components.queryItems filteredArrayUsingPredicate:predicate] firstObject];

            if (self.delegate)
            {
                [self.delegate detailRecommendCell:self navigate:url.value];
            }
        }
        
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
