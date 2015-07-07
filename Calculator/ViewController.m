//
//  ViewController.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "ViewController.h"
#import "JAOperator.h"
#import "NSNumber+ArithmeticProtocol.h"

NSMutableArray* equationArray;
NSString* equation;
NSString* displayText;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    equation= @"";
    displayText=@"";
    equationArray = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) updateLabel: (NSString*) newDigit{
    equation = [equation stringByAppendingFormat:@"%@", newDigit];//add the new digit to the equation
    displayText = [displayText stringByAppendingFormat:@"%@", newDigit];//add the new digit to the onscreen NSString
    if ([newDigit rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) { //check if the onscreen NSString is a number or a operator
        if([equationArray count]==1){//if theres only one variable in the array (this happens after one calculation is completed
            JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];//construct the operator!
            [equationArray addObject: operator];// add the operator.
        }
        else{
        NSNumber* number = @([displayText intValue]);//construct the number
        [equationArray addObject: number];//add the number
        JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];//construct the operator
        [equationArray addObject: operator];//add the operator
        }
        self.displayLabel.text=@"";//no matter what clear the screen
        displayText=@"";//also clear the stored data
    }
    else{
        self.displayLabel.text=displayText;//if it wasnt an operator set the onscreen text to the stored variable
    }
    
}
-(void) printArray{
    NSLog(@"START ARRAY");
    for (id varX in equationArray) {
        NSLog(@"%@",varX);
    }
    NSLog(@"END ARRAY");
}
-(SEL) getProperSelector: (NSString*) operation{
    SEL selector = NULL;
    if([operation isEqualToString:@"+"]){
        selector = NSSelectorFromString(@"add:");
    }
    if([operation isEqualToString:@"*"]){
        selector = NSSelectorFromString(@"multiply:");
    }
    if([operation isEqualToString:@"/"]){
        selector = NSSelectorFromString(@"divide:");
    }
    if([operation isEqualToString:@"-"]){
        selector = NSSelectorFromString(@"subtract:");
    }
    return selector;
}
-(void)shadeButton:(UIButton*)sender{
    sender.selected = !sender.selected;
    if([sender.titleLabel.text isEqualToString:@"C"]){
        equation=@"";
        displayText=@"";
        [equationArray removeAllObjects];
        [self updateLabel:@""];
    }
    else if ([sender.titleLabel.text isEqualToString:@"±"]){
        if([displayText rangeOfString:@"-"].location!=NSNotFound){
            displayText = [displayText stringByReplacingOccurrencesOfString:@"-" withString:@""];
        }
        else{
            displayText = [NSString stringWithFormat:@"-%@",displayText];
        }
        [self updateLabel:@""];
    }
    else if ([sender.titleLabel.text isEqualToString:@"="]){
        NSNumber* number = @([displayText intValue]);
        [equationArray addObject: number];
        NSNumber* calculation = [self calculate];
        displayText=[NSString stringWithFormat:@"%@",calculation];
        self.displayLabel.text=displayText;
        [equationArray removeAllObjects];
        [equationArray addObject:calculation];
    }
    else{
        [self updateLabel: [NSString stringWithFormat:@"%@", sender.titleLabel.text]];
        
    }
}
-(NSNumber*) calculate{
    NSNumber* firstNum=nil;
    SEL selector = NULL;
    NSNumber* secondNum=nil;
    for (int i=0; i<[equationArray count]; i++) {
        if(i%2!=0){
            selector=NSSelectorFromString([[equationArray objectAtIndex:i] description]);
        }
        else{
            if(firstNum==nil){
                firstNum=[equationArray objectAtIndex:i];
            }
            else if(secondNum==nil){
                secondNum=[equationArray objectAtIndex:i];
            }
        }
        if(secondNum!=nil && firstNum!=nil && selector!=NULL){
            IMP implementation = [firstNum methodForSelector:selector];
            NSNumber* (*functionPointer)(id, SEL, NSNumber*);
            functionPointer = (NSNumber* (*)(id,SEL,NSNumber*))implementation;
            NSNumber* number = functionPointer(firstNum, selector, secondNum);
            firstNum=number;
            secondNum=nil;
            selector=NULL;
        }
    }
    return firstNum;
}
- (IBAction)unShadeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)showEQdown:(id)sender {
    self.displayLabel.text = equation;
}

- (IBAction)hideEQup:(id)sender {
    self.displayLabel.text=displayText;
}
@end
