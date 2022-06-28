//
//  Post.h
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/27/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
+ (void)postImage:(UIImage *)image withCaption:(NSString *)caption withCompletion:(PFBooleanResultBlock  _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
