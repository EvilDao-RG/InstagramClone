//
//  UserProfileViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/29/22.
//

#import "UserProfileViewController.h"
#import "Parse/Parse.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUserData];
}


-(void)setUserData{
    PFUser *currentUser = [PFUser currentUser];
    self.usernameLabel.text = currentUser.username;
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
