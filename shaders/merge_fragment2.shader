#version 300 es
#  ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#  else
precision mediump float;
#  endif

uniform sampler2D C0; // TEXTURE2 - opaque color map (minormode 4)
uniform sampler2D C1; // TEXTURE4 - color map for transparency render 1 (minormode 6)
uniform vec2 canvas_size;

out vec4 output_color;   

void main(void) {
    // need to combine colors from C0 and C1
    // This is used with mobile devices that have few texture image units.
    vec2 loc = vec2( gl_FragCoord.x/canvas_size.x, gl_FragCoord.y/canvas_size.y);
    vec4 c0 = texture(C0, loc);
    vec4 c1 = texture(C1, loc); 
    
    vec3 mcolor = c1.rgb*c1.a + (1.0-c1.a)*c0.rgb;
    output_color = vec4 (mcolor, 1.0);
}
