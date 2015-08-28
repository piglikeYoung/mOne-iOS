//
//  JHQuestionInfo.m
//  mOne-iOS
//
//  Created by piglikeyoung on 15/8/28.
//  Copyright (c) 2015年 piglikeyoung. All rights reserved.
//

#import "JHQuestionInfo.h"

@implementation JHQuestionInfo

- (NSString *)description {
    return [NSString stringWithFormat:@"sWebLk = %@, strQuestionId = %@, strQuestionContent = %@, strAnswerTitle = %@, sEditor = %@, strQuestionTitle = %@, strLastUpdateDate = %@, strPraiseNumber = %@, strDayDiffer = %@, strQuestionMarketTime = %@, strAnswerContent = %@.", self.sWebLk, self.strQuestionId, self.strQuestionContent, self.strAnswerTitle, self.sEditor, self.strQuestionTitle, self.strLastUpdateDate, self.strPraiseNumber, self.strDayDiffer, self.strQuestionMarketTime, self.strAnswerContent];
}

@end
