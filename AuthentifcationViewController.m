//
//  AuthentifcationViewController.m
//  merck
//
//  Created by mac on 24/11/2016.
//  Copyright © 2016 mac. All rights reserved.
//

#import "AuthentifcationViewController.h"
#import "AFNetworking.h"
#import "User.h"
#import "UserDoc.h"
#import "UserDatabase.h"
#import "NSString+MD5.h"
#import "MBProgressHUD.h"
@import FirebaseInstanceID;
@import FirebaseMessaging;
static NSString * const BaseURLString = @"http://firstak.com/merck/web/api/logins" ;


@interface AuthentifcationViewController ()
@end

@implementation AuthentifcationViewController

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

- (IBAction)login:(id)sender {
    NSString *token = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", token);
 //   NSDictionary *parameters = @{@"email": @"dammak@gmail.com", @"password": @"e10adc3949ba59abbe56e057f20f883e"};
   User *_user = [[User alloc] init];
    if ([_emailField.text isEqualToString:@""] || [_password.text isEqualToString:@""])
    {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Login Error"
                                      message:@"Invalid username or password."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Retry"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                   
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }else{
    _user.email = _emailField.text;
      _user.password = [_password.text MD5Digest];
    
     NSDictionary *parameters = @{@"email": _emailField.text, @"password":[_password.text MD5Digest] };
    
    
       NSLog(@"user: %@", [_user dictionaryRepresentation]);
    NSURL *URL = [NSURL URLWithString:BaseURLString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
            // Set Artists and refresh result list
            if (responseObject != nil) {

                User *user = [[User alloc] initWithDictionary:responseObject[@"delegue"]];

                if (user.internalBaseClassIdentifier != 0) {
                    NSMutableArray *loadedUsers = [[NSMutableArray alloc] init];
                    
                    loadedUsers = [UserDatabase loadUserDocs];
                    
                    UserDoc *userDoc = [[UserDoc alloc] init];
                    
                    userDoc = [[UserDoc alloc] initWithDictionary:responseObject[@"delegue"] ];
                    
                    if([loadedUsers count] == 0) {
                        [userDoc saveData];
                         NSLog(@"load user : %@", userDoc.Data.email);
               
                        
                    } else {
                        UserDoc *prevUserDoc = [[UserDoc alloc] init];
                        
                        prevUserDoc = [loadedUsers objectAtIndex:0];
                        
                        [prevUserDoc deleteDoc];
                        
                        [userDoc saveData];
                        
           
                    }
                    
                    
                } else {
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Login Error"
                                                  message:@"Invalid username or password."
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* yesButton = [UIAlertAction
                                                actionWithTitle:@"Retry"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                                                {
                                                    //Handel your yes please button action here
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                  
                                                }];
                    
                    
                    [alert addAction:yesButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                
            } else {
                NSLog(@"NO USER");
            }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);

}
     ];
   
    }}
@end













