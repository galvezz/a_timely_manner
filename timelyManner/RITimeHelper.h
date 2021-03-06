//
//  RITimeHelper.h
//  timelyManner
//
//  Created by Dan Vingo on 7/16/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kHoursMinutesSeconds, /* 4h3m2s       */
    kstartEndHours,       /* 9:34 - 10:34 */
    kstopWatch            /* 03:23:13     */
} TimeFormatEnum;

@interface RITimeHelper : NSObject

+ (RITimeHelper *)sharedInstance;
- (NSString *)timeBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate withFormat:(TimeFormatEnum)timeFormat;
- (NSString *)dateStringFromDate:(NSDate *)date;
- (NSString *)timeFormatFromSeconds:(NSInteger)seconds;

@end
