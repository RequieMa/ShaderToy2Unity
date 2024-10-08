#define iTime _Time.y
#define iFrame _FrameCount
#define iResolution _ScreenParams
#define mod(x, y) (x - y * floor(x / y))

float3 palette(float a) 
{
    return 0.5 + 0.5 * sin(float3(0, 1, 2) + a);
}

// A simple distance field function for a circle. The distance field function give 
//  the distance from p to the object
float circle(float2 p, float r) 
{
    return length(p) - r;
}

float circle3d(float3 p, float r) 
{
    return length(p) - r;
}

// Soft min functions allows distance fields to be distorted in appealing ways
// License: MIT, author: Inigo Quilez, found: https://www.iquilezles.org/www/articles/smin/smin.htm
float pmin(float a, float b, float k) 
{
    float h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
    return lerp(b, a, h) - k * h * (1.0 - h);
}

float2 getScreenPos(float2 uv)
{
    float2 p = -1. + 2. * uv;
    p.x *= iResolution.x/iResolution.y;
    return p;
}

float4 Line(float2 uv, float speed, float height, float3 col) 
{
    uv.y += smoothstep(1., 0., abs(uv.x)) * sin(iTime * speed + uv.x * height) * .2;
    return float4(smoothstep(.06 * smoothstep(.2, .9, abs(uv.x)), 0., abs(uv.y) - .004) * col, 1.0) * smoothstep(1., .3, abs(uv.x));
}