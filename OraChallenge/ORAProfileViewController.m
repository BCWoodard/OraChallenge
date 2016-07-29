//
//  ORAProfileViewController.m
//  OraChallenge
//
//  Created by Brad Woodard on 7/29/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import "ORAProfileViewController.h"

@interface ORAProfileViewController () <NSURLSessionDelegate>
- (IBAction)cancelProfileUpdate:(UIButton *)sender;
- (IBAction)updateProfile:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation ORAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://private-d9e5b-oracodechallenge.apiary-mock.com/users/me"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];

    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:url
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                                             error:&error];
                                                            _nameTextField.text = [[jsonDictionary objectForKey:@"data"] valueForKey:@"name"];
                                                            _emailTextField.text = [[jsonDictionary objectForKey:@"data"] valueForKey:@"email"];
                                                        }
                                                        
                                                    }];
    
    [dataTask resume];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBActions
- (IBAction)cancelProfileUpdate:(UIButton *)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    [self.view endEditing:YES];
}

- (IBAction)updateProfile:(UIButton *)sender {
    NSLog(@"UPDATE");
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


#pragma mark - Helper Functions
- (void)keyboardWillShow {
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0.0f, -140.0f, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
