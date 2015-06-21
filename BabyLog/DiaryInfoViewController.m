//
//  DiaryInfoViewController.m
//  BabyLog
//
//  Created by jiangbin on 15/6/7.
//  Copyright (c) 2015年 张弘. All rights reserved.
//

#import "DiaryInfoViewController.h"
#import "ConstantDefine.h"

@interface DiaryInfoViewController ()

@end

@implementation DiaryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    CGFloat imgwidth = self.scrollView.frame.size.width;
    CGFloat imgheight = self.scrollView.frame.size.height;
    for (int i = 0; i < self.picList.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(i * imgwidth, 0, imgwidth, imgheight);
        NSString *rurl = [[self.picList objectAtIndex:i] stringByReplacingOccurrencesOfString:@"~/" withString:HTTP_HEADER];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:rurl]];
        imgView.image = [UIImage imageWithData:data];
        [self.scrollView addSubview:imgView];

    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.picList.count * imgwidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

 - (void)nextImage
 {
     int page = (int)self.pageControl.currentPage;
     if (page == self.picList.count)
     {
         page = 0;
     }
     else
     {
         page++;
     }
 
     CGFloat x = page * self.scrollView.frame.size.width;
     self.scrollView.contentOffset = CGPointMake(x, 0);
 }

- (void)rightSwipe
{
    [self nextImage];
}

- (void)leftSwipe
{
    [self prevImage];
}

- (void)prevImage
{
    int page = (int)self.pageControl.currentPage;
    if (page == 0)
    {
        page = (int)self.picList.count;
    }
    else
    {
        page--;
    }
    
    CGFloat x = page * self.scrollView.frame.size.width;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
     CGFloat scrollViewWidth = self.scrollView.frame.size.width;
     CGFloat x = self.scrollView.contentOffset.x;
     int page = (x + scrollViewWidth / 2) /  scrollViewWidth;
     self.pageControl.currentPage = page;
 }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
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
