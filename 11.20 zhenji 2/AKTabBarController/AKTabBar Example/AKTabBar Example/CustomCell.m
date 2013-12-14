//
//  CustomCell.m
//  CustomCell
//
//  Created by mac on 13-10-21.
//  Copyright (c) 2013年 龙代驾. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize imageV;
@synthesize imageXJ;
@synthesize labelPhone,labelPingJia,labelTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
