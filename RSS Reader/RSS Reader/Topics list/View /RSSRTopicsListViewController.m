//
//  RSSRTopicsListViewController.m
//  RSS Reader
//
//  Created by Lina Loyko on 11/17/20.
//

#import "RSSRTopicsListViewController.h"
#import "RSSRTopic.h"
#import "RSSRTopicsListPresenter.h"
#import "RSSRTopicTableViewCell.h"
#import "RSSFeedPresenter.h"
#import "UIViewController+AlertPresentable.h"

static NSString * const kReuseIdentifier = @"RSSRTopicTableViewCell";
static NSString * const kTitle = @"TUT.by News";

@interface RSSRTopicsListViewController ()

@property (nonatomic, retain) id<RSSFeedPresenter> presenter;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation RSSRTopicsListViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:kReuseIdentifier bundle:nil] forCellReuseIdentifier:kReuseIdentifier];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithPresenter:(id<RSSFeedPresenter>)presenter {
    self = [super init];
    if (self) {
        _presenter = [presenter retain];
    }
    return self;
}

- (void)dealloc {
    [_presenter release];
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupConstraints];
    
    [self.presenter attachView:self];
    
    self.title = kTitle;
    self.navigationController.title = self.title;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setHidesBarsOnSwipe:YES];

    [self.presenter loadTopics];
}

- (void)setupConstraints {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
         [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
         [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
         [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
         [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    ]];
}


#pragma mark - Status bar configuration

- (BOOL)prefersStatusBarHidden {
    return self.navigationController.navigationBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return self.navigationController.navigationBarHidden ? UIStatusBarAnimationSlide : UIStatusBarAnimationFade;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter topics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RSSRTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    [cell configureWithItem:[self.presenter topics][indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *link = [[self.presenter topics][indexPath.row] itemLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link]
                                       options:@{}
                             completionHandler:nil];
}


#pragma mark - RSSRTopicsListView Protocol

- (void)reloadData {
    [self.tableView reloadData];
}

@end




