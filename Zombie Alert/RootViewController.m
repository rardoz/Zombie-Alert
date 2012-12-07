

#import "RootViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugData.h"
#import "ScaryBugDatabase.h"
#import "EditBugViewController.h"
#import <Twitter/Twitter.h>

#import "thetumblr.h"
#import <MessageUI/MessageUI.h>
@implementation RootViewController
@synthesize bugs = _bugs;
@synthesize editBugViewController = _editBugViewController;
@synthesize mytable;
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  
    [super viewDidLoad];
        self.title = @"Saved Zombies";

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donetapped:)]autorelease];

    
          

    
}
-(void)sendmail{
    
    NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
    [prefs setObject:_editBugViewController.bugDoc.data.features forKey:@"zombieurl"];
    [prefs setObject:_editBugViewController.bugDoc.data.title forKey:@"zombiestorytitle"];
    [prefs setObject:_editBugViewController.bugDoc.data.phone  forKey:@"zombiestoryimg"];
    [prefs synchronize];

    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"ZOMBIE ALERT!"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"",  nil];
        [mailer setToRecipients:toRecipients];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_editBugViewController.bugDoc.data.phone]]];
        if (image) {

      ;
        NSData *imageData = UIImagePNGRepresentation(image);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"zombieImage"];
        
        NSString *emailBody = [NSString stringWithFormat:@"ZOMBIE ALERT: Click the link to view this zombie article I found using the Zombie Alert app for iPhone called %@. %@", _editBugViewController.bugDoc.data.title, _editBugViewController.bugDoc.data.features];
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentModalViewController:mailer animated:YES];
        
            [mailer release];}
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissModalViewControllerAnimated:YES];
}
- (void)donetapped:(id)sender {
    NSLog(@"tapped");
    [self dismissModalViewControllerAnimated:YES];
                                              }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSInteger myInt = [prefs integerForKey:@"savefromgod"];
    
    if (myInt == 1) {
    
        self.view.alpha = 0;
        self.navigationController.view.alpha = 0;
        
    }
    self.mytable.delegate = self;
    self.mytable.dataSource = self;
    
    [self.mytable reloadData];
    toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.tintColor = [UIColor colorWithHue:0.29 saturation:0.93 brightness:0.50 alpha:1.0];
    
    
    [toolbar sizeToFit];
    
    
	CGFloat toolbarHeight = [toolbar frame].size.height;
    

	CGRect rootViewBounds = self.parentViewController.view.bounds;
    
    
    
	
	CGFloat rootViewHeight = CGRectGetHeight(rootViewBounds);
    
	
	CGFloat rootViewWidth = CGRectGetWidth(rootViewBounds);
    
	
	CGRect rectArea = CGRectMake(0, rootViewHeight - toolbarHeight, rootViewWidth, toolbarHeight);
 
    
	
	[toolbar setFrame:rectArea];
	

  
   
	[self.navigationController.view addSubview:toolbar];
	

	[self.mytable reloadData];
 
  
    
}



- (void) info_clicked4:(id)sender {
    
	[self sendmail];
}

- (void) info_clicked3:(id)sender {
    NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
    [prefs setObject:_editBugViewController.bugDoc.data.features forKey:@"zombieurl"];
    [prefs setObject:_editBugViewController.bugDoc.data.title forKey:@"zombiestorytitle"];
    [prefs setObject:_editBugViewController.bugDoc.data.phone  forKey:@"zombiestoryimg"];
    [prefs synchronize];
    int tumb = [prefs integerForKey:@"tumblron"];
    
    if (tumb > 0) {
        
        UIViewController *tubl = [[thetumblr alloc] initWithNibName:nil bundle:nil];
        UINavigationController *navit = [[UINavigationController alloc] initWithRootViewController:tubl];
        [self presentModalViewController: navit animated: YES];
        
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tumblr" message:@"You are not logged into your tumblr account. Please go to the settings page located in the main zombie screen and turn on your tumblr." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
        
    }

	
}

