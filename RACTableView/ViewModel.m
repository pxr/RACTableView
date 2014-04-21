//
//  ViewModel.m
//  RACTableView
//
//  Created by Paul Robinson on 2014-04-20.
//  Copyright (c) 2014 Elastic Rat. All rights reserved.
//

#import "ViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewModel ()
@property (nonatomic) RACCommand *addItemCommand;
@end

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

- (RACCommand*) addItemCommand {
    if (!_addItemCommand) {
        _addItemCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            [self.holder addDataObject:@"item"];
            return [RACSignal empty];
        }];
    }
    return _addItemCommand;
}

@end
