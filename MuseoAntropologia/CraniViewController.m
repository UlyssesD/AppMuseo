//
//  CraniViewController.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 17/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "CraniViewController.h"
#import "Constants.h"

//#import "SWRevealViewController.h"

@interface CraniViewController ()

@end



@implementation CraniViewController

@synthesize mesh, camera;
@synthesize skullName;
@synthesize touchLabel;


- (void)viewDidLoad
{

    [super viewDidLoad];
    
    self.title = self.skullName;
    
    //titolo
    CGRect frame = CGRectMake(0, 0, 100, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"STHeitiTC-Light" size:21.0f];
    label.textColor = [UIColor blackColor];
    label.text = self.navigationItem.title;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    //set segmented control
    if ([self.title isEqualToString:Saccop1]) {
        [segmControl insertSegmentWithTitle:@"Sulla Volta" atIndex:3 animated:YES];
    }
    if ([self.title isEqualToString:Saccop2]) {
        [segmControl removeSegmentAtIndex:2 animated:YES];
        [segmControl insertSegmentWithTitle:@"Denti" atIndex:2 animated:YES];
    }
    if ([self.title isEqualToString:Guattari]){
        [segmControl insertSegmentWithTitle:@"Alla Base" atIndex:3 animated:YES];
    }
    if ([self.title isEqualToString:Maiella]) {
        [segmControl removeSegmentAtIndex:2 animated:YES];
    }
    
    
    
    
    [self setSegmControlGenerale];
    
    [segmControl addTarget:self action:@selector(segmPick:) forControlEvents:UIControlEventValueChanged];
    
    
    [textView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"textview_background.png"]]];
    
  
    _backBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    
    self.rotate = true;
    
    panRotation.x = 0.0f;
    panRotation.y = 0.0f;
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    
    doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (handleDoubleTap:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    

    [self.view addGestureRecognizer:panRecognizer];
    [self.view addGestureRecognizer:doubleTapRecognizer];
    
    
    //caricamente mesh e camera
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                              @".5", kNGLMeshKeyNormalize, nil];
    
    NSString *name = [[NSString alloc]initWithFormat:@"%@.obj", self.skullName];
    
    mesh = [[NGLMesh alloc] initWithFile:name settings:settings delegate:nil];
    NGLMaterial *material1 = [NGLMaterial material];
    [material1 setDiffuseColor:nglColorFromUIColor([UIColor colorWithRed:203.0f green:197.0f blue:178.0f alpha:0.9f])];
    [material1 setDiffuseColor:nglColorMake(0.8, 0.74, 0.6, 0.8)];
    [material1 setSpecularColor:nglColorMake(0.0, 0.0, 0.0, 0.5)];
    [mesh setMaterial:material1];
    camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
    [camera translateToX:0 toY:0.17 toZ:1];
    [camera autoAdjustAspectRatio:YES animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dismiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) drawView
{
    if (self.rotate)
        mesh.rotateY += 2;
    
    mesh.rotateY += 2*panRotation.x;
    mesh.rotateX += 2*panRotation.y;
    
    panRotation.x = 0.0f;
    panRotation.y = 0.0f;
    
    [camera drawCamera];
}



- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
		panRotation.x = 0.0f;
		panRotation.y = 0.0f;
		return;
	}
    if ([recognizer state] == UIGestureRecognizerStateChanged)
    {
        touchLabel.hidden = true;
        self.rotate = false;
        panRotation = [recognizer translationInView:self.view];
        [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
       
    }
    if (([recognizer state] == UIGestureRecognizerStateEnded) || ([recognizer state] == UIGestureRecognizerStateCancelled) || ([recognizer state] == UIGestureRecognizerStateFailed))
    {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        printf("%f, %f", finalPoint.x, finalPoint.y);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
    }
}



- (void) handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    if ([recognizer state] == UIGestureRecognizerStateEnded)
    {
        mesh.rotateX = 0;
        mesh.rotateY = 0;
        self.rotate = true;
		return;
	}
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}




-(IBAction)segmPick:(id)sender
{
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                              @".5", kNGLMeshKeyNormalize, nil];
    
    NSString *name = [[NSString alloc]initWithFormat:@"%@.obj", self.skullName];
    
    mesh = [[NGLMesh alloc] initWithFile:name settings:settings delegate:nil];
    
    
    //GENERALE
    [self setSegmControlGenerale];
    
    [self setSegmControlDavanti];
    
    [self setSegmControlDietro];
    
    [self setSegmControlUltimo];
    
    [self updateSegmControl];
    
    camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
    [camera translateToX:0 toY:0.17 toZ:1];
    [camera autoAdjustAspectRatio:YES animated:YES];

    
}



