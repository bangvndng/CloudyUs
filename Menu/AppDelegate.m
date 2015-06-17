//
//  AppDelegate.m
//  Menu
//
//  Created by Đăng Hoà on 6/16/15.
//  Copyright (c) 2015 ___GREENGLOBAL___. All rights reserved.
//

#import "AppDelegate.h"
#import "NSStatusItem+BCStatusItem.h"
#import "BCStatusItemView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    NSImage *image = [NSImage imageNamed:@"cloud.png"];
	NSImage *alternateImage = [NSImage imageNamed:@"cloud.png"];
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	[statusItem setupView];
	
	[statusItem setTitle:@"Cloudyus"];
	[statusItem setMenu:statusMenu];
	[statusItem setHighlightMode:YES];
	
	[statusItem setImage:image];
	[statusItem setAlternateImage:alternateImage];
	
	[statusItem setViewDelegate:self];
	[[statusItem view] registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType,nil]];

}

- (NSDragOperation)statusItemView:(BCStatusItemView *)view draggingEntered:(id <NSDraggingInfo>)info
{
	NSLog(@"Drag entered!");
	return NSDragOperationCopy;
}

- (void)statusItemView:(BCStatusItemView *)view draggingExited:(id <NSDraggingInfo>)info
{
	NSLog(@"Dragging exit");
}

- (BOOL)statusItemView:(BCStatusItemView *)view prepareForDragOperation:(id <NSDraggingInfo>)info
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [info draggingSourceOperationMask];
    pboard = [info draggingPasteboard];

    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        NSLog(@"file %@",[files lastObject]);
        
        NSString *path = [files lastObject];
    
//        [[NSWorkspace sharedWorkspace] openFile:[files lastObject]];

        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:[files lastObject] error:nil];
        
        
        NSLog(@"dic %@",dic);
        NSString *docDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Desktop"];
        [ [ NSFileManager defaultManager ] createDirectoryAtPath:[NSString stringWithFormat:@"%@/cloudyus",docDir] withIntermediateDirectories: YES attributes: nil error: NULL ];
        
        
        
        [[NSFileManager defaultManager] copyItemAtPath:path toPath:[NSString stringWithFormat:@"%@/cloudyus/%@.%@",docDir,[[path lastPathComponent] stringByDeletingPathExtension],[path pathExtension]] error:nil];
        
        NSAlert *alert = [NSAlert alertWithMessageText:@"Cloudyus" defaultButton:@"Cancel" alternateButton:@"OK" otherButton:nil informativeTextWithFormat:[self formatInfoOfItemWithDic:dic andPath:[files lastObject]]];
        
        [alert runModal];
    }

	NSLog(@"Prepare for drag");
	return NO;
}

- (BOOL)statusItemView:(BCStatusItemView *)view performDragOperation:(id <NSDraggingInfo>)info
{
	NSLog(@"Perform drag");
	return YES;
}

#pragma mark other method
-(NSString *)formatInfoOfItemWithDic:(NSDictionary *)dic andPath:(NSString *)path{
    
    NSString* theFileName = [[path lastPathComponent] stringByDeletingPathExtension];
    
    CFStringRef fileExtension = (__bridge CFStringRef) [path pathExtension];
    CFStringRef fileUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension, NULL);
    
    NSString *type = @"";
    
    if (UTTypeConformsTo(fileUTI, kUTTypeImage)) type = @"It's an image";
    else if (UTTypeConformsTo(fileUTI, kUTTypeMovie)) type = @"It's a movie";
    else if (UTTypeConformsTo(fileUTI, kUTTypeText)) type = @"It's text";
    else type = @"It's something";
    
    NSString *content = [NSString stringWithFormat:@"%@\n\nExtension: %@\nName: %@\nDate Created: %@\nSize: %@ bytes\nOwner: %@\nLast Opened: %@",type,[path pathExtension],theFileName,[dic objectForKey:NSFileCreationDate],[dic objectForKey:NSFileSize],[dic objectForKey:NSFileOwnerAccountName],[dic objectForKey:NSFileModificationDate]];
    return content;
}

#pragma mark Action

- (IBAction)tapShowWeb:(id)sender {
    
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://toancauxanh.vn"]];
}

- (IBAction)tapShowTeamMobile:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://toancauxanh.vn"]];
}

- (IBAction)tapQuit:(id)sender {
    [NSApp terminate:self];
}
@end


