//
//  ASMOpenDocumentation.m
//  FlashSugar
//
//  Created by Michael Murray on 4/25/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASMOpenDocumentation.h"
#import <EspressoSDK.h>
#import <MRRangeSet.h>


@implementation ASMOpenDocumentation

- (id)initWithDictionary:(NSDictionary *)dictionary bundlePath:(NSString *)bundlePath
{
	self = [super init];
	if (self == nil)
		return nil;
	
	docURL = [[dictionary objectForKey:@"initial-url"] retain];
	
	if(![NSBundle loadNibNamed:@"Documentation" owner:self])
		return nil;
	
		
	return self;
}

- (BOOL)canPerformActionWithContext:(id)context
{
	return ([[context selectedRanges] count] > 0);
}

- (BOOL)performActionWithContext:(id)context error:(NSError **)outError
{
	/*
	NSAlert *sheet = [NSAlert alertWithMessageText:@"Selected File" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"The following file was selected: %@", @"NONE"];
	[sheet beginSheetModalForWindow:[context windowForSheet] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	*/
	
	[docWidnow makeKeyAndOrderFront: nil];
	
	
	//[webView retain];
	//[webView setUIDelegate:self];
	//[webView setFrameLoadDelegate:self];
	//[[webView windowScriptObject] setValue:self forKey:@"ASMOpenDocumentation"];
	
	//[self webViewLoadRequest: @"http://google.com"];
	
	[webView setMainFrameURL:docURL];
	
	/*
	 MRRangeSet *selectedRanges = [[MRRangeSet alloc] initWithRangeValues:[context selectedRanges]];
	 CETextRecipe *recipe = [CETextRecipe textRecipe];
	 
	 // Find all tag name syntax zones
	 SXSelectorGroup *tagSelectors = [SXSelectorGroup selectorGroupWithString:@"tag > name"];
	 SXZone *syntaxRoot = [context syntaxTree].root;
	 for (SXZone *tagZone in [syntaxRoot descendantSelectablesMatchingSelectors:tagSelectors]) {
	 
	 // Replace if the selection is empty, or if the tag name intersects with the selection
	 if ([selectedRanges isEmpty] || [selectedRanges intersectsRange:tagZone.range]) {
	 NSString *replacement = changesToUppercase ? [tagZone.text uppercaseString] : [tagZone.text lowercaseString];
	 [recipe addReplacementString:replacement forRange:tagZone.range];
	 }
	 }
	 
	 // Clean up
	 [selectedRanges release];
	 
	 // Prepare the recipe, or we can't get the number of changes
	 [recipe prepare];
	 if (recipe.numberOfChanges == 0) {
	 NSAlert *sheet = [NSAlert alertWithMessageText:@"Nothing Changed!" defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"No tag names were found that could be changed. Select another piece of text and try again."];
	 [sheet beginSheetModalForWindow:[context windowForSheet] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	 }
	 
	 return [context applyTextRecipe:recipe];
	 */
	
	return YES;
}

-(void) awakeFromNib {
	
	
	
}

- (void) webViewLoadRequest:(NSString *) url {
	
	NSURL *_url = [[NSURL alloc] initWithString:url];
	
	[[webView mainFrame]loadRequest:[NSURLRequest requestWithURL:_url]];
	//[self setAddress:[_url path]];
	[_url release];
}

- (WebView *) webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{   
    // On Javascript window.open, Webkit sends a null request here, then sends a
    // loadRequest: to the new WebView, which will include a
    // decidePolicyForNavigation (which is where we'll open our external
    // window).
    WebView *newWebView = [[[WebView alloc] init] autorelease];
    [newWebView setUIDelegate:self];
    [newWebView setPolicyDelegate:self];
    //[self addPendingWebView:newWebView];
	
	
    return newWebView;
}


- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	
}

// -----------------------------------------
#pragma mark -
#pragma mark Web View

- (BOOL) canGoBack {
	return [webView canGoBack];
}

- (BOOL) canGoForward {
	return [webView canGoForward];
}

- (IBAction) goBack:(id)sender {
	[webView goBack:sender];
}

- (IBAction) goForward:(id)sender {
	[webView goForward:sender];
}

@end