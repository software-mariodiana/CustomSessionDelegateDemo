//
//  NSURLSession+MDXSessionDelegateHandler.h
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

#import <Foundation/Foundation.h>
#import "MDXSessionDelegate.h"

/**
 * Enable greater functionality by giving the session delegate its own delegate (or "handler").
 *
 * The "handler" object can be swapped in and out during runtime. If the handler is nil, the
 * session is free to use its completion-block methods. Otherwise, a handler allows for delegate
 * methods. Session delegate messages with corresponding methods implemented by the handler
 * are forwarded to the handler.
 */
@interface NSURLSession (MDXSessionDelegateHandler)

/**
 * Creates a session with the specified session configuration and an MDXSessionDelegate.
 */
+ (NSURLSession *)MDXSessionWithConfiguration:(NSURLSessionConfiguration *)configuration;

/**
 * Creates a session with the specified session configuration and operation queue, and an MDXSessionDelegate.
 */
+ (NSURLSession *)MDXSessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                delegateQueue:(NSOperationQueue *)queue;

/**
 * Return YES if delegate handler has been set; NO, otherwise.
 */
- (BOOL)hasMDXDelegateHandler;

/**
 * Return MDXDelegateHandler instance.
 */
- (id<MDXSessionDelegateHandling>)mdxDelegateHandler;

/**
 * Set handler for the session delegate.
 */
- (void)setMDXDelegateHandler:(id<MDXSessionDelegateHandling>) handler;

/**
 * Clear handler for the session delegate (restoring completion-block functionality to session).
 */
- (void)resetMDXDelegateHandler;

@end
