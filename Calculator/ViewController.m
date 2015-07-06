//
//  ViewController.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateLabel: (NSString*) newDigit{
    self.displayLabel.text = [self.displayLabel.text stringByAppendingFormat:@"%@", newDigit];
}

- (IBAction)nineButtonAction:(id)sender {
    [self updateLabel: @"9"];
}
- (IBAction)eightButtonAction:(id)sender{
    [self updateLabel: @"8"];
}
- (IBAction)sevenButtonAction:(id)sender{
    [self updateLabel: @"7"];
}
- (IBAction)sixButtonAction:(id)sender{
    [self updateLabel: @"6"];
}
- (IBAction)fiveButtonAction:(id)sender{
    [self updateLabel: @"5"];
}
- (IBAction)fourButtonAction:(id)sender{
    [self updateLabel: @"4"];
}
- (IBAction)threeButtonAction:(id)sender{
    [self updateLabel: @"3"];
}
- (IBAction)twoButtonAction:(id)sender{
    [self updateLabel: @"2"];
}
- (IBAction)oneButtonAction:(id)sender{
    [self updateLabel: @"1"];
}
- (IBAction)zeroButtonAction:(id)sender{
    [self updateLabel: @"0"];
}
- (IBAction)decimalButtonAction:(id)sender{
    [self updateLabel: @"."];
}
- (IBAction)clearButtonAction:(id)sender {
    self.displayLabel.text = @"";
}
@end
