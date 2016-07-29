//
//  ORAChatsViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORAChatsViewController.h"

@interface ORAChatsViewController () <UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>
@property (nonatomic, strong) NSArray *chatsArray;
@property (weak, nonatomic) IBOutlet UITableView *chatsTableView;

@end

@implementation ORAChatsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *url = [NSURL URLWithString:@"http://private-d9e5b-oracodechallenge.apiary-mock.com/chats?q=q&page=1&limit=20"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                                             error:&error];
                                                            _chatsArray = [NSArray arrayWithObject:[jsonDictionary objectForKey:@"data"]];
                                                            NSLog(@"%@", _chatsArray);
                                                        }
                                                    }];
    
    [dataTask resume];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    NSDictionary *chatDictionary = [_chatsArray objectAtIndex:indexPath.row];
    NSLog(@"CHAT DICT: %@", chatDictionary);
    
    cell.textLabel.text = [[_chatsArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}


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
