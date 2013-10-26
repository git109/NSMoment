/*
 * NSMoment.m
 *
 * Copyright 2013 Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "NSMoment.h"

@interface NSMoment ()
@property (nonatomic, strong) NSDate *date;

@end

@implementation NSMoment

- (id)init
{
    return [self initWithDate:[NSDate date]];
}

+ (id)now
{
    return [[self alloc] init];
}

#pragma mark -

- (id)initWithDate:(NSDate *)date
{
    if ((self = [super init]))
    {
        _date = date;
    }
    return self;
}

+ (id)momentWithDate:(NSDate *)date
{
    return [[self alloc] initWithDate:[NSDate date]];
}

#pragma mark -

- (id)initWithDateAsString:(NSString *)dateAsString
{
    if ((self = [super init]))
    {
        NSDataDetector *detector    = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
        NSTextCheckingResult *match = [detector firstMatchInString:dateAsString options:0 range:NSMakeRange(0, [dateAsString length])];

        if (match)
        {
            _date = match.date;
        }
    }
    
    return self;
}

+ (id)momentWithDateAsString:(NSString *)dateAsString
{
    return [[self alloc] initWithDateAsString:dateAsString];
}

#pragma mark -

- (id)initWithDateAsString:(NSString *)dateAsString format:(NSString *)dateFormat
{
    NSString *localeIdentifier =[[NSLocale currentLocale] identifier];
    
    return [self initWithDateAsString:dateAsString format:dateFormat localeIdentifier:localeIdentifier];
}

+ (id)momentWithDateAsString:(NSString *)dateAsString format:(NSString *)dateFormat
{
    return [[self alloc] initWithDateAsString:dateAsString format:dateFormat];
}

#pragma mark -

- (id)initWithDateAsString:(NSString *)dateAsString format:(NSString *)dateFormat localeIdentifier:(NSString *)localeIdentifier
{
    if ((self = [super init]))
    {
        NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
        formatter.locale            = [NSLocale localeWithLocaleIdentifier:localeIdentifier];
        formatter.dateFormat        = dateFormat;
        
        _date                       = [formatter dateFromString:dateAsString];
    }
    return self;
}

+ (id)momentWithDateAsString:(NSString *)dateAsString format:(NSString *)dateFormat localeIdentifier:(NSString *)localeIdentifier
{
    return [[self alloc] initWithDateAsString:dateAsString format:dateFormat localeIdentifier:localeIdentifier];
}

#pragma mark -

- (NSString *)description
{
    return [self format];
}

#pragma mark - Public Methods

#pragma mark Representing Moments as Strings

- (NSString *)format
{
    return [self format:NSMomentIso8601Format];
}

- (NSString *)format:(NSString *)dateFormat
{
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    formatter.locale            = [NSLocale currentLocale];
    formatter.dateFormat        = dateFormat;

    return [formatter stringFromDate:_date] ?: @"Invalid Date";
}

#pragma mark Validating Moments

- (BOOL)isValid
{
    return (_date != nil);
}

#pragma mark Converting Moments

- (NSDate *)toDate
{
    return _date;
}

#pragma mark Working with Moments

#pragma mark - Private Methods

@end
