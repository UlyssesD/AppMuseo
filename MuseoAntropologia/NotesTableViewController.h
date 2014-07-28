//
//  NotesTableViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 28/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol senddataProtocol <NSObject>

-(void)sendDataToA:(NSString *)noteText;

@end

@interface NotesTableViewController : UITableViewController
@property(nonatomic,assign)id delegate;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) NSString* text;
@end
