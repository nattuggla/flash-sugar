//
//  ZDActionScript3CS3Compile.h
//  ActionScript3compile
//
//  Created by Mike Murray on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FSActionBuild : NSObject {
	NSURL *filePath;
	BOOL fileIsActionBuildProject;
	
}

- (void) launchActionBuild;

@end
