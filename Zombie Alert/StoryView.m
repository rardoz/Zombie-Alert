//
//  StoryView.m
//  Zombie Alert
//
//  Created by Robert on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoryView.h"
#import "RootViewController.h"
#import "ScaryBugDatabase.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "thetumblr.h"
#import <MessageUI/MessageUI.h>
@interface StoryView ()

@end

@implementation StoryView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)email:(id)sender{


    
    
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"ZOMBIE ALERT!"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"",  nil];
        [mailer setToRecipients:toRecipients];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imig]]];
        if (image) {
            
            ;
            NSData *imageData = UIImagePNGRepresentation(image);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"zombieImage"];
            
            NSString *emailBody = [NSString stringWithFormat:@"ZOMBIE ALERT: Click the link to view this zombie article I found using the Zombie Alert app for iPhone called %@. %@", title, url];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        // getting an NSString
        url = [prefs stringForKey:@"zombieurl"];
    title = [prefs stringForKey:@"zombiestorytitle"];
     imig = [prefs stringForKey:@"zombiestoryimg"];
    NSLog(@"this is my url for story view: %@", url);
    
    NSURL *hurl = [NSURL URLWithString:url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:hurl];
    [zombieweb setDelegate:self];
    [zombieweb loadRequest:requestObj];
    [zombieweb setScalesPageToFit:YES];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)tweetit:(id)sender

{

    [self showTweetSheet];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)facebookit:(id)sender{
    apicalls = [[APICallsViewController alloc] init];

    [apicalls userDidGrantPermission];
}
-(IBAction)savedpressed:(id)sender{
    NSLog(@"Saved Pressed");
       [activityIndicator startAnimating];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    

    [prefs setObject:url forKey:@"geturl"];
    [prefs setObject:title forKey:@"gettits"];
    [prefs setObject:imig forKey:@"getimgurl"];
    ///save from god lets root view controller know that it needs to save something!
    [prefs setInteger:0 forKey:@"savefromgod"];
    [prefs synchronize];
      NSLog(@"url start%@", [prefs stringForKey:@"geturl"]);
    RootViewController *addDrinkVC = [[RootViewController alloc] initWithNibName:nil bundle:nil];
   /* UINavigationController *addNavCon = [[UINavigationController alloc] initWithRootViewController:addDrinkVC];
    
    NSMutableArray *loadedBugs = [ScaryBugDatabase loadScaryBugDocs];
    RootViewController *rootController = (RootViewController *) [addNavCon.viewControllers objectAtIndex:0];
    rootController.bugs = loadedBugs;
    
    addNavCon.navigationBar.tintColor = [UIColor blackColor];
    addNavCon.toolbar.tintColor = [UIColor blackColor];
    [self presentModalViewController:addNavCon animated:YES];
    [addDrinkVC release];
    [addNavCon release];*/
 
    
[addDrinkVC loadImage];
    [activityIndicator stopAnimating];
}

-(IBAction)thetumblr:(id)sender{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    
    int tumb = [defaults integerForKey:@"tumblron"];
    
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




-(void)webViewDidStartLoad:(UIWebView *)webView {




    [activityIndicator startAnimating];
    NSLog(@"[activityIndicator startAnimating]");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activityIndicator stopAnimating];
    NSLog(@"[activityIndicator stopAnimating]");
}

-(IBAction)donepressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void)showTweetSheet
{
    
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
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imig]]];
        if (image) {
            NSLog(@"image finished loading");
        if (![tweetSheet addImage:image]) {
            NSLog(@"Unable to add the image!");
        }
        
        //  Add an URL to the Tweet.  You can add multiple URLs.
        if (![tweetSheet addURL:[NSURL URLWithString:url]]){
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
@end
