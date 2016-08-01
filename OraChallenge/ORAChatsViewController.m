//
//  ORAChatsViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORAChatsViewController.h"
#import "ORAChat.h"
#import "ORAChatsListViewCell.h"

@interface ORAChatsViewController () <UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>
@property (nonatomic, strong) NSMutableArray *chatsArray;
@property (weak, nonatomic) IBOutlet UITableView *chatsTableView;

@end

@implementation ORAChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chatsArray = [[NSMutableArray alloc] init];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://private-d9e5b-oracodechallenge.apiary-mock.com/chats?q=q&page=1&limit=20"];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if(error == nil)
                                                            {
                                                                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:kNilOptions
                                                                                                                  error:&error];
                                                                NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                                                                NSArray *chatsArray = [jsonDictionary valueForKey:@"data"];
                                                                [chatsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                    // Enumerate and create chat object then add to _chatsArray
                                                                    ORAChat *chat = [[ORAChat alloc] initChatWithDictionary:obj];
                                                                    [_chatsArray addObject:chat];
                                                                }];
                                                            }
                                                        }];
        
        [dataTask resume];        
    });
    
    _chatsTableView.rowHeight = UITableViewAutomaticDimension;
    _chatsTableView.estimatedRowHeight = 100.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.chatsTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chatsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    
    ORAChatsListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    ORAChat *chat = [_chatsArray objectAtIndex:indexPath.row];
    cell.chatCreatedLabel.text = chat.chatStartDate;
    cell.chatOwnerLabel.text = [NSString stringWithFormat:@"%@ by %@", chat.chatName, chat.chatOwner];
    cell.latestMsgOwnerLabel.text = [NSString stringWithFormat:@"%@ - %@", chat.chatLastMsgOwner, chat.chatLastMsgDate];
    cell.messageLabel.text = chat.chatLastMsg;
    return cell;
}


#pragma mark - Cleanup
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
