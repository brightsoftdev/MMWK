//
//  Shader.vsh
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

attribute vec2 position;
uniform vec2 translate;
uniform vec2 scale;
//attribute vec4 color;
attribute vec2 texture_coord;

varying vec4 colorVarying;
varying vec2 texture_coordVarying;

void main()
{
	mat2 scaleMat = mat2(scale.x, 0.0, 0.0, scale.y);
    gl_Position = vec4(scaleMat * position, 0.0, 1.0);
	
    gl_Position.x += translate.x;
    gl_Position.y += translate.y;
	
    //colorVarying = color;
	texture_coordVarying = texture_coord;
}
