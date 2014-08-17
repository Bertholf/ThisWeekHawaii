//
//  TwStatusCell.h
//  ThisWeekHawaii
//
//  Created by RISONGHO on 3/20/14.
//  Copyright (c) 2014 RISONGHO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwStatusCell : UITableViewCell {
    UIImageView *m_imgPhoto;
    UILabel *m_lblUser;
    UILabel *m_lblCreated;
    UILabel *m_lblPost;
    UILabel *m_lblLike;
    UILabel *m_lblRetweet;
    NSMutableDictionary *m_dicData;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellData:(NSMutableDictionary *)dicData;

- (void) setData:(NSMutableDictionary *)dicData;

@end
