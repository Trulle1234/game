shader_type canvas_item;

uniform bool active = false;

const vec3 palette[7] = vec3[](
    vec3(31.0/255.0, 28.0/255.0, 44.0/255.0),   // #1f1c2c
    vec3(110.0/255.0, 93.0/255.0, 113.0/255.0), // #6e5d71
    vec3(211.0/255.0, 180.0/255.0, 141.0/255.0),// #d3b48d
    vec3(227.0/255.0, 200.0/255.0, 140.0/255.0),// #e3c88c
    vec3(201.0/255.0, 116.0/255.0, 106.0/255.0),// #c9746a
    vec3(217.0/255.0, 157.0/255.0, 72.0/255.0), // #d99d48
    vec3(139.0/255.0, 90.0/255.0, 64.0/255.0)   // #8b5a40
);

vec3 nearest_palette_color(vec3 color) {
    float best_dist = 99999.0;
    vec3 best_color = color;

    for (int i = 0; i < 6; i++) {
        float d = distance(color, palette[i]);
        if (d < best_dist) {
            best_dist = d;
            best_color = palette[i];
        }
    }
    return best_color;
}

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec3 base_color = tex.rgb;

    if (active) {
        vec3 darkened = base_color * 0.6;
        base_color = nearest_palette_color(darkened);
    }

    COLOR = vec4(base_color, tex.a);
}