- (void) info_clicked2:(id)sender {
    
    
    NSUserDefaults *twitteron = [[NSUserDefaults alloc] init];
    int tw = [twitteron integerForKey:@"twitteron"];
    
    if (tw > 0) {
        NSLog(@"is greater than zero in show tweet sheet.");
        //  Create an instance of the Tweet Sheet
        TWTweetComposeViewController *tweetSheet =
        [[TWTweetComposeViewController alloc] init];
        
        
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any UI updates occur
        // on the main queue
        tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result) {
            switch(result) {
                case TWTweetComposeViewControllerResultCancelled:
                    //  This means the user cancelled without sending the Tweet
                    break;
                case TWTweetComposeViewControllerResultDone:
                    //  This means the user hit 'Send'
                    break;
            }
            
            
            //  dismiss the Tweet Sheet
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    NSLog(@"Tweet Sheet has been dismissed.");
                }];
            });
        };
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText:@"Another zombie alert! #zombiealertapp"];
        
        //  Adds an image to the Tweet
        //  For demo purposes, assume we have an image named 'larry.png'
        //  that we wish to attach
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // getting an NSString
        [prefs setObject:_editBugViewController.bugDoc.data.features forKey:@"zombieurl"];
        [prefs setObject:_editBugViewController.bugDoc.data.title forKey:@"zombiestorytitle"];
        [prefs setObject:_editBugViewController.bugDoc.data.phone  forKey:@"zombiestoryimg"];

        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_editBugViewController.bugDoc.data.phone]]];
        if (image) {
            NSLog(@"image finished loading");
            if (![tweetSheet addImage:image]) {
                NSLog(@"Unable to add the image!");
            }
            
            //  Add an URL to the Tweet.  You can add multiple URLs.
            if (![tweetSheet addURL:[NSURL URLWithString:_editBugViewController.bugDoc.data.features]]){
                NSLog(@"Unable to add the URL!");
            }
            
            //  Presents the Tweet Sheet to the user
            [self presentViewController:tweetSheet animated:NO completion:^{
                NSLog(@"Tweet sheet has been presented.");
            }];}
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"You do not have twitter activated. Please note that you must have IOS 5.0 or greater to use this feature and have twitter activated in your phones settings. Go to the home screen and press the settings button to turn on twitter." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
    }
	
    
	
	
}

- (void) info_clicked:(id)sender {
    

    apistuff = [[APICallsViewController alloc] init];
    [apistuff userDidGrantPermission];
	/*	ivControllerToolbar = [[FourthViewController alloc] initWithNibName:nil bundle:nil];
    
    ivControllerToolbar.modalTransitionStyle = UIModalTransitionStyleCoverVertical ;
    [self presentModalViewController:ivControllerToolbar animated:YES];
*/

NSLog(@"click");
	

	
	
}

