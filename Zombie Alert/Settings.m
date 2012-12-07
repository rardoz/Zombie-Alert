//
//  Settings.m
//  Zombie Alert
//
//  Created by Robert Greene on 7/28/12.
//
//

#import "Settings.h"
#import "AppDelegate.h"
#import "FBConnect.h"
#import "thetumblr.h"
#import "SettingsViewController.h"
#import "SandboxViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
@interface Settings ()

@end

@implementation Settings
//@synthesize fblable = _fblable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [tumblractive startAnimating];
    [twitteractive startAnimating];
    [facebookactive startAnimating];
    //[self fbmachine];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)fblogin:(id)sender{

    if (fbsw.isOn) {
        
        
        NSLog(@"facebook is on");
        [self login];
        [NSTimer scheduledTimerWithTimeInterval:5.0
                                         target:self
                                       selector:@selector(facebookfix)
                                       userInfo:nil
                                        repeats:NO];
        
        [self fbmachine];
    } else if (!fbsw.isOn) {
        [self logout];
        [fblable setText:  @"No body!"];
    [profilePhotoImageView setImage:NULL];
        NSLog(@"facebook is off");
    
    }


}
-(IBAction)tumblrlogin:(id)sender{
    
    if (tbsw.isOn) {
        NSLog(@"tumblr is on");
        NSString *prefsEmail = [[NSUserDefaults standardUserDefaults]objectForKey:@"TumblrEmailAddress"];
        if (prefsEmail == NULL) {
            UIViewController *tubl = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
            UINavigationController *navit = [[UINavigationController alloc]initWithRootViewController:tubl];
            [self presentViewController:navit animated:YES completion:NULL];
            
        } else {
        
            UIViewController *tubl = [[SettingsViewController alloc]initWithStyle:UITableViewStyleGrouped];
            UINavigationController *navit = [[UINavigationController alloc] initWithRootViewController:tubl];
            [self presentViewController:navit animated:YES completion:NULL];
        
        }
       
    } else if (!tbsw.isOn) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
        [defaults setInteger:0 forKey:@"tumblron"];
        [defaults setObject:NULL forKey:@"TumblrEmailAddress"];
        [defaults setObject:NULL forKey:@"TumblrPassword"];
        [defaults synchronize];
        NSLog(@"tumblr is off");
        [tumblrpicview setImage:NULL];
        [tblable setText:@"No body!"];
    }


}
-(IBAction)twitterlogin:(id)sender{

    
    if (twsw.isOn) {
       // SandboxViewController *twitterlogin = [[SandboxViewController alloc] init];
        if ([TWTweetComposeViewController canSendTweet])
        {
            // Create account store, followed by a twitter account identifer
            ACAccountStore * account = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            
            // Request access from the user to use their Twitter accounts.
            [account requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error)
             {
                 // Did user allow us access?
                 if (granted == YES)
                 {
                     // Populate array with all available Twitter accounts
                   NSArray *  arrayOfAccounts = [account accountsWithAccountType:accountType];
                     [arrayOfAccounts retain];
                     
                     // Populate the tableview
                     if ([arrayOfAccounts count] > 0){
                 
                         ACAccount *acct = [arrayOfAccounts objectAtIndex:0];
                         NSLog(@"table cell pressed: %@",[acct username]);
                         NSLog(@"table cell pressed: %@", [acct accountDescription]);
                         NSLog(@"tablec cell Pressed: %@", [acct identifier]);
                         NSDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:
                                                   [acct dictionaryWithValuesForKeys:[NSArray arrayWithObject:@"properties"]]];
                         NSString *tempUserID = [[tempDict objectForKey:@"properties"] objectForKey:@"user_id"];
                         
                         NSLog(@"this is my useride: %@", tempUserID);
                         
                         NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
                         
                         [prefs setObject:tempUserID forKey:@"twitterid"];
                         [prefs setObject:acct.username forKey:@"twittername"];
                         [prefs setInteger:1 forKey:@"twitteron"];
                         [prefs synchronize];
                         
                         
                         
                         
                         
                         
                         NSLog(@"array count is greater than 0");
                         twlable.text = [NSString stringWithFormat:@"%@", [prefs objectForKey:@"twittername"]];
                         
                         [self twittermachine];
                     }
                 }
             }];
        }
        
        //[self presentViewController:twitterlogin animated:YES completion:NULL];
        //[twitterlogin release];
        
        NSLog(@"twitter is on1");
    } else if (!twsw.isOn) {
        NSLog(@"twitter is off");
        NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
        [prefs setInteger:0 forKey:@"twitteron"];
        [prefs synchronize];
        [twlable setText:@"No Body!"];
        [twitterpicview setImage:NULL];
    }

}
-(IBAction)done:(id)sender{

    [self dismissModalViewControllerAnimated:YES];

}

-(void)fbmachine{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        [self showLoggedOut];
    } else {
        [self showLoggedIn];
    }


};

#pragma mark - Facebook API Calls
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}
#pragma - Private Helper Methods
-(void)showLoggedIn {

    [self apiFQLIMe];
    
    [fbsw setOn:YES];
    

}
-(void)showLoggedOut{

    NSLog(@"show something that indicates that we are logged out and then save that info");
    [fbsw setOn:NO];
    [facebookactive stopAnimating];

}

- (void)login {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid]) {
        [[delegate facebook] authorize:permissions];
        NSLog(@"loged in with delage and autorized permisions");
    } else {
        NSLog(@"about ot show logged in");
        [self showLoggedIn];
    }
    
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
}

- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
  [self showLoggedIn];
    


    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self storeAuthData:[[delegate facebook] accessToken] expiresAt:[[delegate facebook] expirationDate]];
    
    [pendingApiCallsController userDidGrantPermission];
   
    
      
  

}


-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
    NSLog(@"facebook did not log in!");
    [fbsw setOn:FALSE];
    [pendingApiCallsController userDidNotGrantPermission];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    pendingApiCallsController = nil;
    
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self showLoggedOut];
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    [alertView release];
    [self fbDidLogout];
}
-(void)facebookfix {
    
    NSUserDefaults *defu = [[NSUserDefaults alloc] init];
    NSLog(@"90210 %@", [defu objectForKey:@"fbname666"]);
    
    [fblable setText: [NSString stringWithFormat:@"%@",[defu objectForKey:@"fbname666"]]];
    [self reloadstuff];
}
#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */

- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
        NSLog(@"resut");
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        NSLog(@"res: %@", [result objectForKey:@"name"]);
        // If basic information callback, set the UI objects to
        // display this.
        NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
        [defaults setObject:[result objectForKey:@"name"] forKey:@"fbname666"];
        [defaults setObject:[result objectForKey:@"pic"] forKey:@"fbpic666"];
        [defaults synchronize];
       [fblable setText: [NSString stringWithFormat:@"%@",[result objectForKey:@"name"]]];
     //   self.fblable = [[UILabel alloc] init];
       
        NSLog(@"%@, %@ , %@, %@", fblable.text, fblable.text, twlable.text, [result objectForKey:@"name"]);
        // Get the profile image
     
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]];
        if (data) {
            NSLog(@"data perceived");
        
        UIImage * image = [UIImage imageWithData:data];
        
        //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
        if (image) {
            NSLog(@"getting image");
        // Resize, crop the image to make sure it is square and renders
        // well on Retina display
        float ratio;
        float delta;
        float px = 50; // Double the pixels of the UIImageView (to render on Retina)
        CGPoint offset;
        CGSize size = image.size;
        if (size.width > size.height) {
            ratio = px / size.width;
            delta = (ratio*size.width - ratio*size.height);
            offset = CGPointMake(delta/2, 0);
        } else {
            ratio = px / size.height;
            delta = (ratio*size.height - ratio*size.width);
            offset = CGPointMake(0, delta/2);
        }
        CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                     (ratio * size.width) + delta,
                                     (ratio * size.height) + delta);
        UIGraphicsBeginImageContext(CGSizeMake(px, px));
        UIRectClip(clipRect);
        [image drawInRect:clipRect];
        UIImage *imgThumb = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (imgThumb) {
             
            [profilePhotoImageView setImage:imgThumb];
          
            [facebookactive stopAnimating];
            if ([fblable.text isEqual:NULL]) {
                [facebookactive startAnimating];
            }
            NSLog(@"this should have set the image. 2012...");
            
            [self apiGraphUserPermissions];
          
        }
        }
        }
        else {
            NSLog(@"HOLY HELL 666");
            
            // Processing permissions information
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
            
        }
    }
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
}
-(void)reloadstuff{
   
    NSLog(@"view did appear");
    [self fbmachine];
    
    NSUserDefaults *prefs = [[NSUserDefaults alloc] init];
    
   /* [prefs setObject:tempUserID forKey:@"twitterid"];
    [prefs setObject:acct.username forKey:@"twittername"];
    [prefs setInteger:1 forKey:@"twitteron"];*/
    int twiton = [prefs integerForKey:@"twitteron"];
    int tublron = [prefs integerForKey:@"tumblron"];
    if (tublron > 0) {
        NSLog(@"tumblr is on");
        [tbsw setOn:YES];
        tblable.text = [prefs objectForKey:@"tumblrname"];
        NSURL * urltwo = [NSURL URLWithString:[prefs objectForKey:@"tumblrimgurl"]];
        NSData * data = [NSData dataWithContentsOfURL:urltwo];
        UIImage * image = [UIImage imageWithData:data];
        
        if (image)
        {
            
            [tumblrpicview setImage:image];
            [tumblractive stopAnimating];
            NSLog(@"doneeee");
        } else if(!image){
            
            NSLog(@"iamge faile");
            
        }

        //[tblable.text = [prefs objectForKey:@"tumblron"]]
    } else { [tumblractive stopAnimating];
    
    }
    
    
    if (twiton > 0) {
        NSLog(@"twitter is on");
        [twsw setOn:YES animated:NO];
        twlable.text = [NSString stringWithFormat:@"%@", [prefs objectForKey:@"twittername"]];
        
        [self twittermachine];
        //
    } else {
    
        [twitteractive stopAnimating];
    }
    
    

}
-(void)viewWillAppear:(BOOL)animated{

    
   
}
-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"ABC 123");
    [self reloadstuff];
    
    

}
-(void)twittermachine{
    [twitteractive startAnimating];
    //
//https://api.twitter.com/1/users/profile_image?screen_name=twitterapi&size=bigger
    NSUserDefaults *prefs = [[NSUserDefaults alloc] init];

    NSString *myu = [NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image?screen_name=%@&size=normal",[prefs objectForKey:@"twittername"] ];
    NSURL * urltwo = [NSURL URLWithString:myu];
    NSData * data = [NSData dataWithContentsOfURL:urltwo];
    UIImage * image = [UIImage imageWithData:data];
    
    if (image)
    {
        
        [twitterpicview setImage:image];
        
        [twitteractive stopAnimating];
        NSLog(@"done");
    } else if(!image){
        [twitteractive stopAnimating];
        NSLog(@"iamge faile");
    
    }
    
}




@end
