//
//  ASMActionScript3Controller.m
//  ActionScript3Sugar
//
//  Created by Michael Murray on 3/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASMActionScript3Controller.h"


NSString * const FlashCS4 = @"cs4";
NSString * const FlashCS3 = @"cs3"; 
NSString * const MXMLC    = @"mxmlc";

@implementation ASMActionScript3Controller

- (id)init:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath context:(id)tcontext {
	
	self = [super init];
	if (self == nil)
		return nil;
	
	task = [[NSTask alloc] init];
	
	extensions = [[dictionary objectForKey:@"extensions"] retain];
	compileUsing = [[dictionary valueForKey:@"compile-using"] retain];
	
	compilerLocation = [[dictionary valueForKey:@"compiler-location"] retain];
	
	context = tcontext;
	pathToBundle = [[NSMutableString alloc] initWithString: bundlePath];
	
	compileRunning = NO;
	
	[self open];
	
	return self;
}

- (void)open {
	if(!outputWindow) {
		[NSBundle loadNibNamed:@"FlashDebugWindow" owner:self];
		[outputWindow showWindow: self];
	}
	
	//[[[outputWindowText textStorage] mutableString] appendString:@"Click Build to star compiling.\n"];
	[self compileSource];
}

- (IBAction)compile:sender {
	[self compileSource];
}
	
- (void) compileSource {

	if (compileRunning)  {
        // This stops the task and calls our callback (-processFinished)
        [compileTask stopProcess];
        // Release the memory for this wrapper object
        [compileTask release];
        compileTask=nil;
    }
    else
    {
		
		
		// Get the file URL
		NSURL *fileToCompileURL = (NSURL*)[[context URLs] objectAtIndex:0];
		NSString *fileToCompile = fileToCompile = [fileToCompileURL path];
		
		//[self setOutput:flaFilePath];		
		
		if([[fileToCompile pathExtension] isEqualToString:@"as"]) {
			
			NSString *flaFilePath = [fileToCompile stringByReplacingOccurrencesOfString:@".as" withString:@".fla"];
			NSFileManager *fileManager = [[NSFileManager alloc] init];
			
			// See if the .fla file exists and use that instead with Flash IDE to compile
			if([fileManager fileExistsAtPath:flaFilePath]) {
				
				[self appendOutput:@"(Matching (*.FLA) file found, using Flash CS4 to compile)\n"];
				
				fileToCompile = flaFilePath;
				compileUsing = FlashCS4;
			}
		}
		NSArray *args;
				
		
		if ([compileUsing isEqualToString: FlashCS3]) {
			
			args = [NSArray arrayWithObjects:@"~/Library/Application Support/Espresso/Sugars/ActionScript3.sugar/Contents/Resources/flashcommand", @"-e", @"-s", fileToCompile,nil];
			[self appendOutput:@"Compiling with Flash CS3\n\n-----------------\n"];

		} else if([compileUsing isEqualToString: FlashCS4]) {
			
			args = [NSArray arrayWithObjects:@"~/Library/Application Support/Espresso/Sugars/ActionScript3.sugar/Contents/Resources/flashcommand", @"-f", @"-e", @"-s", fileToCompile,nil];
			[self appendOutput: @"Compiling with Flash CS4\n\n-----------------\n"];
			
		} else if([compileUsing isEqualToString: MXMLC]) {
			
			args = [NSArray arrayWithObjects:compilerLocation,fileToCompile,nil];
			[self appendOutput: @"Compiling with MXMLC\n\n-----------------\n"];
		} else {
			[self setOutput:@"Something went wrong... Did you modify the Sugar??"];
		}
		
		if (compileTask!=nil)
			[compileTask release];
		
		
		
		compileTask=[[TaskWrapper alloc] initWithController:self arguments:args];
		[compileTask startProcess];

	
	}
	
	
	
}

- (void)setOutput:(NSString *)output {
	[[[outputWindowText textStorage] mutableString] setString:output];
}

- (void)appendOutput:(NSString *)output {
	[[[outputWindowText textStorage] mutableString] appendString:output];
	[[[outputWindowText textStorage] mutableString] appendString:@"\n"];
	
}

- (void)processStarted {
	compileRunning = YES;
}

- (void)processFinished {
	compileRunning = NO;
}

@end
