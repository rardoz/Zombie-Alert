//
//  StoryView.h
//  Zombie Alert
//
//  Created by Robert on 7/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APICallsViewController.h"
#import <MessageUI/MessageUI.h>
@interface StoryView : UIViewController<UIWebViewDelegate, MFMailComposeViewControllerDelegate> {
    IBOutlet UIButton *twitterbtn;
    IBOutlet UIButton *facebookbtn;
    IBOutlet UIButton *pinterestbtn;
   
    IBOutlet UIButton *savebtn;
    IBOutlet UIButton *email;
    NSString *url;
    NSString *title;
    NSString *imig;
    IBOutlet UIWebView *zombieweb;
     IBOutlet UIButton *donebtn;
   IBOutlet UIActivityIndicatorView *activityIndicator;
    APICallsViewController *apicalls;
}
-(IBAction)email:(id)sender;
-(IBAction)donepressed:(id)sender;
-(IBAction)savedpressed:(id)sender;
-(IBAction)facebookit:(id)sender;
-(IBAction)tweetit:(id)sender;
-(IBAction)thetumblr:(id)sender;
@end
