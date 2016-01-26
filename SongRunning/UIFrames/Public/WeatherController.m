//
//  WeatherController.m
//  LetUsGo
//
//  Created by 韩俊强 on 15/11/8.
//  Copyright (c) 2015年 jinngwei. All rights reserved.
//

#import "WeatherController.h"

@interface WeatherController ()<UIWebViewDelegate>
@property (nonatomic,retain)UIWebView *webView;
@end

@implementation WeatherController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"天气";
        self.webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-48, 0, -200, 0);
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
        self.webView.scalesPageToFit = YES;
        NSURL *url=[NSURL URLWithString:self.urlString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self.view addSubview:self.webView];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = WEIBOColor(255, 145, 181);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Back@2x"] style:(UIBarButtonItemStylePlain) target:self action:@selector(handleBack:)];
}

- (void)handleBack:(UIBarButtonItem *)item{
    if ([self.webView canGoBack]) {
            [self.webView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
