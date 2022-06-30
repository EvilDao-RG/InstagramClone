//
//  EditProfileViewController.m
//  InstagramClone
//
//  Created by Gael Rodriguez Gomez on 6/30/22.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "Post.h"

@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;
@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;


}

#pragma mark - Image selection


- (IBAction)tryCameraPicking:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
    else {
        [self errorCameraAlert];
    }
}

- (IBAction)tryGalleryPicking:(id)sender {
    self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    

    self.imagePreview.image = editedImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Saving profile picture

- (IBAction)didTapSave:(id)sender {

    if(self.imagePreview.image!=nil){
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"profilePicture"] = [self getPFFileFromImage:self.imagePreview.image];
        [self dismissViewControllerAnimated:YES completion:nil];
        [currentUser saveInBackground];
    }

    
}

-(PFFileObject *)getPFFileFromImage:(UIImage *)image{
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


#pragma mark - Alerts

-(void)errorCameraAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Camera not found" message:@"Select a photo from library instead?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    }];
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    
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
