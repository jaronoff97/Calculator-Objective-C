//
//  JACalculatorBrain.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "JACalculatorBrain.h"
#import "JAOperator.h"
#import "NSMutableArray+Stack.h"

static JACalculatorBrain* _theBrain;

@implementation JACalculatorBrain
@synthesize calculationStack;
@synthesize numberButtonColorGlobal;
@synthesize operatorButtonColorGlobal;
@synthesize specialButtonColorGlobal;
@synthesize backgroundColorGlobal;

-(void) clearArray{
    calculationStack = [[NSMutableArray alloc] init];
}
+(JACalculatorBrain*) theBrain
{
    if (_theBrain == nil){
        _theBrain = [[JACalculatorBrain alloc] init];
        _theBrain.calculationStack=[[NSMutableArray alloc] init];
    }
    return _theBrain;
}
-(NSNumber*) calculate: (NSMutableArray*) theArray{
    NSNumber* leftHandSide = nil; //construct a first number
    SEL selector = NULL;// construct a selector
    NSNumber* rightHandSide = nil; // construct a second number
    NSNumber* number=nil;
    [self printArray:calculationStack];
    NSMutableArray* sortedExpression = [self organizeExpression:theArray];
    NSLog(@"-----------------------------------------DONE ORGANIZING!-----------------------------------------------");
    NSMutableArray* stack = [[NSMutableArray alloc] init];
       for(id lastID in sortedExpression){
        if([lastID isKindOfClass:[JAOperator class]]){
            rightHandSide=(NSNumber*)[stack pop];
            leftHandSide=(NSNumber*)[stack pop];
            selector=NSSelectorFromString([lastID description]);
            
            NSLog(@"lhs: %@ sel: %@ rhs: %@",leftHandSide,NSStringFromSelector(selector),rightHandSide);
            IMP implementation = [leftHandSide methodForSelector:selector];//make an implementation (so there are no memory leaks)
            NSNumber* (*functionPointer)(id, SEL, NSNumber*);//make a function that points to the selector
            functionPointer = (NSNumber * (*)(id, SEL, NSNumber*))implementation; //implement the function
            number = functionPointer(leftHandSide, selector, rightHandSide);
            [stack push:number];
        }
        else{
            [stack push:lastID];
        }
       }
    NSLog(@"-----------------------------------------ALL DONE!-----------------------------------------------");
    
    NSNumber* toReturn = (NSNumber*)[stack peek];
    [self clearArray];
    return toReturn;//return the first number
}
-(void) sendOperator:(JAOperator*) theOperator operand:(NSNumber*) theOperand{
    if([[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperator];
        [self.calculationStack push:theOperand];
    }
    if(![[calculationStack lastObject]isKindOfClass:[NSNumber class]]){
        [self.calculationStack push:theOperand];
        [self.calculationStack push:theOperator];
    }
}
-(void) addParenthesis:(NSString *)addP{
    [self.calculationStack push:addP];
    
     }
-(NSMutableArray*) organizeExpression:(NSMutableArray *)theArray{
    NSLog(@"-----------------------------------------start!-----------------------------------------------");
    [self printArray:theArray];
    NSMutableArray* sortedQueue = [[NSMutableArray alloc] init];
    NSMutableArray* stack = [[NSMutableArray alloc] init];
    NSLog(@"-----------------------------------------init!-----------------------------------------------");
    for(int x=0;x<theArray.count;x++){
        
            if([[theArray objectAtIndex:x] isKindOfClass:[NSNumber class]]){
                [sortedQueue addObject:(NSNumber*) [theArray objectAtIndex:x]];
                NSLog(@"-----------------------------------------add to sorted queue!-----------------------------------------------");
            }
            else if([[theArray objectAtIndex:x] isKindOfClass:[NSString class]]){
                if([((NSString*)[theArray objectAtIndex:x]) isEqualToString:@"("]){
                    NSLog(@"-----------------------------------------start the cut!-----------------------------------------------");
                    NSMutableArray* toSend = [[NSMutableArray alloc] init];
                    for(int i = x+1;i<theArray.count;i++){
                        if(!([[theArray objectAtIndex:i]isKindOfClass:[NSString class]] && [[theArray objectAtIndex:i]isEqualToString:@")"])){
                            [toSend push: [theArray objectAtIndex:i]];
                        }
                        x++;
                    }
                    NSLog(@"-----------------------------------------recurse!-----------------------------------------------");
                    [sortedQueue addObjectsFromArray:[self organizeExpression:toSend]];
                }
                else if([((NSString*)[theArray objectAtIndex:x]) isEqualToString:@")"]){
                    
                    NSLog(@"-----------------------------------------return when ) found!-----------------------------------------------");
                    while(stack.count>0){
                        [sortedQueue addObject:[stack pop]];
                        NSLog(@"-----------------------------------------pop off the rest!-----------------------------------------------");
                    }
                    [self printArray:sortedQueue];
                    return sortedQueue;
                }
            }else{
                JAOperator* operator = (JAOperator*) [theArray objectAtIndex:x];
                while(stack.count!=0 && [operator precedence]<=[[stack peek] precedence]){
                    [sortedQueue addObject:[stack pop]];
                    NSLog(@"-----------------------------------------pop off stack!-----------------------------------------------");
                }
                [stack push: operator];
                NSLog(@"-----------------------------------------push operator!-----------------------------------------------");
            }
    }
    while(stack.count>0){
        [sortedQueue addObject:[stack pop]];
        NSLog(@"-----------------------------------------pop off the rest!-----------------------------------------------");
    }
    NSLog(@"-----------------------------------------return FINALLY!-----------------------------------------------");
    [self printArray:sortedQueue];
    return sortedQueue;

}
-(void) printArray:  (NSMutableArray*) theArray {
    NSLog(@"START ARRAY");
    for (id varX in theArray) {
        NSLog(@"%@", varX); // print each variable in the equation
    }
    NSLog(@"END ARRAY");
}
@end
