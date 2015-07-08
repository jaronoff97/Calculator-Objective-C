//
//  JACalculatorBrain.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JACalculatorBrain.h"
#import "JAOperator.h"

static JACalculatorBrain* _theBrain;

@implementation JACalculatorBrain
@synthesize calculationStack;
@synthesize numberButtonColorGlobal;
@synthesize operatorButtonColorGlobal;
@synthesize specialButtonColorGlobal;
@synthesize backgroundColorGlobal;

-(void) initializeArray{
    calculationStack = [NSMutableArray array];
}
+(JACalculatorBrain*) theBrain
{
    if (_theBrain == nil){
        _theBrain = [[JACalculatorBrain alloc] init];
        [_theBrain initializeArray];
    }
    return _theBrain;
}
-(NSNumber*) calculate {
    [self printArray];
    NSNumber* firstNum = nil; //construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* secondNum = nil; // construct a second number
    for (int i = 0; i < [calculationStack count]; i++) {
        if (i % 2 != 0) {
            selector = NSSelectorFromString([[calculationStack objectAtIndex:i] description]); //if the for loop is at the odd intervals remake the proper selector
        }
        else {
            if (firstNum == nil) {
                firstNum = [calculationStack objectAtIndex:i]; //if the firstnum doesnt exist make it.
            }
            else if (secondNum == nil) {
                secondNum = [calculationStack objectAtIndex:i]; // same for the second num
            }
        }
        if (secondNum != nil && firstNum != nil && selector != NULL) { // once the three variables are filled
            IMP implementation = [firstNum methodForSelector:selector];//make an implementation (so there are no memory leaks)
            NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
            functionPointer = (NSNumber * (*)(id, SEL, NSNumber*))implementation; //implement the function
            NSNumber* number = functionPointer(firstNum, selector, secondNum);//use the function
            firstNum = number; //set the first number as the answer
            secondNum = nil; // reset the second number
            selector = NULL; //reset the selector
        }
    }
    return firstNum;//return the first number
}
-(NSMutableArray*) organize{
    
    for(int i=0;i<[calculationStack count];i++){
        if([[calculationStack objectAtIndex:i]isKindOfClass:[JAOperator class]]){
            
        }
    }
    
    
    return calculationStack;
}
-(void) printArray {
    NSLog(@"START ARRAY");
    for (id varX in calculationStack) {
        NSLog(@"%@", varX); // print each variable in the equation
    }
    NSLog(@"END ARRAY");
}
@end
