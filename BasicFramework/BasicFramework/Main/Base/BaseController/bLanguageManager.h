//
//  bLanguageManager.h
//  BasicFramework
//
//  Created by mr-tech on 16/11/2.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ChangeLanguageNotificationName @"changeLanguage"
#define kLocalizedString(key, comment) [kLanguageManager localizedStringForKey:key value:comment]

@interface bLanguageManager : NSObject
@property (nonatomic,copy) void (^completion)(NSString *currentLanguage);

- (NSString *)currentLanguage; //当前语言
- (NSString *)languageFormat:(NSString*)language;
- (void)setUserlanguage:(NSString *)language;//设置当前语言

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value;

- (UIImage *)ittemInternationalImageWithName:(NSString *)name;

+ (instancetype)shareInstance;

#define kLanguageManager [bLanguageManager shareInstance]
@end
