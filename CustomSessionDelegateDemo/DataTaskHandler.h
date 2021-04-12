//
//  DataTaskHandler.h
//  CustomSessionDelegateDemo
//
//  Created by Mario Diana on 4/9/21.
//  Copyright © 2021 Mario Diana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDXSessionDelegate.h"

extern NSString* const CustomSessionDelegateDemoDataDidDownloadNotification;

@interface DataTaskHandler : NSObject <MDXSessionDelegateHandling>

@end
