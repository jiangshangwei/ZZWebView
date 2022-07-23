//
//  ViewController.m
//  ZZWeb
//
//  Created by jsw_cool on 2022/5/30.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX kScreenWidth >=375.0f && kScreenHeight >=812.0f
    
/*状态栏高度*/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kTabBarHeight (CGFloat)(kIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kTopBarSafeHeight (CGFloat)(kIs_iPhoneX?(44.0):(0))
 /*底部安全区域远离高度*/
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kTopBarDifHeight (CGFloat)(kIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

@interface ViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic, strong)WebViewJavascriptBridge *currentBridge;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"web";
    
    [self.view addSubview:self.webView];
    
    [self initialzeJSBridgeWithWebView];
        
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dalian.brightcns.cn/test/jsBridge"]]];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@" https://lzgj.test.brightcns.cn/rn/index.html"]]];
 
}

- (void)initialzeJSBridgeWithWebView {
    self.currentBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.currentBridge registerHandler:@"trustPaySign" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"%@",data);
    }];
}

- (WKWebView *)webView{
    if (!_webView) {
        //创建网页配置对象
         WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
         // 创建设置对象
         WKPreferences *preference = [[WKPreferences alloc]init];
         //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
         preference.minimumFontSize = 0;
         // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
         preference.javaScriptCanOpenWindowsAutomatically = YES;
         config.preferences = preference;
         // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
         config.allowsInlineMediaPlayback = YES;
         //设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        config.mediaTypesRequiringUserActionForPlayback = YES;
         //设置是否允许画中画技术 在特定设备上有效
         config.allowsPictureInPictureMediaPlayback = YES;
         //设置请求的User-Agent信息中应用程序名称 iOS9后可用
         config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-kNavBarAndStatusBarHeight) configuration:config];
        _webView.backgroundColor = [UIColor redColor];
    }
    return _webView;
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    if ([navigationAction.request.URL.absoluteString containsString:@"https://warmcar.com/h5/warmcardxlc"]) {
//        decisionHandler(WKNavigationActionPolicyAllow+2);
//    }else if ([LLOAuthManager canResponseForWebviewNavigationAction:navigationAction]) {
//        [LLOAuthManager decidePolicyForViewController:self webView:webView navigationAction:navigationAction decisionHandler:decisionHandler];
//    }else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)dealloc{
    NSLog(@"1231231");
}



@end
