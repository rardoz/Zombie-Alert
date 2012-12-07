#import "EditBugViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"



@implementation EditBugViewController
@synthesize activeTextField;
@synthesize bugDoc = _bugDoc;
@synthesize titleField = _titleField;
@synthesize imageView = _imageView;
@synthesize myonlytext;

@synthesize picker = _picker;
@synthesize activityView = _activityView;
@synthesize queue = _queue;
@synthesize phoneField = _phoneField;
@synthesize location = _location;
@synthesize features = _features;
@synthesize progress = _progress;
@synthesize notes = _notes;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
       
    self.queue = [[[NSOperationQueue alloc] init] autorelease];
  
    
}
-(IBAction)callPhone:(id)sender {
     UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _phoneField.text]];
   	[app openURL:url];
    
	
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			NSLog(@"Didn't Work");
			break;
		case MessageComposeResultSent:
            NSLog(@"It was sent");
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)textbtn:(id)sender{
   
        [myonlytext selectAll:self];
    
   
        [myonlytext copy:self];
        
    


         
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    self.picker = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [theScrollView release];
    theScrollView = nil;

    
    self.location = nil;
    self.features = nil;
    self.progress = nil;
    self.notes = nil;
    self.phoneField = nil;
    self.titleField = nil;
    self.imageView = nil;
  

    self.queue = nil;
}


- (void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [theScrollView release];
    [zombieweb release];
    [myonlytext release];
    [_bugDoc release];
    _bugDoc = nil;
    [_titleField release];
    _titleField = nil;
    
    [_location release];
    _location = nil;
    [_features release];
    _features = nil;
    [_progress release];
    _progress = nil;
    [_notes release];
    _notes = nil;
    
    [_phoneField release];
    _phoneField = nil;
    [_imageView release];
    _imageView = nil;


    [_queue release];
    _queue = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated { 
    _location.text = _bugDoc.data.location;
    _features.text = _bugDoc.data.features;
    _progress.text = _bugDoc.data.progress;
    _notes.text = _bugDoc.data.notes;
    
    _phoneField.text = _bugDoc.data.phone;
    _titleField.text = _bugDoc.data.title;

    _imageView.image = _bugDoc.fullImage;
    NSLog(@"right here boo%@", _bugDoc.data.features);
    NSURL *hurl = [NSURL URLWithString:_bugDoc.data.features];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:hurl];
    [zombieweb setDelegate:self];
    [zombieweb loadRequest:requestObj];
    [zombieweb setScalesPageToFit:YES];
    [super viewWillAppear:animated];
    self.title = _bugDoc.data.title;
}


- (void)keyboardWasShown:(NSNotification *)notification 
{
    

    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
    
    
  
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeTextField.frame.origin.y - (keyboardSize.height-55));
        [theScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    theScrollView.contentInset = contentInsets;
    theScrollView.scrollIndicatorInsets = contentInsets;
}

// Set activeTextField to the current active textfield

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField; 
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}



- (IBAction)titleFieldValueChanged:(id)sender {
    _bugDoc.data.title = _titleField.text;
    [_bugDoc saveData];
}
- (IBAction)dismissKeyboard:(id)sender
{
    [self.activeTextField resignFirstResponder];
}
- (IBAction)phoneFieldValueChanged:(id)sender;{

    _bugDoc.data.phone = _phoneField.text;
    [_bugDoc saveData];
    
}

- (IBAction)locationFieldValueChanged:(id)sender;{
    
    _bugDoc.data.location = _location.text;
    [_bugDoc saveData];
    
}

- (IBAction)featuresFieldValueChanged:(id)sender;{
    
    _bugDoc.data.features = _features.text;
    [_bugDoc saveData];
    
}

- (IBAction)progressFieldValueChanged:(id)sender;{
    
    _bugDoc.data.progress = _progress.text;
    [_bugDoc saveData];
    
}

- (IBAction)notesFieldValueChanged:(id)sender;{
    
    _bugDoc.data.notes = _notes.text;
    [_bugDoc saveData];
    
}

- (IBAction)addPictureTapped:(id)sender {
              
      }




#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)phoneFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)locationFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)featuresFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)progressFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)notesFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}



#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    
    [self dismissModalViewControllerAnimated:YES];
    
     
    [_queue addOperationWithBlock: ^{
        
 
        
        UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
       
        
      //  UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
        

       
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            _bugDoc.fullImage = fullImage;
            _bugDoc.thumbImage = fullImage;
            _imageView.image = fullImage;
            [_bugDoc saveImages];
       
        }];
    }]; 
}
-(void)webViewDidStartLoad:(UIWebView *)webView {
    
    
    
    
    [activityIndicator startAnimating];
    NSLog(@"[activityIndicator startAnimating]");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator stopAnimating];
    NSLog(@"[activityIndicator stopAnimating]");
}
@end
