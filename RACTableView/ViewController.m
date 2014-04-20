//
//  ViewController.m
//  RACTableView
//
//  Created by Paul Robinson on 2014-04-20.
//  Copyright (c) 2014 Elastic Rat. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ViewController ()
@property (nonatomic) ViewModel *viewModel;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _viewModel = [[ViewModel alloc] init];
    
    [self bindToViewModel];
    
    [_viewModel testChanges];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bindToViewModel {
    // We want the change info about the array changes too
    RACSignal *changeSignal = [self.viewModel rac_valuesAndChangesForKeyPath:@"holder.array" options: NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld observer:nil];
    [changeSignal subscribeNext:^(RACTuple *x){
        NSArray *wholeArray = x.first;
        NSDictionary *changeDictionary = x.second;
        
        NSLog(@"array: %@", wholeArray);
        NSLog(@"change: %@", changeDictionary);
    }];
}


@end
