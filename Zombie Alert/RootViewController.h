#import <UIKit/UIKit.h>
#import "APICallsViewController.h"
#import <MessageUI/MessageUI.h>
@class EditBugViewController;
@class FourthViewController;

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate> {
    NSMutableArray *_bugs;
    EditBugViewController *_editBugViewController;
    IBOutlet UITableView *tblSimpleTable;
    UINavigationController *navigationController;
    UIToolbar *toolbar;
    FourthViewController *ivControllerToolbar;
    FourthViewController *ivControllerCell;
    UITableView *mytable;
    NSArray *tbarray;
    ///this is for the good stuff ho
    APICallsViewController *apistuff;
}
- (void)loadImage;

@property (retain) NSMutableArray *bugs;
@property(nonatomic, retain) EditBugViewController *editBugViewController;
@property(nonatomic, retain) IBOutlet UITableView *mytable;
- (void)donetapped:(id)sender;
//- (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize;
@end
