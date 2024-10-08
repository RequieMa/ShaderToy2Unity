Shader "Unlit/Shader3"
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

            // ShaderToy Ref. https://www.shadertoy.com/view/DtXfDr
            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = getScreenPos(i.uv) / 2.;
                float4 fragCol = 0.;
                for (int i = 0; i < 6; ++i) 
                {
                    float t = (float)i / 5.;
                    fragCol += Line(uv, 1. + t, 4. + t, float3(.2 + t * .7, .2 + t * .4, 0.3));
                }
                return fragCol;
            }
            ENDCG
        }
    }
}
