//
//  ORALoginViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORALoginViewController.h"

@interface ORALoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)login:(UIButton *)sender;
- (IBAction)register:(UIButton *)sender;

@end

@implementation ORALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (IBAction)login:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://private-d9e5b-oracodechallenge.apiary-mock.com/users/login"];
    NSDictionary *parameters = @{@"email": _emailTextField.text,
                                 @"password": _passwordTextField.text};
    NSData *loginData = [NSJSONSerialization dataWithJSONObject:parameters
                                                        options:0
                                                          error:nil];
    // Create a POST request with our JSON as a request body.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = loginData;
    
    // Create a task.
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,
                                                                                     NSURLResponse *response,
                                                                                     NSError *error)
                                  {
                                      if (!error)
                                      {
                                          NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                          
                                      }
                                      else
                                      {
                                          NSLog(@"Error: %@", error.localizedDescription);
                                      }
                                  }];
    
    // Start the task.
    [task resume];
}

- (IBAction)register:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toRegister" sender:sender];
}


 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


#pragma mark - Cleanup
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
