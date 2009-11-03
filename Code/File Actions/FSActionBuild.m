//
//  ZDActionScript3CS3Compile.m
//  ActionScript3compile
//
//  Created by Mike Murray on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FSActionBuild.h";
#import <EspressoSDK.h>

@implementation FSActionBuild


- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	fileIsActionBuildProject = NO;
	
	return self;
}

- (void)dealloc {
	
	
	[super dealloc];
}

- (BOOL)canPerformActionWithContext:(id)context {
	
	//[[NSFileManager defaultManager] fileExistsAtPath: [[[context documentContext] fileURL] path]];
	
	filePath = [[context documentContext] fileURL];
	
	NSString *pathExtension = [[[[context documentContext] fileURL] path] pathExtension];
	
	if([pathExtension isEqual:@"as"] || [pathExtension isEqual:@"mxml"]) {
		
		fileIsActionBuildProject = NO;
		
		return YES;
	} else if ([pathExtension isEqual:@"abproj"]) {
		
		fileIsActionBuildProject = YES;
		
		return YES;
	}
	
	return NO;
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError {
	
	[self launchActionBuild];
	
	return YES;
}

- (void) launchActionBuild
{
    
	NSDictionary* errorDict;
    NSAppleEventDescriptor* returnDescriptor = NULL;
	NSAppleScript* scriptObject;
	NSString *script;
	
	if(fileIsActionBuildProject) {
		
		NSString *path = [filePath path];
		
		
		script = [NSString stringWithFormat:@"\
							set filepath to (\"%@\")\n\
							set filepath to POSIX path of filepath\n\
							set qtfilepath to quoted form of filepath\n\
							try\n\
							set command to \"open \" & qtfilepath\n\
							do shell script command\n\
							end try\n\
							tell application \"ActionBuild\" to activate\n\
							tell application \"System Events\"\n\
							tell process \"ActionBuild\"\n\
							key down command\n\
							delay 0.2\n\
							keystroke return\n\
							key up command\n\
							end tell\n\
							end tell", path];
		
	} else {
		script = @"\
		tell application \"ActionBuild\" to activate\n\
		tell application \"System Events\"\n\
		tell process \"ActionBuild\"\n\
		key down command\n\
		delay 0.2\n\
		keystroke return\n\
		key up command\n\
		end tell\n\
		end tell";
	}

	
    scriptObject = [[NSAppleScript alloc] initWithSource:script];
	
    returnDescriptor = [scriptObject executeAndReturnError: &errorDict];
    [scriptObject release];
	
    if (returnDescriptor != NULL)
    {
        // successful execution
        if (kAENullEvent != [returnDescriptor descriptorType])
        {
            // script returned an AppleScript result
            if (cAEList == [returnDescriptor descriptorType])
            {
				// result is a list of other descriptors
            }
            else
            {
                // coerce the result to the appropriate ObjC type
            }
        }
    }
    else
    {
        // no script result, handle error here
    }
}

@end

