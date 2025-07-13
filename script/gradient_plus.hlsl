Texture2D<float4> src : register(t0);
cbuffer constant0 : register(b0) {
    float2 resolution;
    float2 center;
    float3 col1;
    float3 col2;
    float2x2 angle;
    float color_space;
    float interp_dir;
    float gradient_type;
    float gradient_w;
};

float4 psmain(float4 pos : SV_Position) : SV_Target {
    float2 st = pos.xy - 0.5 * resolution - center;
    st = mul(angle, st);

    float t = 0.0;
    switch (gradient_type) {
        case 0:  // 線形
            t = grad_line(st, gradient_w);
            break;
        case 1:  // 円形
            t = grad_circle(st, gradient_w);
            break;
        case 2:  // 短形
            t = grad_square(st, gradient_w);
            break;
        case 3:  // 凸形
            t = grad_convex(st, gradient_w);
            break;
        case 4:  // 角丸短形
            t = grad_round_square(st, gradient_w);
            break;
        case 5:  // 円ループ
            t = grad_circle_loop(st, gradient_w);
            break;
        case 6:  // 短形ループ
            t = grad_square_loop(st, gradient_w);
            break;
        case 7:  // 凸形ループ
            t = grad_convex_loop(st, gradient_w);
            break;
        case 8:  // 角丸短形ループ
            t = grad_round_square_loop(st, gradient_w);
            break;
        default:
            t = grad_line(st, gradient_w);
            break;
    }

    float3 result = float3(0.0, 0.0, 0.0);
    switch (color_space) {
        case 0:  // Linear sRGB
            result = lerp(srgb2linear(col1), srgb2linear(col2), t);
            result = linear2srgb(result);
            break;
        case 1:  // HSV
            float3 hsv1 = srgb2hsv(col1);
            float3 hsv2 = srgb2hsv(col2);
            result = hsv2srgb(hsv_mix(hsv1, hsv2, t, interp_dir));
            break;
        case 2:  // HSL
            float3 hsl1 = srgb2hsl(col1);
            float3 hsl2 = srgb2hsl(col2);
            result = hsl2srgb(hsv_mix(hsl1, hsl2, t, interp_dir));
            break;
        case 3:  // L*a*b* (CIELAB)
            float3 lab1 = linear2lab(srgb2linear(col1));
            float3 lab2 = linear2lab(srgb2linear(col2));
            result = lab2linear(lerp(lab1, lab2, t));
            result = linear2srgb(result);
            break;
        case 4:  // LCh
            float3 lch1 = linear2lch(srgb2linear(col1));
            float3 lch2 = linear2lch(srgb2linear(col2));
            result = lch2linear(lch_mix(lch1, lch2, t, interp_dir));
            result = linear2srgb(result);
            break;
        case 5:  // Oklab
            float3 oklab1 = linear2oklab(srgb2linear(col1));
            float3 oklab2 = linear2oklab(srgb2linear(col2));
            result = oklab2linear(lerp(oklab1, oklab2, t));
            result = linear2srgb(result);
            break;
        case 6:  // OkLCh
            float3 oklch1 = linear2oklch(srgb2linear(col1));
            float3 oklch2 = linear2oklch(srgb2linear(col2));
            result = oklch2linear(lch_mix(oklch1, oklch2, t, interp_dir));
            result = linear2srgb(result);
            break;
    }

    float alpha = src.Load(int3(pos.xy, 0)).a;
    return float4(result * alpha, alpha);
}
