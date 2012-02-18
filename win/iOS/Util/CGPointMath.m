//
//  CGPointMath.m
//  NetHack
//
//  Created by Dirk Zimmermann on 1/1/10.
//  Copyright (c) 2011 Dirk Zimmermann. All rights reserved.
//

/*
 * NetHack
 * Copyright (C) 2012  Dirk Zimmermann (me AT dirkz DOT com)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <math.h>

#import "CGPointMath.h"

#define kCos45 (0.707106829f)
#define kCos30 (0.866025404f)

eDirection CGPointDirectionFromUIKitDelta(CGPoint delta) {
    delta.y = -delta.y;
    return CGPointDirectionFromEuclideanDelta(delta);
}

eDirection CGPointDirectionFromEuclideanDelta(CGPoint delta) {
    static CGPoint s_directionVectors[kDirectionMax] = {
        { 0.0f, 1.0f },
        { kCos45, kCos45 },
        { 1.0f, 0.0f },
        { kCos45, -kCos45 },
        { 0.0f, -1.0f },
        { -kCos45, -kCos45 },
        { -1.0f, 0.0f },
        { -kCos45, kCos45 },
    };
    
	CGPointNormalizeLength(&delta);
	for (int i = 0; i < kDirectionMax; ++i) {
		float dotP = CGPointDotProduct(delta, s_directionVectors[i]);
		if (dotP >= kCos30) {
			return i;
		}
	}
	return kDirectionMax;    
}