//
//  CraniViewController.h
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 17/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NinevehGL/NinevehGL.h>


@interface CraniViewController : UIViewController <NGLViewDelegate, UIGestureRecognizerDelegate>
{
   // NGLMesh *mesh;
   // NGLCamera *camera;
    UIPanGestureRecognizer *panRecognizer;
    UITapGestureRecognizer *doubleTapRecognizer;
    CGPoint panRotation;
    
    IBOutlet UITextView *textView;
    IBOutlet UISegmentedControl *segmControl;
    
}

@property (strong, nonatomic) NGLMesh *mesh;
@property (strong, nonatomic) NGLCamera *camera;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButton;
@property (nonatomic) bool rotate;
@property (nonatomic, retain) NSString *skullName;

@property (weak, nonatomic) IBOutlet UILabel *touchLabel;



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

- (void)handlePan:(UIPanGestureRecognizer *)recognizer;

- (void) handleDoubleTap:(UITapGestureRecognizer *)recognizer;



@end
