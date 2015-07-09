//
//  NSMutableArray+Stack.h
//  Calculator
//
//  Created by Jacob Aronoff on 7/8/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)
-(id) pop;
-(void) push: (id) object;
-(id) peek;
-(id) dequeue;
-(void) insertAtZero: (id) object;
@end
