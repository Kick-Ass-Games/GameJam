shader_type canvas_item;

uniform float vp : hint_range(0.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec3 blue_tint = vec3(0.2, 0.2, 1.0); // adjust to taste
    tex_color.rgb = mix(tex_color.rgb, blue_tint, vp);
    COLOR = tex_color;
}
