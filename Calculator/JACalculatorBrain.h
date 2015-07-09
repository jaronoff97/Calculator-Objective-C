//
//  JACalculatorBrain.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/7/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JAOperator;

@interface JACalculatorBrain : NSObject
@property (strong, nonatomic) NSMutableArray* calculationStack;
@property (nonatomic, retain) NSString* numberButtonColorGlobal;
@property (nonatomic, retain) NSString* operatorButtonColorGlobal;
@property (nonatomic, retain) NSString* specialButtonColorGlobal;
@property (nonatomic, retain) NSString* backgroundColorGlobal;
-(NSNumber*) calculate: (NSNumber*) lastOperand;
+(JACalculatorBrain*) theBrain;
-(void) sendOperator:(JAOperator*) theOperator operand:(NSNumber*) theOperand;
-(NSNumber*) solveExpression: (NSMutableArray*) theArray;
-(void) printArray: (NSMutableArray*) theArray;
-(void) clearArray;
@end
