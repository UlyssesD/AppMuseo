//
//  PageContentViewController.h
//  MuseoAntropologia
//
//  Created by Ulysses D. on 09/09/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end
