//
//  JAColorVCViewController.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JAColorVCViewController.h"
#import "JACalculatorBrain.h"

JACalculatorBrain* myNewBrain;

@interface JAColorVCViewController ()

@end

@implementation JAColorVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myNewBrain = [JACalculatorBrain theBrain];
    self.customFirstColor.text=myNewBrain.numberButtonColorGlobal;
    self.customSecondColor.text=myNewBrain.operatorButtonColorGlobal;
    self.customThirdColor.text=myNewBrain.specialButtonColorGlobal;
    self.customFourthColor.text=myNewBrain.backgroundColorGlobal;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    NSLog(@"PREPPING TO SEGUE");
}
- (IBAction)committChanges:(id)sender {
    myNewBrain.numberButtonColorGlobal=self.customFirstColor.text;
    myNewBrain.operatorButtonColorGlobal=self.customSecondColor.text;
    myNewBrain.specialButtonColorGlobal=self.customThirdColor.text;
    myNewBrain.backgroundColorGlobal=self.customFourthColor.text;
    NSLog(@"VALUES SET");
}
@end
