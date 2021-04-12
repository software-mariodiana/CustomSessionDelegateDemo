//
//  NSURLSession+MDXSessionDelegateHandler.m
//
// Copyright (c) 2021 Mario Diana
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
// TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
// PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "NSURLSession+MDXSessionDelegateHandler.h"

@implementation NSURLSession (MDXSessionDelegateHandler)

+ (NSURLSession *)MDXSessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    return [NSURLSession MDXSessionWithConfiguration:configuration delegateQueue:nil];
}


+ (NSURLSession *)MDXSessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                delegateQueue:(NSOperationQueue *)queue
{
    return [NSURLSession sessionWithConfiguration:configuration
                                         delegate:[[MDXSessionDelegate alloc] init]
                                    delegateQueue:queue];
}


- (BOOL)hasMDXDelegateHandler
{
    id delegate = [self delegate];
    
    if (!delegate) {
        return NO;
    }
    else {
        MDXSessionDelegate* esd = (MDXSessionDelegate *)delegate;
        return ([esd handler] != nil);
    }
}


- (id<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>)mdxDelegateHandler
{
    id delegate = [self delegate];
    
    if (delegate) {
        MDXSessionDelegate* esd = (MDXSessionDelegate *)delegate;
        return [esd handler];
    }
    else {
        return nil;
    }
}


- (void)setMDXDelegateHandler:(id<MDXSessionDelegateHandling>) handler
{
    id delegate = [self delegate];
    
    if (delegate) {
        MDXSessionDelegate* esd = (MDXSessionDelegate *)delegate;
        esd.handler = handler;
    }
}


- (void)resetMDXDelegateHandler
{
    [self setMDXDelegateHandler:nil];
}

@end
