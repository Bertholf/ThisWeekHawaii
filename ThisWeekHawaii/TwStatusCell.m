//
//  TwStatusCell.m
//  ThisWeekHawaii
//
//  Created by RISONGHO on 3/20/14.
//  Copyright (c) 2014 RISONGHO. All rights reserved.
//

#import "TwStatusCell.h"
#import "UIImage+fixOrientation.h"


#define IMAGE_SIZE  30

@implementation TwStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellData:(NSMutableDictionary *)dicData {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        m_dicData = [NSMutableDictionary dictionaryWithDictionary:dicData];

        m_imgPhoto = [[UIImageView alloc] init];
        m_imgPhoto.contentMode = UIViewContentModeCenter;

        m_lblUser = [[UILabel alloc] init];
        m_lblUser.lineBreakMode = NSLineBreakByTruncatingTail;
        m_lblUser.numberOfLines = 1;
        m_lblUser.textColor = [UIColor blackColor];
        m_lblUser.font = [UIFont boldSystemFontOfSize:15];

        m_lblCreated = [[UILabel alloc] init];
        m_lblCreated.lineBreakMode = NSLineBreakByTruncatingTail;
        m_lblCreated.numberOfLines = 1;
        m_lblCreated.textColor = [UIColor darkGrayColor];
        m_lblCreated.font = [UIFont systemFontOfSize:14];

        m_lblPost = [[UILabel alloc] init];
        m_lblPost.lineBreakMode = NSLineBreakByWordWrapping;
        m_lblPost.numberOfLines = 0;
        m_lblPost.textColor = [UIColor blackColor];
        m_lblPost.font = [UIFont systemFontOfSize:12];

        m_lblLike = [[UILabel alloc] init];
        m_lblLike.lineBreakMode = NSLineBreakByTruncatingTail;
        m_lblLike.numberOfLines = 1;
        m_lblLike.textColor = [UIColor darkGrayColor];
        m_lblLike.font = [UIFont systemFontOfSize:12];

        m_lblRetweet = [[UILabel alloc] init];
        m_lblRetweet.lineBreakMode = NSLineBreakByTruncatingTail;
        m_lblRetweet.numberOfLines = 1;
        m_lblRetweet.textColor = [UIColor darkGrayColor];
        m_lblRetweet.font = [UIFont systemFontOfSize:12];

        [self setData:dicData];

        [self addSubview:m_imgPhoto];
        [self addSubview:m_lblUser];
        [self addSubview:m_lblCreated];
        [self addSubview:m_lblPost];
        [self addSubview:m_lblLike];
        [self addSubview:m_lblRetweet];
    }
    return self;
}

- (void) setData:(NSMutableDictionary *)dicData {
    NSDictionary *dicUser = [dicData objectForKey:@"user"];
    NSString *strUserName = [dicUser objectForKey:@"name"];
    NSString *strScreenName = [@"@" stringByAppendingString:[dicUser objectForKey:@"screen_name"]];
    NSString *strCreated = [dicData objectForKey:@"created_at"];
    NSArray *aryCreated = [strCreated componentsSeparatedByString:@" "];
    strCreated = [NSString stringWithFormat:@"%@ %@", [aryCreated objectAtIndex:1], [aryCreated objectAtIndex:2]];
    NSString *strProfileImgUrl = [dicUser objectForKey:@"profile_image_url"];
    int nFavariteCnt = [[dicData objectForKey:@"favorite_count"] intValue];
    int nRetweetCnt = [[dicData objectForKey:@"retweet_count"] intValue];
    
    m_lblUser.text = [NSString stringWithFormat:@"%@ %@", strUserName, strScreenName];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM dd"];
    m_lblCreated.text = strCreated;
    m_lblPost.text = [dicData objectForKey:@"text"];
    m_lblLike.text = [NSString stringWithFormat:@"Favorite : %d", nFavariteCnt];
    m_lblRetweet.text = [NSString stringWithFormat:@"Retweet : %d", nRetweetCnt];
    
    UIImage *imgProfile = [dicData objectForKey:@"profile_image"];
    if (imgProfile) {
        m_imgPhoto.image = [imgProfile fixSize:CGSizeMake(IMAGE_SIZE, IMAGE_SIZE)];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strProfileImgUrl]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [dicData setObject:img forKey:@"profile_image"];
                m_imgPhoto.image = [img fixSize:CGSizeMake(IMAGE_SIZE, IMAGE_SIZE)];
            });
        });
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];

    float fSpace = 10.0f, fMinWidth = 80.0f;
    CGRect rcItem;

    m_imgPhoto.frame = CGRectMake(fSpace, fSpace, IMAGE_SIZE, IMAGE_SIZE);

    float fLabelMaxWidth = self.bounds.size.width - fSpace * 3 - IMAGE_SIZE;
    m_lblUser.frame = CGRectMake(fSpace * 2 + IMAGE_SIZE, fSpace, fLabelMaxWidth - fMinWidth, 0);
    [m_lblUser sizeToFit];
    rcItem = m_lblUser.frame;

    m_lblCreated.frame = CGRectMake(self.bounds.size.width - fMinWidth - fSpace, 0, fMinWidth, 0);
    [m_lblCreated sizeToFit];
    rcItem = m_lblCreated.frame;
    rcItem.origin.y = m_lblUser.frame.origin.y + m_lblUser.frame.size.height - rcItem.size.height;
    m_lblCreated.frame = rcItem;

    rcItem = CGRectMake(fSpace * 2 + IMAGE_SIZE, m_lblUser.frame.origin.y + m_lblUser.frame.size.height + fSpace / 2, fLabelMaxWidth, 0);
    m_lblPost.frame = rcItem;
    [m_lblPost sizeToFit];

    rcItem = CGRectMake(self.bounds.size.width - fMinWidth - fSpace, m_lblPost.frame.origin.y + m_lblPost.frame.size.height + fSpace / 2, fMinWidth, 0);
    m_lblRetweet.frame = rcItem;
    [m_lblRetweet sizeToFit];

    rcItem = CGRectMake(m_lblRetweet.frame.origin.x - fMinWidth - fSpace, m_lblRetweet.frame.origin.y, fMinWidth, 0);
    m_lblLike.frame = rcItem;
    [m_lblLike sizeToFit];
}

@end
