//
//  allStories.h
//  Zombie Alert
//
//  Created by Robert Greene on 8/15/12.
//
//

#import <UIKit/UIKit.h>

@interface allStories : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *zombieweb;
    IBOutlet UIButton *donebtn;
    IBOutlet UIActivityIndicatorView *activityIndicator;

}
-(IBAction)donepressed:(id)sender;
@end
