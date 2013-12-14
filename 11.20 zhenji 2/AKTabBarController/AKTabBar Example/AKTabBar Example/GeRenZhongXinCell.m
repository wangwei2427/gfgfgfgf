//
//  GeRenZhongXinCell.m
//  龙代驾
//
//  Created by mac on 13-10-24.
//  Copyright (c) 2013年 Ali Karagoz. All rights reserved.
//

#import "GeRenZhongXinCell.h"

@implementation GeRenZhongXinCell
@synthesize imageP;
@synthesize imagePic;
@synthesize imageX;
@synthesize imageXj;
@synthesize labelTime,labelChuFaDi,labelName,labelZhuangTai;



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
