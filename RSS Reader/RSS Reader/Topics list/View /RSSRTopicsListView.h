//
//  RSSRTopicsListView.h
//  RSS Reader
//
//  Created by Lina Loyko on 11/18/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RSSRTopic;

@protocol RSSRTopicsListView

- (void)setTopics:(NSMutableArray<RSSRTopic *> *)topics;
- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
