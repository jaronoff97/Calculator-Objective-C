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
    equation = [equation stringByAppendingFormat:@"%@", newDigit];
    displayText = [displayText stringByAppendingFormat:@"%@", newDigit];
    if ([newDigit rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location != NSNotFound) {
        if([equationArray count]==1){
            JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];
            [equationArray addObject: operator];
        }
        else{
        NSNumber* number = @([displayText intValue]);
        [equationArray addObject: number];
        JAOperator* operator = [[JAOperator alloc] initWithOperation:[self getProperSelector: newDigit] precedence:0];
        [equationArray addObject: operator];
        }
        self.displayLabel.text=@"";
        displayText=@"";
    }
    else{
        self.displayLabel.text=displayText;
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
        
    }
    else if ([sender.titleLabel.text isEqualToString:@"="]){
        NSNumber* number = @([displayText intValue]);
        [equationArray addObject: number];
        NSNumber* calculation = [self calculate];
        self.displayLabel.text=[NSString stringWithFormat:@"%@",calculation];
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
            NSNumber* number = [firstNum performSelector:selector withObject: secondNum];
            NSLog(@"%@ ======== NUMBER",number);
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
