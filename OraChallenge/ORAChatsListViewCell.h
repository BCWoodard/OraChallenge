//
//  ORAChatsListViewCell.h
//  OraChallenge
//
//  Created by Brad Woodard on 7/31/16.
//  Copyright © 2016 elementC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ORAChatsListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestMsgOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
