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
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *dataArray;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    _viewModel = [[ViewModel alloc] init];
    
    [self bindToViewModel];
    
    [self setupTableView];
    
    [_viewModel testChanges];
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)bindToViewModel {
    // We want the change info about the array changes too
    RACSignal *changeSignal = [self.viewModel rac_valuesAndChangesForKeyPath:@"holder.array" options: NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld observer:nil];
    [changeSignal subscribeNext:^(RACTuple *x){
        self.dataArray = x.first;
        NSDictionary *changeDictionary = x.second;
        
        NSLog(@"change: %@", changeDictionary);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}


@end
