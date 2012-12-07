#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

@class ScaryBugDoc;
@class DSActivityView;

@interface EditBugViewController : UIViewController<UIWebViewDelegate> {
    ScaryBugDoc *_bugDoc;
    UITextField *_location;
    UITextField *_features;
    UITextField *_progress;
    UITextField *_notes;
    UITextField *_titleField;
    UITextField *_phoneField;
    UIImageView *_imageView;
    IBOutlet UITextView *myonlytext;
    IBOutlet UIWebView *zombieweb;
     IBOutlet UIActivityIndicatorView *activityIndicator;
    UIImagePickerController *_picker;
    DSActivityView *_activityView;
    NSOperationQueue *_queue;
    IBOutlet UIScrollView *theScrollView;
    UITextField *activeTextField;
}

@property (nonatomic, assign) UITextField *activeTextField;
@property (retain) ScaryBugDoc *bugDoc;
@property (retain) IBOutlet UITextField *notes;
@property (retain) IBOutlet UITextField *titleField;
@property (retain) IBOutlet UITextField *phoneField;
@property (retain) IBOutlet UITextField *location;
@property (retain) IBOutlet UITextField *features;
@property (retain) IBOutlet UITextField *progress;
@property (retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITextView *myonlytext;

@property (retain) UIImagePickerController *picker;
@property (retain) DSActivityView *activityView;
@property (retain) NSOperationQueue *queue;

-(IBAction)callPhone:(id)sender;
- (IBAction)titleFieldValueChanged:(id)sender;
- (IBAction)phoneFieldValueChanged:(id)sender;
- (IBAction)locationFieldValueChanged:(id)sender;
- (IBAction)featuresFieldValueChanged:(id)sender;
- (IBAction)progressFieldValueChanged:(id)sender;
- (IBAction)notesFieldValueChanged:(id)sender;
- (IBAction)addPictureTapped:(id)sender;
- (IBAction)textbtn:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
