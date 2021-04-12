//
//  MDXSessionDelegate.m
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

#import "MDXSessionDelegate.h"

@implementation MDXSessionDelegate

- (NSString *)description
{
    if (![self handler]) {
        return @"MDXSessionDelegate<delegate:nil>";
    }
    else {
        return [NSString stringWithFormat:@"MDXSessionDelegate<delegate:%@>", [[self handler] description]];
    }
}


// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtForwarding.html
#pragma mark - Forward session delegate messages

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([[self handler] respondsToSelector:aSelector]) {
        return YES;
    }
    else {
        return [[self class] instancesRespondToSelector:aSelector];
    }
}


- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    // https://developer.apple.com/documentation/objectivec/nsobject/1418893-conformstoprotocol?language=objc
    if ([[self handler] conformsToProtocol:aProtocol]) {
        return YES;
    }
    else {
        return aProtocol == @protocol(NSURLSessionDelegate) || aProtocol == @protocol(NSURLSessionTaskDelegate);
    }
}


- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([[self handler] respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:[self handler]];
    }
    else {
        [super forwardInvocation:invocation];
    }
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature* signature = [super methodSignatureForSelector:sel];
    
    if (!signature) {
        id object = [self handler];
        signature = [object methodSignatureForSelector:sel];
    }
    
    return signature;
}

@end