- (void)viewDidAppear:(BOOL)animated {
 
    [super viewDidAppear:animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSInteger myInt = [prefs integerForKey:@"savefromgod"];
    
    if (myInt == 1) {
        [prefs setInteger:0 forKey:@"savefromgod"];
        [prefs synchronize];
        
        [self addTapped:self];
    }

}





#pragma mark -
#pragma mark Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _bugs.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    

    ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = doc.data.title;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.imageView.image = doc.thumbImage;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (editingStyle == UITableViewCellEditingStyleDelete) {  
        ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
        [doc deleteDoc];
        [_bugs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (_editBugViewController == nil) {
        self.editBugViewController = [[[EditBugViewController alloc] initWithNibName:@"EditBugViewController" bundle:[NSBundle mainBundle]] autorelease];        
    }
    ScaryBugDoc *doc = [_bugs objectAtIndex:indexPath.row];
    _editBugViewController.bugDoc = doc;
    NSLog(@"checking shit1 %@", _editBugViewController.bugDoc.data.title );
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    [prefs setObject:_editBugViewController.bugDoc.data.features forKey:@"zombieurl"];
    [prefs setObject:_editBugViewController.bugDoc.data.title forKey:@"zombiestorytitle"];
    [prefs setObject:_editBugViewController.bugDoc.data.phone  forKey:@"zombiestoryimg"];
    
    UIImage *buttonImage = [UIImage imageNamed:@"buttonblank.png"];
    UIImage *buttonImage2 = [UIImage imageNamed:@"buttonblank.png"];
    UIImage *buttonImage3 = [UIImage imageNamed:@"buttonblank.png"];
    UIImage *buttonImage4 = [UIImage imageNamed:@"buttonblank.png"];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button2 setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
    [button3 setBackgroundImage:buttonImage3 forState:UIControlStateNormal];
    [button4 setBackgroundImage:buttonImage4 forState:UIControlStateNormal];
    [button setTitle:@"WALL" forState:UIControlStateNormal];
    [button2 setTitle:@"TWEET" forState:UIControlStateNormal];
    [button3 setTitle:@"TUMBLR" forState:UIControlStateNormal];
    [button4 setTitle:@"EMAIL" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"Futura" size:15];
    button2.titleLabel.font = [UIFont fontWithName:@"Futura" size:15];
    button3.titleLabel.font = [UIFont fontWithName:@"Futura" size:15];
    button4.titleLabel.font = [UIFont fontWithName:@"Futura" size:15];
    UIColor *darkgreen = [UIColor colorWithHue:0.29 saturation:0.93 brightness:0.40 alpha:1.0];
    [button setTitleColor:darkgreen forState:UIControlStateNormal];
     [button2 setTitleColor:darkgreen forState:UIControlStateNormal];
     [button3 setTitleColor:darkgreen forState:UIControlStateNormal];
     [button4 setTitleColor:darkgreen forState:UIControlStateNormal];
    [button addTarget:self action:@selector(info_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(info_clicked2:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(info_clicked3:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(info_clicked4:) forControlEvents:UIControlEventTouchUpInside];
	
    
    button.frame = CGRectMake(0, 0, 65, 31);
    button2.frame = CGRectMake(0, 0, 65, 31);
    button3.frame = CGRectMake(0, 0, 65, 31);
    button4.frame = CGRectMake(0, 0, 65, 31);
    
	
	UIBarButtonItem *infoButton = [[UIBarButtonItem alloc]
								   initWithCustomView:button];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
   	UIBarButtonItem *infoButton2 = [[UIBarButtonItem alloc]
                                    initWithCustomView:button2];
    UIBarButtonItem *infoButton3 = [[UIBarButtonItem alloc]
                                    initWithCustomView:button3];
    UIBarButtonItem *infoButton4 = [[UIBarButtonItem alloc]
                                    initWithCustomView:button4];
	
	[toolbar setItems:[NSArray arrayWithObjects:infoButton,flexItem, infoButton2,flexItem,infoButton3,flexItem, infoButton4, nil]];
    [self.navigationController pushViewController:_editBugViewController animated:YES]; 
   
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    self.editBugViewController = nil;
}

- (void)viewDidUnload {

}


- (void)dealloc {
    [_bugs release];
    _bugs = nil;
    [_editBugViewController release];
    _editBugViewController = nil;
    [super dealloc];
}

- (void)loadImage
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    
    NSString *geturl = [prefs stringForKey:@"geturl"];
    NSString *getimz = [prefs stringForKey:@"getimgurl"];
    
     NSLog(@"This is my image url before being added to teh set. %@" , geturl);
  
     NSString *gettitle = [prefs stringForKey:@"gettits"];
     NSLog(@"this is my image url true %@", [prefs stringForKey:@"getimgurl"]);
    

    NSURL * urltwo = [NSURL URLWithString:getimz];
    NSData * data = [NSData dataWithContentsOfURL:urltwo];
    UIImage * image = [UIImage imageWithData:data];
    
    if (image)
    {
        // Success use the image
        NSLog(@"success");
        ScaryBugDoc *newDoc = [[[ScaryBugDoc alloc] initWithTitle:gettitle initWithPhone:getimz initWithLocation:nil initWithFeatures:geturl initWithProgress:nil initWithNotes:nil thumbImage:image fullImage:image] autorelease];
        
        newDoc.fullImage = image;
        newDoc.thumbImage = image;
        [_bugs addObject:newDoc];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count-1 inSection:0];
        //NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        ////[self.mytable insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
        
        // [self.mytable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        //[self tableView:self.mytable didSelectRowAtIndexPath:indexPath];
        [newDoc saveImages];
        [newDoc saveData];
        [self dismissViewControllerAnimated:NO completion:NULL];
    
    }
    else
    {
        // Failed (load an error image?)
        NSLog(@"failure");
        
    }
}
- (void)addTapped:(id)sender {
            
    
        // getting an NSInteger
     [self performSelectorInBackground:@selector(loadImage) withObject:nil];
     //   NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // getting an NSString
    
   /* NSString *geturl = [prefs stringForKey:@"geturl"];
    NSLog(@"This is my image url before being added to teh set. %@" , geturl);
    UIImage *fullImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[prefs stringForKey:@"getimgurl"]]]];
    NSString *gettitle = [prefs stringForKey:@"gettits"];
    NSLog(@"this is my image url true %@", [prefs stringForKey:@"getimgurl"]);


    
    

    ScaryBugDoc *newDoc = [[[ScaryBugDoc alloc] initWithTitle:gettitle initWithPhone:nil initWithLocation:nil initWithFeatures:geturl initWithProgress:nil initWithNotes:nil thumbImage:fullImage fullImage:fullImage] autorelease];
    [_bugs addObject:newDoc];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_bugs.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];    
    [self.mytable insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];*/
    
   // [self.mytable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //[self tableView:self.mytable didSelectRowAtIndexPath:indexPath];
    /*
    [newDoc saveData];
    [self dismissModalViewControllerAnimated:NO];*/
}


@end

