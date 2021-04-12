//
//  DataTaskHandler.m
//  CustomSessionDelegateDemo
//
//  Created by Mario Diana on 4/9/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import "DataTaskHandler.h"

NSString* const CustomSessionDelegateDemoDataDidDownloadNotification =
    @"CustomSessionDelegateDemoDataDidDownloadNotification";

@interface DataTaskHandler ()
@property (nonatomic, strong) NSMutableData* buffer;
@end

@implementation DataTaskHandler

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    
    NSHTTPURLResponse* http = (NSHTTPURLResponse *)response;
    NSInteger status = [http statusCode];
    
    if (status != 200) {
        NSLog(@"Unfortunate HTTP response code: %ld", status);
        completionHandler(NSURLSessionResponseCancel);
    }
    else {
        NSLog(@"## Received response: 200 OK.");
        self.buffer = [NSMutableData data];
        completionHandler(NSURLSessionResponseAllow);
    }
}


- (void)URLSession:(NSURLSession *)session
      dataTask:(NSURLSessionDataTask *)dataTask
didReceiveData:(NSData *)data
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    NSLog(@"## Received %ld bytes of data.", [data length]);
    [[self buffer] appendData:data];
}


- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    NSLog(@"## %@ - %@", NSStringFromSelector(_cmd), self);
    
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:CustomSessionDelegateDemoDataDidDownloadNotification
                                                            object:self
                                                          userInfo:@{@"data": [NSData dataWithData:[self buffer]]}];
    }
}

@end
