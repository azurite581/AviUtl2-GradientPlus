float sd_circle(float2 uv, float r) {
    return length(uv) - r;
}

float sd_square(float2 uv) {
    uv *= sqrt(2.0);
    return max(abs(uv.x), abs(uv.y));
}

float sd_round_square(float2 uv, float2 b) {
    float2 dist = abs(uv) - b;
    float outside = length(max(dist, 0.0));
    float inside = min(max(dist.x, dist.y), 0.0);
    return outside + inside;
}

float grad_line(float2 uv, float w) {
    w = max(1.0, w);
    return smoothstep(-w * 0.5, w * 0.5, uv.y);
}

float grad_circle(float2 uv, float w) {
    float dist = sd_circle(uv, w * 0.5);
    return smoothstep(-w * 0.5, w * 0.5, dist);
}

float grad_square(float2 uv, float w) {
    float dist = sd_square(uv);
    return smoothstep(0.0, w, dist);
}

float grad_convex(float2 uv, float w) {
    return smoothstep(0.0, w, abs(uv.y));
}

float grad_round_square(float2 uv, float w) {
    float dist = sd_round_square(uv, float2(w * 0.5, w * 0.5));
    return smoothstep(-w * 0.5, w * 0.5, dist);
}

float grad_circle_loop(float2 uv, float w) {
    w = max(1.0, w);
    float dist = sd_circle(uv, w);
    dist = fmod(dist + w, 2.0 * w) - w;
    return smoothstep(w, 0.0, abs(dist));
}

float grad_square_loop(float2 uv, float w) {
    w = max(1.0, w);
    float dist = sd_square(uv);
    dist = fmod(dist + w, 2.0 * w) - w;
    return smoothstep(0.0, w, abs(dist));
}

float grad_convex_loop(float2 uv, float w) {
    w = max(1.0, w);
    //float dist = mod(uv.y + w, 2.0 * w) - w;
    float dist = (uv.y + w - (2.0 * w) * floor((uv.y + w) / (2.0 * w))) - w;
    return smoothstep(0.0, w, abs(dist));
}

float grad_round_square_loop(float2 uv, float w) {
    w = max(1.0, w);
    float dist = sd_round_square(uv, w);
    dist = fmod(dist + w, 2.0 * w) - w;
    return smoothstep(0.0, w, abs(dist));
}