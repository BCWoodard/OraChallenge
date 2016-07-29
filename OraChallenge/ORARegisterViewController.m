//
//  ORARegisterViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORARegisterViewController.h"

@interface ORARegisterViewController ()
- (IBAction)cancelRegister:(UIButton *)sender;
- (IBAction)register:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation ORARegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)cancelRegister:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)register:(UIButton *)sender {
    if ([_emailTextField.text isEqualToString:_confirmPasswordTextField.text]) {
        NSURL *url = [NSURL URLWithString:@"http://private-d9e5b-oracodechallenge.apiary-mock.com/users/register"];
        NSDictionary *parameters = @{@"name": _nameTextField.text,
                                     @"email": _emailTextField.text,
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
                                              [self dismissViewControllerAnimated:YES completion:nil];
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"Error: %@", error.localizedDescription);
                                          }
                                      }];
        
        // Start the task.
        [task resume];
    } else {
        NSLog(@"PASSWORDS DON'T MATCH");
    }

}
@end
