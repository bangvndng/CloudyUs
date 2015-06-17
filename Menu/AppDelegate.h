//
//  AppDelegate.h
//  Menu
//
//  Created by Đăng Hoà on 6/16/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	NSStatusItem *statusItem;
	IBOutlet NSMenu *statusMenu;
}
- (IBAction)tapShowWeb:(id)sender;
- (IBAction)tapShowTeamMobile:(id)sender;
- (IBAction)tapQuit:(id)sender;


@property (assign) IBOutlet NSWindow *window;

@end
