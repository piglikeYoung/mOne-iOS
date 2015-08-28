//
//  JHReadingInfo.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHReadingInfo.h"

@implementation JHReadingInfo

- (NSString *)description {
    return [NSString stringWithFormat:@"strContent = %@, sRdNum = %@, strContentId = %@, subTitle = %@, strContDayDiffer = %@, strPraiseNumber = %@, strLastUpdateDate = %@, sGW = %@, sAuth = %@, sWebLk = %@, wImgUrl = %@, strContAuthorIntroduce = %@, strContTitle = %@, sWbN = %@, strContAuthor = %@, strContMarketTime = %@.", self.strContent, self.sRdNum, self.strContentId, self.subTitle, self.strContDayDiffer, self.strPraiseNumber, self.strLastUpdateDate, self.sGW, self.sAuth, self.sWebLk, self.wImgUrl, self.strContAuthorIntroduce, self.strContTitle, self.sWbN, self.strContAuthor, self.strContMarketTime];
}

@end
