# CustomSessionDelegateDemo #

Demonstrate the usage of MDXSessionDelegate class. 

The NSURLSession class accepts a delegate only at initialization. If it lacks a delegate, it switches to using completion blocks. This class enables greater flexibility by forwarding delegate methods to a handler, which may or may not exist. The handler implements the NSURLSessionDelegate class's delegate methods as desired. In the event of no handler, completion blocks are executed. A handler may be switched in an out—or swapped for another—at runtime.

The project is written in Objective-C.

### Getting Started ###

Run the project, switching between the use of a delegate or not by interacting with the switch on the UI. Refer to the NSLog output (and source code) to see what's happening.

Applicable class and category:

  * MDXSessionDelegate
  * NSURLSession+MDXSessionDelegateHandler

Both the above class and category should be added to incorporate the functionality into a project.

### Prerequisites ###

Xcode 11.3.1 and iOS 13.2.

## License ##

This project is licensed under the BSD 3 license. Copyright (c) 2021 Mario Diana.

