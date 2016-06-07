//
//  ViewController.m
//  myCoreLocation
//
//  Created by 马悦 on 16/6/6.
//  Copyright © 2016年 马悦. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化定位器
    self.manager = [[CLLocationManager alloc] init];
    [self.manager requestWhenInUseAuthorization];//请求定位的授权
    //设置代理
    self.manager.delegate = self;
    //设置精确度,精确度越高，用电越多，要根据实际情况选择
    [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
    //设置定位信息的更新距离,即在地图上每隔250m更新一次定位信息
    self.manager.distanceFilter = 10.0;
}
- (void)viewDidAppear:(BOOL)animated
{
    //启动定位管理器
    [self.manager startUpdatingLocation];
}
- (void)viewDidDisappear:(BOOL)animated
{
    //关闭定位功能,以节约用电
    [self.manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%f",location.coordinate.latitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSLog(@"%@",[placemarks lastObject]);
    }];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
