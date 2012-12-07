//
//  Settings.h
//  Zombie Alert
//
//  Created by Robert Greene on 7/28/12.
//
//

#import <UIKit/UIKit.h>
#import "APICallsViewController.h"
#import "FBConnect.h"

@interface Settings : UIViewController <FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate, UIAlertViewDelegate>{
    int helping;
  NSArray *permissions;
    IBOutlet UISwitch *fbsw;
    IBOutlet UISwitch *tbsw;
    IBOutlet UISwitch *twsw;
   APICallsViewController *pendingApiCallsController;
  IBOutlet UIImageView *profilePhotoImageView;
    IBOutlet UILabel *fblable;
    IBOutlet UILabel *twlable;
    IBOutlet UILabel *tblable;
    IBOutlet UIImageView *twitterpicview;
    IBOutlet UIImageView *tumblrpicview;
    IBOutlet UIActivityIndicatorView *facebookactive;
    IBOutlet UIActivityIndicatorView *twitteractive;
    IBOutlet UIActivityIndicatorView *tumblractive;
}
-(void)facebookfix;
-(void)fbmachine;
-(void)twittermachine;
-(IBAction)done:(id)sender;
@end
