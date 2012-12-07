//
//  allStories.m
//  Zombie Alert
//
//  Created by Robert Greene on 8/15/12.
//
//

#import "allStories.h"

@interface allStories ()

@end

@implementation allStories

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
    
    NSURL *hurl = [NSURL URLWithString:@"http://zombiealert.heliumdc.com"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:hurl];
    [zombieweb setDelegate:self];
    [zombieweb loadRequest:requestObj];
    [zombieweb setScalesPageToFit:YES];

    // Do any additional setup after loading the view from its nib.
}
-(IBAction)donepressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
