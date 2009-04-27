//
//  ZDActionScript3CS3Compile.h
//  ActionScript3compile
//
//  Created by Mike Murray on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TaskWrapper.h"


@interface ASMFlashBuild : NSObject <TaskWrapperController> {
	
	NSArray *extensions;
	NSDictionary *tdictionary;
	NSString *tbundlePath;
	
	//IBOutlet WebView *previewWindow;
	
	TaskWrapper *compileTask;
	NSTask *task;
	
	BOOL compileRunning; 
	
	NSString *compileUsing;
	NSString *fileToCompile;
	NSString *outputFile;
	
	NSString *cs3Compile;
	NSString *cs4Compile;
	NSString *mxmlcCompile;
	
	NSString *compilerLocation;
	
	IBOutlet id buildWindow;
	IBOutlet id debugOutputText;
	
	IBOutlet id useCompiler;
	IBOutlet id buildMode;
	
	
	IBOutlet id statusbarLabel;
	
	NSMutableString *pathToBundle;
	
	id outputWindow;
	
	
}

- (void) compileSource: (NSString *) withFile;
- (void) setOutput:(NSString *)output;
- (void) appendOutput:(NSString *)output;

- (void) setDebugOutput:(NSString *) output;
- (void) appendDebugOutput:(NSString *) output;

- (IBAction) selectedBuildMode:(id) sender;
- (IBAction) selectedCompiler:(id) sender;

@end
