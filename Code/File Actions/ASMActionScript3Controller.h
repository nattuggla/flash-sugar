//
//  ASMActionScript3Controller.h
//  ActionScript3Sugar
//
//  Created by Michael Murray on 3/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TaskWrapper.h";

extern NSString * const FlashCS4;
extern NSString * const FlashCS3;
extern NSString * const MXMLC;

@interface ASMActionScript3Controller: NSObject <TaskWrapperController> {
	
	id context;
	
	TaskWrapper *compileTask;
	NSTask *task;
	
	BOOL compileRunning; 
	
	NSArray *extensions;
	NSString *compileUsing;
	
	NSString *cs3Compile;
	NSString *cs4Compile;
	NSString *mxmlcCompile;
	
	NSString *compilerLocation;
	
	IBOutlet id as3Hud;
	IBOutlet id as3HudText;
	IBOutlet id outputWindowText;
	IBOutlet id Activity;
	IBOutlet id build;
	IBOutlet id statusbarLabel;
	
	NSMutableString *pathToBundle;
	
	id outputWindow;
	
	
}

- (id)init:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath context:(id)tcontext;
- (void)open;
- (void)compileSource;
- (void)setOutput:(NSString *)output;
- (void)appendOutput:(NSString *)output;
- (IBAction) compile:sender;
@end
