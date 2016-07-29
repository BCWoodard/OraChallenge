//
//  ORAChatsViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORAChatsViewController.h"

@interface ORAChatsViewController () <NSURLSessionDelegate>
@property (nonatomic, strong) NSArray *chatsArray;

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
                                                            NSLog(@"%@", jsonDictionary);
                                                        }
                                                    }];
    
    [dataTask resume];

}

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
