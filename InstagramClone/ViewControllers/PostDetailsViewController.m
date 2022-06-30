//
//  PostDetailsViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/29/22.
//

#import "PostDetailsViewController.h"
#import "Parse/PFImageView.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameTopLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorProfilePicture;

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPost:self.post];
}

-(void)setPost:(Post *)post{
    _post = post;
    
    self.captionLabel.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
    self.usernameTopLabel.text = self.post.author.username;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.post.createdAt];
    
    if(self.post.author[@"profilePicture"]){
        PFFileObject *image = self.post.author[@"profilePicture"];
        NSURL *profilePictureUrl = [NSURL URLWithString:image.url];
        [self.authorProfilePicture setImageWithURL:profilePictureUrl];
    }
    
    NSURL *imageURL = [NSURL URLWithString: self.post.image.url];
    [self.imageView setImageWithURL:imageURL];
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
