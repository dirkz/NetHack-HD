//
//  CGPointMath.h
//  NetHack
//
//  Created by Dirk Zimmermann on 6/27/11.
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

typedef enum _eDirection {
	kDirectionUp, kDirectionUpRight, kDirectionRight, kDirectionDownRight,
	kDirectionDown, kDirectionDownLeft, kDirectionLeft, kDirectionUpLeft,
	kDirectionMax
} eDirection;

static inline CGPoint CGPointSum(const CGPoint v1, const CGPoint v2) {
	return CGPointMake(v1.x+v2.x, v1.y+v2.y);
}

static inline CGPoint CGPointDelta(const CGPoint v1, const CGPoint v2) {
	return CGPointMake(v1.x-v2.x, v1.y-v2.y);
}

static inline float CGPointLength(const CGPoint v) {
	return sqrtf(v.x * v.x + v.y * v.y);
}

static inline float CGPointDotProduct(const CGPoint v1, const CGPoint v2) {
	return v1.x * v2.x + v1.y * v2.y;
}

static inline void CGPointNormalizeLength(CGPoint *v) {
	float l = CGPointLength(*v);
	v->x /= l;
	v->y /= l;
}

// x grows to the right, y to the bottom
eDirection CGPointDirectionFromUIKitDelta(CGPoint delta);

// x grows to the right, y to the top
eDirection CGPointDirectionFromEuclideanDelta(CGPoint delta);

