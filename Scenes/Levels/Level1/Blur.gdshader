shader_type canvas_item;

uniform float lod: hint_range(0.0, 5) = 0.0;

void fragment(){
	vec4 color = textureLod(TEXTURE, UV, lod);
	COLOR = color;
}