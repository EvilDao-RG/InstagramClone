//
//  LoginViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

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
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
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
            [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        }
    }];
}



-(void)lookForEmptyField{
    NSString *username = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    if([username isEqual:@""] || [password isEqual:@""]){
        /*UIAlertController *alert = [UIAlertController  alertControllerWithTitle:@"Missing field" message:@"One of the fields is empty" preferredStyle:UIAlertControllerStyleAlert];
        // create a cancel action
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];

        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];*/
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
