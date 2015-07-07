//
//  JAColorVCViewController.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JAColorVCViewController.h"
#import "ViewController.h"

@interface JAColorVCViewController ()

@end

@implementation JAColorVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *destinationViewController = [segue destinationViewController];
    JAColorVCViewController *sourceViewController = [[JAColorVCViewController alloc] init];
    
    UIColor *color1 = [self colorFromHexString:sourceViewController.customFirstColor.text];
    UIColor *color2 = [self colorFromHexString:sourceViewController.customSecondColor.text];
    UIColor *color3 = [self colorFromHexString:sourceViewController.customThirdColor.text];
    [destinationViewController setButtonColor: color1: color2: color3];
    [destinationViewController ]
    
    
}
@end