- (void) setSegmControlGenerale
{
    if ([segmControl selectedSegmentIndex]==0) {
        
        if ([self.skullName isEqualToString:Ceprano]) {
            textView.text = CepranoGen;
        }
        if ([self.skullName isEqualToString:Saccop1]) {
            textView.text = Saccop1Gen;
        }
        if ([self.skullName isEqualToString:Saccop2]) {
            textView.text = Saccop2Gen;
        }
        if ([self.skullName isEqualToString:Guattari]) {
            textView.text = GuattariGen;
        }
        if ([self.skullName isEqualToString:Maiella]) {
            textView.text = MaiellaGen;
        }
        
        self.rotate = true;
        
        NGLMaterial *material1 = [NGLMaterial material];
//        [material1 setDiffuseColor:nglColorFromUIColor([UIColor colorWithRed:203.0f green:197.0f blue:178.0f alpha:0.9f])];
        [material1 setDiffuseColor:nglColorFromUIColor([UIColor colorWithRed:189.0f green:173.0f blue:170.0f alpha:0.9f])];
        [mesh setMaterial:material1];
        [material1 setDiffuseColor:nglColorMake(0.8, 0.74, 0.6, 0.8)];
        [material1 setSpecularColor:nglColorMake(0.0, 0.0, 0.0, 0.5)];
        material1.reflectiveLevel = 0.2;
        [mesh compileCoreMesh];
    }

}

- (void) setSegmControlDavanti
{
    if ([segmControl selectedSegmentIndex]==1) {
        
        if ([self.skullName isEqualToString:Ceprano]) {
            textView.text = CepranoDav;
            self.rotate = false;
            mesh.rotateX = 345;
            
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Saccop1]) {
            textView.text = Saccop1Dav;
            self.rotate = false;
            mesh.rotateX = 340;
            mesh.rotateY = 355;
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Saccop2]) {
            textView.text = Saccop2Dav;
            self.rotate = false;
            mesh.rotateX = 10;
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Guattari]) {
            textView.text = GuattariDav;
            self.rotate = false;
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Maiella]) {
            textView.text = MaiellaDav;
            mesh.rotateX = 340;
            mesh.rotateZ = 3;
            self.rotate = false;
            [mesh compileCoreMesh];
        }
    }
//    [self updateSegmControl];
}

-(void) setSegmControlDietro
{
    if ([segmControl selectedSegmentIndex]==2) {
        if ([self.skullName isEqualToString:Ceprano]) {
            textView.text = CepranoDie;
            self.rotate = false;
            mesh.rotateY = 180;
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Saccop1]) {
            textView.text = Saccop1Die;
            self.rotate = false;
            mesh.rotateX = 270;
            mesh.rotateY = 180;
            mesh.rotateZ = 5;
            [mesh compileCoreMesh];

        }
        if ([self.skullName isEqualToString:Saccop2]) {
            textView.text = Saccop2Denti;
            self.rotate = false;
            mesh.rotateX = 315;
            
            [mesh compileCoreMesh];
            
        }
        if ([self.skullName isEqualToString:Guattari]) {
            textView.text = GuattariDie;
            self.rotate = false;
            mesh.rotateX = 25;
            mesh.rotateY = 180;
                        [mesh compileCoreMesh];
        }
    }
//    [self updateSegmControl];

}

-(void) setSegmControlUltimo
{
    if ([segmControl selectedSegmentIndex]==3) {
        if ([self.skullName isEqualToString:Saccop1]) {
            textView.text = Saccop1Volta;
            self.rotate = false;
            mesh.rotateX = 60;
            mesh.rotateY = 70;
            [mesh compileCoreMesh];
        }
        if ([self.skullName isEqualToString:Guattari]) {
            textView.text = GuattariBase;
            self.rotate = false;
            mesh.rotateX = 300;
            mesh.rotateY = 180;
            mesh.rotateZ = 358;
                        [mesh compileCoreMesh];
        }
    }
//    [self updateSegmControl];
}



//aggiorna il segmented control e lo aggiorna cambiando il colore in base alla parte selezionata
-(void) updateSegmControl
{
    NSArray *segmentColors = [[NSArray alloc] initWithObjects:
                              [UIColor whiteColor],
                              [UIColor colorWithRed:0.0f green:151.0f blue:0.0f alpha:0.9f],
                              [UIColor colorWithRed:165.0f green:0.0f blue:0.0f alpha:0.9f],
                              [UIColor colorWithRed: 0.0/255.0 green: 138.0/255.0 blue:242.0/255.0 alpha: 1.0], nil];
    
    UISegmentedControl *betterSegmentedControl = segmControl;
    
    NSUInteger numSegments = [betterSegmentedControl.subviews count];
    for( int i = 0; i < numSegments; i++ ) {
        // reset color
        [[betterSegmentedControl.subviews objectAtIndex:i] setTintColor:nil];
        [[betterSegmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor whiteColor]];
    }
    NSArray *sortedViews = [betterSegmentedControl.subviews sortedArrayUsingFunction:compareViewsByOrigin context:NULL];
    NSInteger selectedIdx = betterSegmentedControl.selectedSegmentIndex;
    [[sortedViews objectAtIndex:selectedIdx] setTintColor:[segmentColors objectAtIndex:selectedIdx]];
    for (id view in betterSegmentedControl.subviews) {
        [view removeFromSuperview];
    }
    for (id view in sortedViews) {
        [betterSegmentedControl addSubview:view];
    }
}

//funzione di supporto per l'aggiornamento del segmented control. non toccare
NSInteger static compareViewsByOrigin(id sp1, id sp2, void *context)
{
    float v1 = ((UIView *)sp1).frame.origin.x;
    float v2 = ((UIView *)sp2).frame.origin.x;
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}



@end
