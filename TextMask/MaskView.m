//
//  MaskView.m
//  TextMask
//
//  Created by ly on 12/25/15.
//  Copyright © 2015 ly. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();

  NSString *text = [NSString stringWithFormat:@"95%%"];
  UIFont *font = [UIFont systemFontOfSize:60.0];
  UIColor *textColor = [UIColor blackColor];


  // Draw a clear background
  [[UIColor clearColor] setFill];
  CGContextFillRect(context, rect);

  // Draw the text
  CGContextSaveGState(context);
  [text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: textColor}];
  CGContextRestoreGState(context);

  // Create an image mask from what we've drawn so far
  CGImageRef alphaMask = CGBitmapContextCreateImage(context);

  // Flush canvas
  [[UIColor redColor] setFill];
  CGContextFillRect(context, rect);

  // Draw the image, clipped by the mask
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, 0.0, rect.size.height);
  CGContextScaleCTM(context, 1.0, -1.0);
  CGContextClipToMask(context, rect, alphaMask);
  CGContextRestoreGState(context);

}

@end
