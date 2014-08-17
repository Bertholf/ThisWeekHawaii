//
//  SocialViewController.m
//  ThisWeekHawaii
//
//  Created by RISONGHO on 3/12/14.
//  Copyright (c) 2014 RISONGHO. All rights reserved.
//

#import "SocialViewController.h"
#import "STTwitter.h"
#import "TwStatusCell.h"

@interface SocialViewController ()<UITableViewDelegate, UITableViewDataSource> {
    STTwitterAPI *m_twitter;
}

@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initTwitter];
    m_aryResult = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initTwitter {
    m_twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"CuSOlGijhAlFs2faVGHjXx9eh"
                                                            consumerSecret:@"IxtwY5v0VqDRZSPwPb6Dsqk9wz0KIOQNcAorv4HMBhAWbWEs1Y"];
    [self OnClickRefresh:nil];
}

- (IBAction)OnClickRefresh:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [m_twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        [m_twitter getUserTimelineWithScreenName:@"@ThisWeekHawaii"
                                  successBlock:^(NSArray *statuses) {
                                      NSLog(@"result %@", [statuses description]);
                                      m_aryResult = [NSMutableArray array];
                                      for (id status in statuses)
                                          [m_aryResult addObject:[NSMutableDictionary dictionaryWithDictionary:status]];
                                      [_m_tableview reloadData];
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  } errorBlock:^(NSError *error) {
                                      NSLog(@"error - %@", [error description]);
                                      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                  }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"error - %@", [error description]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return m_aryResult.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dicStatus = [m_aryResult objectAtIndex:indexPath.row];

    NSString *strCellId = @"CellId";
    TwStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellId];
    if (cell == nil) {
        cell = [[TwStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellId cellData:dicStatus];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        [cell setData:dicStatus];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dicStatus = [m_aryResult objectAtIndex:indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSString *strPost = [dicStatus objectForKey:@"text"];
    CGSize szPostString = CGSizeMake(_m_tableview.frame.size.width - 60, _m_tableview.frame.size.height);
    CGRect rcPostString = [strPost boundingRectWithSize:szPostString options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rcPostString.size.height + 60;
}


@end
