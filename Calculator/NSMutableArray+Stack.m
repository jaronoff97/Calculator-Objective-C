//
//  NSMutableArray+Stack.m
//  Calculator
//
//  Created by Jacob Aronoff on 7/8/15.
//  Copyright (c) 2015 Jacob Aronoff. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)
-(id) pop{
    id obj = nil;
    if(self.count > 0)
    {
        obj = [self lastObject];
        [self removeLastObject];
    }
    return obj;
}
-(void) push: (id) object{
    [self addObject:object];
}
-(id) peek{
    id obj = nil;
    if(self.count > 0)
    {
        obj = [self lastObject];
    }
    return obj;
}
@end
