//
//  ZYCWebViewController.m
//  百思不得姐
//
//  Created by zhou on 16/1/23.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZYCWebViewController.h"
#import <WebKit/WebKit.h>

@interface ZYCWebViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIView *htmlView;

@property (nonatomic,weak) WKWebView *webView;
@end

@implementation ZYCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [_htmlView addSubview:webView];

    //加载网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    [webView loadRequest:request];
    
    // Observer;观察者
    // KeyPath:观察哪个属性
    // options:观察新值
    // KVO:监听属性
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条,监听进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _webView.frame = _htmlView.bounds;
}

#pragma mark - 对象被销毁
- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

// 观察的属性有新值的时候就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    _backItem.enabled = _webView.canGoBack;
    _forwardItem.enabled = _webView.canGoForward;
    _progressView.progress = _webView.estimatedProgress;
    
    _progressView.progress = _webView.estimatedProgress >= 1;
    self.title = _webView.title;
}

#pragma mark - 事件处理
- (IBAction)back:(id)sender {
    [_webView goBack];
}
- (IBAction)forward:(id)sender {
    [_webView goForward];
}
- (IBAction)reload:(id)sender {
    [_webView reload];
}

@end
