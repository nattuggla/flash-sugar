//
//  ZDActionScript3CS3Compile.m
//  ActionScript3compile
//
//  Created by Mike Murray on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASMFlashBuild.h";
#import <EspressoSDK.h>

//#import "BuildController.h";
//#import "ActionBuildController.h"

NSString * const FLASH_CS4	= @"Flash CS4";
NSString * const FLASH_CS3	= @"Flash CS3"; 
NSString * const FLEX3		= @"Flex 3";

NSString * const FLASH_CS4_FLAG		= @"-f";

@implementation ASMFlashBuild


- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	//extensions = [[dictionary objectForKey:@"extensions"] retain];
	
	tdictionary = dictionary;
	tbundlePath = bundlePath;
	
	
	
	
	// Initialization code here.
	
	//controller = cont;
	
	if(![NSBundle loadNibNamed:@"FlashDebugWindow" owner:self])
		return nil;
		
	//[[previewWindow mainFrame]loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
	//task = [[NSTask alloc] init];
	
	//extensions = [[dictionary objectForKey:@"extensions"] retain];
	//compileUsing = [[dictionary valueForKey:@"compile-using"] retain];
	
	compileUsing = FLEX3;
	
	//compilerLocation = [[dictionary valueForKey:@"compiler-location"] retain];
	compilerLocation = @"/Developer/SDKs/flex_sdk_3/bin/mxmlc";
	
	//context = tcontext;
	//pathToBundle = [[NSMutableString alloc] initWithString: bundlePath];
	
	pathToBundle = @"";
	
	//fileToCompile = fileURL;
	
	compileRunning = NO;
	
	outputFile = [[NSString alloc] initWithString:@"<none>"];
	
	return self;
}

- (void)dealloc {
	[extensions release];
	extensions = nil;
	
	[compileTask release];
	[outputFile release];
	
	[super dealloc];
}

- (BOOL)canPerformActionWithContext:(id)context {
	return [[NSFileManager defaultManager] fileExistsAtPath: [[[context documentContext] fileURL] path]];
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError {

	[buildWindow makeKeyAndOrderFront: nil];
	
	[self compileSource: [[[context documentContext] fileURL] path]];
	
	return YES;
}

- (void) compileSource: (NSString *) withFile {
	

	if (compileRunning)  {
        // This stops the task and calls our callback (-processFinished)
        [compileTask stopProcess];
        // Release the memory for this wrapper object
        [compileTask release];
        compileTask=nil;
    }
    else
    {
		fileToCompile = [withFile retain];
		
		//NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
		NSString *fileExtenstion = [fileToCompile pathExtension];
		NSMutableArray *args = [NSMutableArray arrayWithCapacity:3];
		
		
		// First check to see if the file we are going to compile is an ActionScript class
		// or an MXML Application. MXML Applicaitons will be forced to FLEX 3 / 4 SDKs
		
		if([fileExtenstion isEqualToString:@"as"]) {
			
			// If we're using the Flash IDE as out compiler then look for a matching FLA file.
			if([compileUsing isEqualToString:FLASH_CS4] || [compileUsing isEqualToString:FLASH_CS3]) {
				
				NSString *flaFilePath = [fileToCompile stringByReplacingOccurrencesOfString:@".as" withString:@".fla"];
				NSFileManager *fileManager = [[NSFileManager alloc] init];
				
				// See if the .fla file exists and use that instead with Flash IDE to compile
				if([fileManager fileExistsAtPath:flaFilePath]) {
					
					[self appendOutput:@"(Matching (*.FLA) file found, using Flash CS4 to compile)\n"];
					
					// Add in the path to flashcommand (Slightly modified)
					// Thanks MikeChambers
					
					[args addObjectsFromArray:
						[NSArray arrayWithObjects:[tbundlePath stringByAppendingString:@"/Contents/Resources/flashcommand"], 
						@"-e", 
						@"-s", 
						flaFilePath,
						nil]];
					
					//[args addObjectsFromArray:[NSArray arrayWithObjects:compilerLocation,fileToCompile,nil]];
					
					// If were using FLASH CS4 then insert this flag before all the others
					if([compileUsing isEqualToString:FLASH_CS4])
						[args insertObject:@"-f" atIndex:1];
					
					[fileManager release];
				}
				
				// Otherwise were buidling with the Flex SDK or another compiler.
				else {
					[self appendOutput:@"(NO Matching (*.FLA) file found, using Flash Flex SDK to compile)\n"];
					[args addObjectsFromArray:[NSArray arrayWithObjects:compilerLocation,fileToCompile,nil]];
				}
			}
			else {
				[self appendOutput:@"(Compiling this with Flex SDK)\n"];
				[args addObjectsFromArray:[NSArray arrayWithObjects:compilerLocation,fileToCompile,nil]];
			}
			
		} 
		// Are we using the flex 3 SDK?
		else if([compileUsing isEqualToString:FLEX3] || [fileExtenstion isEqualToString:@"mxml"]) {
			[args addObjectsFromArray:[NSArray arrayWithObjects:compilerLocation,fileToCompile,nil]];
		}
		
		
		if (compileTask!=nil)
			[compileTask release];
		
		
		// Run the task!
		compileTask=[[TaskWrapper alloc] initWithController:self arguments:args];
		[compileTask startProcess];
		
		[fileToCompile release];
	}

}

- (void) setOutput:(NSString *)output {
	[self setDebugOutput:output];
}
- (void) appendOutput:(NSString *)output {
	[self appendDebugOutput:output];
}


- (void) processStarted {
	compileRunning = YES;
	
	[self setOutput:@"Build Started\n\n"];
	[self appendOutput:tbundlePath];
}

- (void)processFinished {
	
	outputFile = [fileToCompile stringByReplacingOccurrencesOfString:[fileToCompile pathExtension] withString:@"swf"];
	
	//[controller runOutput:outputFile];
	compileRunning = NO;
	
	[self appendOutput:@"\n\nBuild Completed\n\nOutput File:  "];
	[self appendOutput:outputFile];
}
	
////////////////////////////////////
	
#pragma mark -
#pragma mark Build Controller 
	
- (void) setDebugOutput:(NSString *) output {	
	[[[debugOutputText textStorage] mutableString] setString:output];
}

- (void) appendDebugOutput:(NSString *) output {
	[[[debugOutputText textStorage] mutableString] appendString:output];
}

- (void) buildStarted {
	
}

- (void) buildFinished {
	
}

- (void) runOutput: (NSString *) file {
	//[self webViewLoadRequest:file];
}

////////////////////////////////////

#pragma mark -
#pragma mark Actions

- (IBAction) selectedBuildMode:(id) sender {
	//buildMode = [sender titleOfSelectedItem];
}
- (IBAction) selectedCompiler:(id) sender {
	
	NSString *compilerName =[sender titleOfSelectedItem];
	
	compileUsing = compilerName;
}

@end

