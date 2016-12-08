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
#import "ProfileViewController.h"
#import "ServerConnection.h"
static NSString * const BaseURLString = @"http://firstak.com/merck/web/api/logins" ;


@interface AuthentifcationViewController ()
@end

@implementation AuthentifcationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailField.text = @"mehdi@mehdi.com";
    self.password.text = @"mehdi";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.00 green:0.40 blue:0.71 alpha:1.0];
    self.loginBtn.backgroundColor = [UIColor colorWithRed:0.64 green:0.80 blue:0.25 alpha:1.0];
    
    
    self.emailField.backgroundColor = [UIColor clearColor];
    self.emailField.borderStyle = UITextBorderStyleNone;
    
    CALayer *emailBorder = [CALayer layer];
    CALayer *pwdBorder = [CALayer layer];

    CGFloat borderWidth = 1;
    
    emailBorder.borderColor = [UIColor whiteColor].CGColor;
    emailBorder.frame = CGRectMake(0,self.emailField.frame.size.height - borderWidth, self.emailField.frame.size.width,self.emailField.frame.size.height);
    emailBorder.borderWidth = borderWidth;
    [self.emailField.layer addSublayer:emailBorder];
    self.emailField.layer.masksToBounds=YES;
    self. emailField.leftViewMode = UITextFieldViewModeAlways;
    self. emailField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yourImagename.png"]];
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.emailField.attributedPlaceholder = str;
    
    self.password.backgroundColor = [UIColor clearColor];
    self.password.borderStyle = UITextBorderStyleNone;
    
    pwdBorder.borderColor = [UIColor whiteColor].CGColor;
    pwdBorder.frame = CGRectMake(0,self.password.frame.size.height - borderWidth, self.password.frame.size.width,self.password.frame.size.height);
    pwdBorder.borderWidth = borderWidth;
    [self.password.layer addSublayer:pwdBorder];
    self.password.layer.masksToBounds=YES;
    
    
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    self.forgetPwd.attributedText = [[NSAttributedString alloc] initWithString:@"Mot de passe publié" attributes:underlineAttribute];
    self.forgetPwd.textColor = [UIColor whiteColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    NSLog(@"get started clicked");
    
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
        ServerConnection *service = [[ServerConnection alloc] init];
        
     //   NSURL *URL = [NSURL URLWithString:BaseURLString];
       // AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [service addUserWithDictionary:parameters completionBlock:^(id responseObject, NSError *error) {
            //   [manager POST:URL.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
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
                    
                    UIStoryboard *storyboard =
                    [UIStoryboard storyboardWithName:@"Main"
                                              bundle:[NSBundle mainBundle]];
                                                
                    UIViewController *profile = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
                    [[self navigationController] pushViewController:profile animated:YES];
                    
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
            
        }// failure:^(NSURLSessionTask *operation, NSError *error) {
          //  NSLog(@"Error: %@", error);
            
      //  }
         ];
        
    }}
@end













