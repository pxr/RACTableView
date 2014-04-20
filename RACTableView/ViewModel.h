//
//  ViewModel.h
//  RACTableView
//
//  Created by Paul Robinson on 2014-04-20.
//  Copyright (c) 2014 Elastic Rat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVOArrayHolder.h"

@interface ViewModel : NSObject

@property (nonatomic) KVOArrayHolder *holder;

- (void)testChanges;

@end
