//
//  PostCell.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/28/22.
//

#import "PostCell.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "NSDate+DateTools.h"


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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    //NSDate *date = [dateFormatter stringFromDate:self.post.createdAt];
    self.dateLabel.text = self.post.createdAt.shortTimeAgoSinceNow;
    
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
