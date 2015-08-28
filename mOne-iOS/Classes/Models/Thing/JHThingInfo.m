//
//  JHThingInfo.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHThingInfo.h"

@implementation JHThingInfo
- (NSString *)description {
    return [NSString stringWithFormat:@"strLastUpdateDate = %@, strPn = %@, strBu = %@, strTm = %@, strWu = %@, strId = %@, strTt = %@, strTc = %@.", self.strLastUpdateDate, self.strPn, self.strBu, self.strTm, self.strWu, self.strId, self.strTt, self.strTc];
}
@end
