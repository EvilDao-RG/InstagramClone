//
//  PostCell.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/28/22.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPost:(Post *)post{
    _post = post;
    
    self.captionLabel.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
    NSURL *imageURL = [NSURL URLWithString: self.post.image.url];
    [self.image setImageWithURL:imageURL];
}


//-(NSString *)getUsernameFromAuthor:(PFUser *)author{
//    PFQuery *query = [PFQuery queryWithClassName:@"User"];
//    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"objectId" equalTo:author.objectId];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *user, NSError *error) {
//            return user[0][@"username"];
//    }];
//    
//}

@end
