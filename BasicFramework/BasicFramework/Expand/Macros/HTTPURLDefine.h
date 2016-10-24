//
//




#pragma mark -  * * * * * * * * * * * * * * 域名切换 * * * * * * * * * * * * * *

#define ENVIRONMENT 0

#if ENVIRONMENT == 0

/**
 *  域名
 *
 *  @param 开发环境
 *
 */
#define YGBaseURL  @"http://"
#define YGBaseURL2 @"http://pic1.5442.com/2013/0830/05/02.jpg"
#define YGBaseURL1 @"http://pic1.5442.com/2013/0830/05/01.jpg"
#define YGBaseURL3 @"http://pic1.5442.com/2013/0830/05/03.jpg"
#define YGBaseURL4 @"http://pic1.5442.com/2013/0830/05/04.jpg"

#elif ENVIRONMENT ==1

/**
 *  域名
 *
 *  @param 测试环境
 *
 */
#define YGBaseURL @"http://"

#elif ENVIRONMENT ==2

/**
 *  域名
 *
 *  @param 正式环境
 *
 */
#define YGBaseURL @"http://"


#endif /* HTTPURLDefine_h */

#pragma mark -  * * * * * * * * * * * * * * 首页 URL * * * * * * * * * * * * * *



#pragma mark -  * * * * * * * * * * * * * * User URL * * * * * * * * * * * * * *




































