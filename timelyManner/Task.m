//
//  Task.m
//  timelyManner
//
//  Created by Dan Vingo on 7/15/13.
//  Copyright (c) 2013 Rhombus Inc. All rights reserved.
//

#import "Task.h"
#import "Instance.h"


@implementation Task

@dynamic avgTime;
@dynamic lastRun;
@dynamic name;
@dynamic taskType;
@dynamic instances;
@dynamic activeInstances;
@dynamic createdAt;

- (BOOL)isTripTask {
    return [self.taskType intValue] == kTripTask;
}

- (BOOL)isStopWatchTask {
    return [self.taskType intValue] == kStopWatchTask;
}

/**
 * Updates the lastRun for this task to the most recent of its instances end date.
 */
- (void)updateLastRun {
    if (self.instances.count == 0) {
        return;
    }
    
    // Sort instances by end date
    NSArray *tempInstances = [self.instances allObjects];
    NSArray *sortedInstances = [tempInstances sortedArrayUsingComparator:^(id obj1, id obj2) {
        Instance *instOne = (Instance *)obj1;
        Instance *instTwo = (Instance *)obj2;
        NSDate *firstEndDate = instOne.end;
        NSDate *secondEndDate = instTwo.end;
        if (firstEndDate == nil) {
            // The second date is later in time than nil
            return NSOrderedDescending;
        }
        if (secondEndDate == nil) {
            // The first date is later in time than nil
            return NSOrderedAscending;
        }
        return [firstEndDate compare:secondEndDate];
    }];
    NSDateFormatter *f = [NSDateFormatter new];
    f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.lastRun = (NSDate *)((Instance *)[sortedInstances objectAtIndex:0]).end;
}

- (NSInteger)averageInstanceTime {
    if (self.instances.count == 0) {
        return 0;
    }
    double total = 0.0f;
    int numInstances = 0;
    for (Instance *instance in self.instances) {
        if (instance.end) {
            numInstances++;
            total += [instance elapsedTimeInSeconds];
        }
    }
    if (numInstances == 0) {
        return 0;
    }
    int returnVal = (int)(total / (float)numInstances);
    return returnVal;
}

@end
