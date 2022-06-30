//
//  UserProfilePostCell.h
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserProfilePostCell : UICollectionViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@end

NS_ASSUME_NONNULL_END
