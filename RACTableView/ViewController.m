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
    NSLog(@"ViewController init");
    self = [super init];
    if (!self) return nil;
    
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    _viewModel = [[ViewModel alloc] init];
    
    [self bindToViewModel];
    

}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"viewDidAppear");
    [self setupTableView];
    [self setupNavBarButtons];
    
    [_viewModel testChanges];
    
}
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)setupNavBarButtons {
    
    assert(self.navigationController);
    
    UIBarButtonItem *addActionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    addActionButton.rac_command = self.viewModel.addItemCommand;
	self.navigationItem.leftBarButtonItem = addActionButton;
    
    UIBarButtonItem *deleteActionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(addAction:)];
	self.navigationItem.rightBarButtonItem = deleteActionButton;
}

- (void)addAction:(id)sender {
    
}

- (void)bindToViewModel {
    // We want the change info about the array changes too
    RACSignal *changeSignal = [self.viewModel rac_valuesAndChangesForKeyPath:@"holder.array" options: NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld observer:nil];
    [changeSignal subscribeNext:^(RACTuple *x){
        self.dataArray = x.first;
        NSDictionary *changeDictionary = x.second;
        NSIndexSet *indexSet = changeDictionary[@"indexes"];
        
        NSLog(@"change count: %d", [indexSet count]);
        [self.tableView beginUpdates];
          NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexSet.firstIndex inSection:0];
          [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
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
