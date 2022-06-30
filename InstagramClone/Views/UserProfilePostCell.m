//
//  UserProfilePostCell.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/29/22.
//

#import "UserProfilePostCell.h"
#import "UIImageView+AFNetworking.h"

@implementation UserProfilePostCell

-(void)setPost:(Post *)post{
    _post = post;
    
    NSURL *imageURL = [NSURL URLWithString: self.post.image.url];

    [self.postImage setImageWithURL:imageURL];
}

@end
