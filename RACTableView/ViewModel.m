//
//  ViewModel.m
//  RACTableView
//
//  Created by Paul Robinson on 2014-04-20.
//  Copyright (c) 2014 Elastic Rat. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _holder = [[KVOArrayHolder alloc] init];
    return self;
}

- (void)testChanges {
    [self.holder addDataObject:@"one"];
    [self.holder addDataObject:@"two"];
    [self.holder addDataObject:@"three"];
}
@end
