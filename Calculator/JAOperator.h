//
//  JAOperator.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/6/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JAOperator : NSObject
@property (assign) unsigned int precedence;
@property (assign) SEL operation;
-(NSString* ) description;
-(JAOperator*) initWithOperation:(SEL)anOperation precedence:(unsigned int) thePrecedence;
@end
