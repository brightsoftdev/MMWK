//
//  Shader.vsh
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

attribute vec4 position;
uniform vec2 translate;
//attribute vec4 color;
attribute vec2 texture_coord;

varying vec4 colorVarying;
varying vec2 texture_coordVarying;

void main()
{
    gl_Position = position;
    gl_Position.x += translate.x;
    gl_Position.y += translate.y;
	
    //colorVarying = color;
	texture_coordVarying = texture_coord;
}
