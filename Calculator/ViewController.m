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
    
}
-(void)shadeButton:(UIButton*)sender{
    sender.selected = !sender.selected;
    if([sender.titleLabel.text isEqualToString:@"C"]){
        self.displayLabel.text=@"";
    }
    else{
        [self updateLabel: [NSString stringWithFormat:@"%@", sender.titleLabel.text]];

    }
}

- (IBAction)unShadeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}
@end
