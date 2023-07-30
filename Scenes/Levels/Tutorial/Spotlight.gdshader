shader_type canvas_item;

uniform float circle_size : hint_range(0.0, 2.0);
uniform float screen_width;
uniform float screen_height;
uniform vec2 circle_position;
uniform float normal_alpha : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	float ratio = screen_width / screen_height;
	float dist = distance(circle_position, vec2(mix(0.5, UV.x, ratio), UV.y));
	COLOR.a = min(step(circle_size, dist), normal_alpha);
}