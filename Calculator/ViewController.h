//
//  ViewController.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)nineButtonAction:(id)sender;
- (IBAction)eightButtonAction:(id)sender;
- (IBAction)sevenButtonAction:(id)sender;
- (IBAction)sixButtonAction:(id)sender;
- (IBAction)fiveButtonAction:(id)sender;
- (IBAction)fourButtonAction:(id)sender;
- (IBAction)threeButtonAction:(id)sender;
- (IBAction)twoButtonAction:(id)sender;
- (IBAction)oneButtonAction:(id)sender;
- (IBAction)zeroButtonAction:(id)sender;
- (IBAction)decimalButtonAction:(id)sender;
- (IBAction)clearButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;



@end

