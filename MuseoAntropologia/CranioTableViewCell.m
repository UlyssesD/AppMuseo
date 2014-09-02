//
//  CranioTableViewCell.m
//  MuseoAntropologia
//
//  Created by Andrea Novelli on 20/07/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "CranioTableViewCell.h"

@implementation CranioTableViewCell

@synthesize lockImg;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
