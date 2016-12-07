//
//  ViewController.m
//  merck
//
//  Created by mac on 31/10/2016.
//  Copyright © 2016 mac. All rights reserved.
#import <Availability.h>

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "ViewController.h"
#import "User.h"
//#import "UserService.h"

@interface ViewController ()
@property User *user;
@end

@implementation ViewController
@synthesize email = _email;
@synthesize password = _password;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender {
  
 //   NSLog(@"get started clicked");
 //   _user = [[User alloc] init];
 //   _user.email = self.email.text.length > 0 ? self.email.text : @"";
 //   _user.password = self.password.text.length > 0 ? [NSString hashPassword:self.password.text] : @"";
//    _service = [[UserService alloc] init];
    
    
    
//    NSLog(@"user: %@", [_user dictionaryRepresentation]);
    
//    [_service authentification:[_user dictionaryRepresentation] completionBlock:^(id result, NSError *error) {
 //       if (error) {
 //           NSLog(@"Error add user %@", [error description]);
            //[alert addAction:noButton];
            
            
  //          return;
  //      } else {
            // Set Artists and refresh result list
            //User *user = [[User alloc] initWithDictionary:result];
            
  //          NSLog(@"Result add user %@", [result description]);
            
            
  //      }
  //  }];
    
    
}
@end
