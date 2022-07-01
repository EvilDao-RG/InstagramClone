//
//  LoginViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    [self lookForEmptyField];
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            [self alertUser:@"credentials"];
        } else {
            [self goHome];
        }
    }];

}


- (IBAction)didTapSignup:(id)sender {
    PFUser *newUser = [PFUser user];
    
    newUser.username=self.emailField.text;
    newUser.password=self.passwordField.text;
    
    [self lookForEmptyField];

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            [self alertUser:@"credentials"];
        } else {
            [self goHome];
        }
    }];
}


-(void)goHome{
//    [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
    SceneDelegate *delegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    delegate.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"AppTabController"];
}


-(void)lookForEmptyField{
    NSString *username = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    if([username isEqual:@""] || [password isEqual:@""]){
        [self alertUser:@"empty"];
    }
}


-(void)alertUser:(NSString *)reason{
    UIAlertController *alert = [[UIAlertController alloc]init];
    if([reason isEqualToString:@"empty"]){
        [alert setTitle:@"Empty field"];
        [alert setMessage:@"At least one of the fields is empty"];
    } else {
        [alert setTitle:@"Invalid credentials"];
        [alert setMessage:@"Your email or password is incorrect"];
    }
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
