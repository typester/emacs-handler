#import <Cocoa/Cocoa.h>

@interface App : NSObject {
    NSString *path;

    IBOutlet NSWindow *prefPanel;
    IBOutlet NSTextField *textField;
}

-(IBAction)showPrefPanel:(id)sender;
-(IBAction)applyChange:(id)sender;

@end
