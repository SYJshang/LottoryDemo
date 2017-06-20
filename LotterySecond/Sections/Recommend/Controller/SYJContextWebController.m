
//
//  SYJContextWebController.m
//  LotterySecond
//
//  Created by 尚勇杰 on 2017/6/6.
//  Copyright © 2017年 尚勇杰. All rights reserved.
//

#import "SYJContextWebController.h"
#import <WebKit/WebKit.h>


@interface SYJContextWebController ()<WKNavigationDelegate,WKUIDelegate>{
    
    WKWebView *webViews;
    UIActivityIndicatorView *activityIndicatorView;
    UIView *opaqueView;
}

@end


@implementation SYJContextWebController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self setStatusBarBackgroundColor:[UIColor clearColor]];
//    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navBarTintColor = [UIColor redColor];
    self.navTintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    
    //    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor blackColor] title:@"发布" font:19.0];
    
    // 禁用 iOS7 返回手势
    
}

- (void)back{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    //    SGAlertView *alertV = [SGAlertView alertViewWithTitle:@"温馨提示" contentTitle:@"如遇到上传图片返回登录页面，请退出程序重试。" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne) didSelectedBtnIndex:^(SGAlertView *alertView, NSInteger index) {
    //
    //    }];
    //    alertV.sure_btnTitleColor = TextColor;
    //    [alertV show];
    
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    
    webViews = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, KSceenW, KSceenH - 64)];
    [webViews setUserInteractionEnabled:YES];//是否支持交互
    //[webView setDelegate:self];
    webViews.navigationDelegate = self;
    //webView.UIDelegate = self;
    
    webViews.scrollView.showsHorizontalScrollIndicator = NO;
    webViews.scrollView.bounces = NO;
    
    [webViews setOpaque:NO];//opaque是不透明的意思
    //    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [self.view addSubview:webViews];
    

    //1.创建并加载远程网页
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [webViews loadRequest:request];
        
    
    opaqueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH)];
    activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, KSceenW, KSceenH)];
    [activityIndicatorView setCenter:opaqueView.center];
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [opaqueView setBackgroundColor:[UIColor blackColor]];
    [opaqueView setAlpha:0.6];
    [self.view addSubview:opaqueView];
    [opaqueView addSubview:activityIndicatorView];
    
}



- (BOOL)prefersStatusBarHidden {
    return YES;
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = NO;
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [activityIndicatorView startAnimating];
    opaqueView.hidden = YES;
    
    self.navigationItem.titleView = [UILabel titleWithColor:[UIColor whiteColor] title:webView.title font:18.0];

    
//    self.title = [NSString stringWithFormat:@"%@",webView.title];
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 类似 UIWebView 的 -webView: shouldStartLoadWithRequest: navigationType:
    
    NSString *requestString = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    SYJLog(@"%@",requestString);
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
    if ([requestString rangeOfString:@"issueno"].location !=NSNotFound){
        
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        [self.navigationController popToRootViewControllerAnimated:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"根据国家政策，线上暂不允许售卖彩票，本彩票只提供模拟选号！" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
        
        
        
    }
    
}

// 在发送请求之前，决定是否跳转
#pragma mark - WKUIDelegate

//UIWebView如何判断 HTTP 404 等错误
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        // self.earthquakeData = [NSMutableData data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webViews loadRequest:[ NSURLRequest requestWithURL: url]];
        //        webView.navigationDelegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        
        if ([error code] == 404) {
            webViews.hidden = YES;
        }
        
    }
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
