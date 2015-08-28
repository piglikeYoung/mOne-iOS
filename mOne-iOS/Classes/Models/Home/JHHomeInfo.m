//
//  JHHomeInfo.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHHomeInfo.h"

@implementation JHHomeInfo

- (NSString *)description {
    return [NSString stringWithFormat:@"strLastUpdateDate = %@, strDayDiffer = %@, strHpId = %@, strHpTitle = %@, strThumbnailUrl = %@, strOriginalImgUrl = %@, strAuthor = %@, strContent = %@, strMarketTime = %@, sWebLk = %@, strPn = %@, wImgUrl = %@.", self.strLastUpdateDate, self.strDayDiffer, self.strHpId, self.strHpTitle, self.strThumbnailUrl, self.strOriginalImgUrl, self.strAuthor, self.strContent, self.strMarketTime, self.sWebLk, self.strPn, self.wImgUrl];
}

@end
