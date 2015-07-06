//
//  ViewController.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)shadeButton:(UIButton *)sender;
- (IBAction)unShadeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;



@end

