//
//  NSObject+NSCoding.h
//  OpenStack
//
//  Created by Michael Mayo on 3/4/11.
//  The OpenStack project is provided under the Apache 2.0 license.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (NSCoding)

- (void)autoEncodeWithCoder: (NSCoder *)coder;
- (void)autoDecode:(NSCoder *)coder;
- (NSDictionary *)properties;

@end
/*
 对象存储的条件是： 对象需要遵守 NSCoding 协议
 存储的时候需要 调用 encodeWithCoder 方法
 读取的时候需要调用initWithCoder 方法
 [NSKeyedArchiver archiveRootObject:stu toFile:path]; 存储
 NSKeyedUnarchiver unarchiveObjectWithFile:path 读取
 
 
 
 *  将某个对象写入文件时会调用
 *  在这个方法中说清楚哪些属性需要存储
 
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.no forKey:@"no"];->autoEncodeWithCoder
}


 *  从文件中解析对象时会调用
 *  在这个方法中说清楚哪些属性需要存储
 
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.no = [decoder decodeObjectForKey:@"no"];->autoDecode
    }
    return self;
}
 
 此库类似JSONModel  多级model用这个
 */