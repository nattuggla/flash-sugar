//
//  ZDActionScript3CS3Compile.m
//  ActionScript3compile
//
//  Created by Mike Murray on 1/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ZDActionScript3Compile.h";
#import <EspressoFileActions.h>
#import <NSString+MRFoundation.h>

@implementation ZDActionScript3Compile


- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	extensions = [[dictionary objectForKey:@"extensions"] retain];
	
	tdictionary = dictionary;
	tbundlePath = bundlePath;
	
	return self;
}

- (void)dealloc
{
	[extensions release];
	extensions = nil;
	
	[super dealloc];
}

- (BOOL)canPerformActionWithContext:(id)context
{
	if (extensions.count == 0)
		return YES;
	else if ([context URLs].count == 0)
		return NO;
	
	BOOL canPerform = YES;
	for (NSURL *fileURL in [context URLs])
		canPerform &= [fileURL.path.pathExtension isEqualToAnyOfStrings:extensions];
	
	return canPerform;
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	
	[[ASMActionScript3Controller alloc] init:tdictionary bundlePath:tbundlePath context:context];
	//[ASMActionScript3Controller release];
	return YES;
}




@end
