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
    // Do any additional setup after loading the view.
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
                                                                
                                                                
                                                                if ([jsonObject isKindOfClass:[NSArray class]]) {
                                                                    NSLog(@"its an array!");
                                                                    NSArray *jsonArray = (NSArray *)jsonObject;
                                                                    NSLog(@"jsonArray - %@",jsonArray);
                                                                }
                                                                else {
                                                                    NSLog(@"its probably a dictionary");
                                                                    NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                                                                    //NSLog(@"jsonDictionary: %@", jsonDictionary);
                                                                    NSArray *array = [jsonDictionary valueForKey:@"data"];
                                                                    NSLog(@"array: %@", array);
                                                                    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                                                        NSLog(@"Object %li", idx);
                                                                        ORAChat *chat = [[ORAChat alloc] initChatWithDictionary:obj];
                                                                        [_chatsArray addObject:chat];
                                                                        NSLog(@"_chatArray Count: %li", _chatsArray.count);
                                                                    }];
//                                                                    [jsonDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//                                                                        //ORAChat *chat = [[ORAChat alloc] initChatWithDictionary:obj];
//                                                                        NSLog(@"obj: %@", obj);
//                                                                    }];
                                                                    
                                                                    
                                                                    
                                                                    //chat.chatName = [subDictionary valueForKey:@"name"];
                                                                    //NSLog(@"CHAT NAME: %@", chat.chatName);
                                                                    //NSString *chatName = [subDictionary valueForKey:@"name"];
                                                                    //[_chatsArray addObject:chatName];
                                                                    //NSLog(@"_chatsArray: %@", _chatsArray);
                                                                }
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

#pragma mark - UITableViewDelegate


#pragma mark - Cleanup
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
