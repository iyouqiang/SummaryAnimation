//
//  UIBezierPath+YQWriteBezier.m
//  SummaryAnimation
//
//  Created by chmtech003 on 16/8/6.
//  Copyright © 2016年 gongyouqiang. All rights reserved.
//

#import "UIBezierPath+YQWriteBezier.h"
#import <CoreText/CoreText.h>
@implementation UIBezierPath (YQWriteBezier)

+ (UIBezierPath *)iyqBezierPathWithText:(NSString *)text attributes:(NSDictionary *)attrs
{
    NSAssert(text!= nil && attrs != nil, @"参数不能为空 ");

    NSAttributedString *attrStrs = [[NSAttributedString alloc] initWithString:text
                                                                   attributes:attrs];
    CGMutablePathRef paths = CGPathCreateMutable();
    CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)attrStrs);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);

    for (CFIndex runIndex = 0; runIndex < CFArrayGetCount(runArray); runIndex++)
    {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);

        for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
        {
            CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
            CGGlyph glyph;
            CGPoint position;
            CTRunGetGlyphs(run, thisGlyphRange, &glyph);
            CTRunGetPositions(run, thisGlyphRange, &position);
            {
                CGPathRef path = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                CGAffineTransform t = CGAffineTransformMakeTranslation(position.x, position.y);
                CGPathAddPath(paths, &t,path);
                CGPathRelease(path);
            }
        }
    }
    CFRelease(line);

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path appendPath:[UIBezierPath bezierPathWithCGPath:paths]];

    CGPathRelease(paths);
    
    return path;
    
}


@end
