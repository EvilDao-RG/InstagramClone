//
//  UserProfileViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/29/22.
//

#import "UserProfileViewController.h"
#import "Parse/Parse.h"
#import "UserProfilePostCell.h"
#import "Post.h"
#import "PostDetailsViewController.h"

@interface UserProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionViewLayout;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self setUserData];
    [self fetchUserPosts];
}


#pragma mark - Fetching data

-(void)setUserData{
    PFUser *currentUser = [PFUser currentUser];
    self.usernameLabel.text = currentUser.username;
}


-(void)fetchUserPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if(posts != nil){
            self.userPosts = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


#pragma mark - Collection view methods

// Assigns the numer of items in the collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.userPosts.count;
}

// Assigns the content of the cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UserProfilePostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfilePostCell" forIndexPath:indexPath];
    [cell setPost:self.userPosts[indexPath.item]];
    return cell;
}

//Changing collectio view flow layout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    self.collectionViewLayout.minimumLineSpacing = 0;
    self.collectionViewLayout.minimumInteritemSpacing = 0;
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat width = screenSize.width;
    CGFloat cellSize = width/3;
    CGSize size = CGSizeMake(cellSize, cellSize);
    return size;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BOOL isDetailSegue = [segue.identifier isEqualToString:@"ProfileToDetailSegue"];
    NSLog(@"%d", isDetailSegue);
    if(isDetailSegue){
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];

        PostDetailsViewController *postDetailsViewController = [segue destinationViewController];
        postDetailsViewController.post = self.userPosts[indexPath.row];
        
    }
}

@end
