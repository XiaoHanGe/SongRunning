//
//  Photo.h
//  SuperPhotoAlbum
//
//  Created by 韩俊强 on 15/6/13.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Photo : UIViewController <UIScrollViewDelegate>

@property (nonatomic ,assign) NSInteger contentStr;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIScrollView *scrollView1;
@property (nonatomic ,strong) NSMutableArray *travelArray;
@property (nonatomic ,copy)NSString *title;
@end
