Shader "Unlit/Shader2"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "helper.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            // ShaderToy Ref. https://www.shadertoy.com/view/3ttSzr
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = getScreenPos(i.uv);
            
                for(float i = 1.0; i < 8.0; ++i)
                {
                    float w = i * i + iTime * 0.5;
                    uv.y += 0.1 * sin(uv.x * w) * sin(uv.y * w);
                }
                    
                float3 col = uv.y;
                col.r += -0.1;
                col.g += 0.3;
                col.b += 0.95;
                return float4(col, 1.0);
            }
            ENDCG
        }
    }
}
