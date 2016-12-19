//
//  WebViewController.m
//  BasicFramework
//
//  Created by mr-tech on 16/11/1.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>{
    UIWebView * myWebView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self v1];
    [self v2];
}
//页面跳转了以后，停止载入
- (void)viewWillDisappear:(BOOL)animated {
    if (myWebView.isLoading) {
        [myWebView stopLoading];
    }
    myWebView.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)v2{
    myWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    NSError *error;
    NSString *errorString = [NSString stringWithFormat:@"<html><center><font size=+5 color='red'>AnError Occurred;<br>%@</font></center></html>",error];
    [myWebView loadHTMLString:errorString baseURL:nil];
    [self.view addSubview:myWebView];

}
-(void)v1{
    //利用UIWebView显示pdf文件，网页
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [webView setAllowsInlineMediaPlayback:YES];
    [self.view addSubview:webView];
    
    NSString *pdfPath = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:pdfPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:5];
    [webView loadRequest:request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
