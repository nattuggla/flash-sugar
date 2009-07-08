//
//  ASMActionScript3ObjectTagItem.m
//  ExampleSugar
//

#import "ASMActionScript3ObjectTagItem.h"


//
// Example item; open a HTML file to see it in action
//
@implementation ASMActionScript3ObjectTagItem

- (void)initializeWithCapturedZones:(NSDictionary *)captures recipeInfo:(NSDictionary *)recipeInfo
{
	[super initializeWithCapturedZones:captures recipeInfo:recipeInfo];
	
	name = [[[captures objectForKey:@"name"] text] retain];
}

- (void)dealloc
{
	[name release];
	name = nil;
	[super dealloc];
}

- (BOOL)transformIntoItem:(ASMActionScript3ObjectTagItem *)otherItem
{
	// Note: the passed argument can actually be any item class, but casting it to this specific class makes it easy to write the transformation code. The default (super) implementation takes care of checking the class, so this is perfectly valid.
	if (![super transformIntoItem:otherItem])
		return NO;
	
	// Clean up our own old values
	[name release];
	name = nil;
	
	// Take over the new values from the other item
	name = [otherItem->name retain];
	//name = [[NSBundle mainBundle] resourcePath];
	
	return YES;
}

- (BOOL)isDecorator
{
	return YES;
}

- (CEItemDecorationType)decorationType
{
	return 0;
}

- (NSColor *)backgroundColor
{
	return [NSColor new];
}

- (NSImage *)image {
	//NSString* imagePath = @"~/Library/Application Support/Espresso/Sugars/ActionScript3.sugar/Contents/Resources/box.png";
	
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"package" ofType:@"png"];
	NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
	[image autorelease];
	
	return image;
}

- (BOOL)isTextualizer
{
	return YES;
}

- (NSString *)title
{
	if([name length] < 1)
		name = @"Top Level";
	return @"{...}";
	
}

@end
