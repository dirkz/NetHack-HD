//
//  MainViewController.m
//  NetHack
//
//  Created by Dirk Zimmermann on 2/1/12.
//  Copyright (c) 2012 Dirk Zimmermann. All rights reserved.
//

#include <sys/stat.h> // mkdir()

#import "MainViewController.h"

#import "RoguelikeTextView.h"
#import "NHYNQuestion.h"
#import "NHHandler.h"
#import "GlobalConfig.h"
#import "NHMessageWindow.h"
#import "Tileset.h"
#import "MapView.h"
#import "NHStatusWindow.h"

extern int unix_main(int argc, char **argv);

@interface MainViewController () {
    
    IBOutlet UITextView *messageView;
    IBOutlet UILabel *statusLine1;
    IBOutlet UILabel *statusLine2;
    RoguelikeTextView *dummyTextView;
    NSThread *netHackThread;
    Tileset *tileset;
    
}

@property (nonatomic, retain) NHYNQuestion *currentYNQuestion;

- (void)netHackMainLoop:(id)arg;
- (void)addMessageLineString:(NSString *)line;

@end

@implementation MainViewController

@synthesize currentYNQuestion;

- (void)awakeFromNib {
    tileset = [[Tileset alloc] initWithName:@"Vanilla Tiles 16x16.png" tileSize:CGSizeMake(16.f, 16.f)];
}

- (void)dealloc {
    [tileset release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    dummyTextView = [[RoguelikeTextView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:dummyTextView];
    dummyTextView.delegate = self;
    [dummyTextView release];
    
    [[GlobalConfig sharedInstance] setObject:self forKey:kNHHandler];
    
	netHackThread = [[NSThread alloc] initWithTarget:self selector:@selector(netHackMainLoop:) object:nil];
	[netHackThread start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - NetHack main loop

- (void)netHackMainLoop:(id)arg {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
#ifdef SLASHEM
	char *argv[] = {
		"SlashEM",
	};
#else
	char *argv[] = {
		"NetHack",
	};
#endif
	int argc = sizeof(argv)/sizeof(char *);
	
	// create necessary directories
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *baseDirectory = [paths objectAtIndex:0];
	DLog(@"baseDir %@", baseDirectory);
	setenv("NETHACKDIR", [baseDirectory cStringUsingEncoding:NSASCIIStringEncoding], 1);
	//setenv("SHOPTYPE", "G", 1); // force general stores on every level in wizard mode
	NSString *saveDirectory = [baseDirectory stringByAppendingPathComponent:@"save"];
	mkdir([saveDirectory cStringUsingEncoding:NSASCIIStringEncoding], 0777);
	
	// show directory (for debugging)
#if 0	
	for (NSString *filename in [[NSFileManager defaultManager] enumeratorAtPath:baseDirectory]) {
		DLog(@"%@", filename);
	}
#endif
	
	// call it
	unix_main(argc, argv);
	
	// clean up thread pool
	[pool drain];
}

#pragma mark - Internal API

- (void)addMessageLineString:(NSString *)line {
    NSRange selectedRange = NSMakeRange(0, 0);
    if ([messageView hasText]) {
        NSString *content = [NSString stringWithFormat:@"%@\n%@", messageView.text, line];
        messageView.text = content;
        selectedRange.location = content.length - line.length;
    } else {
        messageView.text = line;
    }
    messageView.selectedRange = selectedRange;
}

#pragma mark - NHHandler

- (void)handleYNQuestion:(NHYNQuestion *)question {
    self.currentYNQuestion = question;
    [self addMessageLineString:question.question];
    [dummyTextView becomeFirstResponder];
}

- (void)handleMenuWindow:(NHMenuWindow *)w {
    
}

- (void)handleRawPrintWithMessageWindow:(NHMessageWindow *)w {
    
}

- (void)handleMessageWindow:(NHMessageWindow *)w shouldBlock:(BOOL)b {
    if (w.numberOfMessages) {
        NSArray *lines = w.messageStrings;
        for (NSString *line in lines) {
            [self addMessageLineString:line];
        }
    }
}

- (void)handlePoskey:(NHPoskey *)p {
    
}

- (void)handleMapWindow:(NHMapWindow *)w shouldBlock:(BOOL)b {
    ((MapView *) self.view).map = w;
    ((MapView *) self.view).tileset = tileset;
    [self.view setNeedsDisplay];
}

- (void)handleStatusWindow:(NHStatusWindow *)w {
    statusLine1.text = [w messageStringAtIndex:0];
    statusLine2.text = [w messageStringAtIndex:1];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (text.length == 1) {
        char c = [text characterAtIndex:0];
        if (self.currentYNQuestion) {
            currentYNQuestion.choice = c;
            [currentYNQuestion signal];
            self.currentYNQuestion = nil;
        }
    }
    return NO;
}

@end
