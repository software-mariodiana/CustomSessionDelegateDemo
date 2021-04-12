//
//  ViewController.m
//  CustomSessionDelegateDemo
//
//  Created by Mario Diana on 4/8/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import "ViewController.h"

#import "NSURLSession+MDXSessionDelegateHandler.h"
#import "DataTaskHandler.h"

// At the time of this writing, these are working endpoints.
NSString* const kSessionDelegateDemoURLString =
    @"https://upload.wikimedia.org/wikipedia/en/d/d4/Mickey_Mouse.png";

NSString* const kCompletionHandlerDemoURLString =
    @"https://upload.wikimedia.org/wikipedia/en/a/a5/Donald_Duck_angry_transparent_background.png";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *delegateStateLabel;
@property (weak, nonatomic) IBOutlet UISwitch *delegateToggle;

@property (nonatomic, strong) NSURLSession* session;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLSessionConfiguration* configuration =
        [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.session = [NSURLSession MDXSessionWithConfiguration:configuration];
    
    // Cheat with "sender" to setup appropriate state.
    [self toggleDelegateState:[self delegateToggle]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dataDidDownload:)
                                                 name:CustomSessionDelegateDemoDataDidDownloadNotification
                                               object:nil];
}


- (IBAction)toggleDelegateState:(id)sender
{
    UISwitch* toggle = (UISwitch *)sender;
    
    if ([toggle isOn]) {
        self.delegateStateLabel.text = @"Delegate ON";
        id<MDXSessionDelegateHandling> handler = [[DataTaskHandler alloc] init];
        [[self session] setMDXDelegateHandler:handler];
    }
    else {
        self.delegateStateLabel.text = @"Delegate OFF";
        [[self session] resetMDXDelegateHandler];
    }
    
    [self clearImage:self];
}


- (IBAction)clearImage:(id)sender
{
    self.imageView.image = nil;
}


- (IBAction)fetchResource:(id)sender
{
    if ([[self delegateToggle] isOn]) {
        [self runDelegateHandlerDemo];
    }
    else {
        [self runCompletionBlockDemo];
    }
}


- (void)loadImageFromData:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
    });
}


- (void)runCompletionBlockDemo
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    NSURL* url = [NSURL URLWithString:kCompletionHandlerDemoURLString];
    
    NSURLSessionTask* task =
        [[self session] dataTaskWithURL:url
                      completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        NSLog(@"Executing completion block...");
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        else {
            NSHTTPURLResponse* http = (NSHTTPURLResponse *)response;
            NSInteger status = [http statusCode];
            
            if (status != 200) {
                NSLog(@"Unfortunate HTTP response code: %ld", status);
            }
            else {
                [self loadImageFromData:data];
            }
        }
    }];
    
    [task resume];
}


- (void)runDelegateHandlerDemo
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    NSURL* url = [NSURL URLWithString:kSessionDelegateDemoURLString];
    NSURLSessionTask* task = [[self session] dataTaskWithURL:url];
    [task resume];
}


- (void)dataDidDownload:(NSNotification *)notification
{
    NSData* data = [[notification userInfo] objectForKey:@"data"];
    [self loadImageFromData:data];
}

@end
