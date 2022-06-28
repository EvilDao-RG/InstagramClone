//
//  Post.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic author;
@dynamic caption;
@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void)postImage:(UIImage *)image withCaption:(NSString *)caption withCompletion:(void (^)(BOOL succeeded, NSError * error)) completion{
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error!=nil){
            completion(false, error);
        } else {
            completion(true, nil);
        }
    }];
}

+ (PFFileObject *)getPFFileFromImage:(UIImage *)image{
    if(!image){
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
