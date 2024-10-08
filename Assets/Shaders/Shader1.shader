Shader "Unlit/Shader1"
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

            // ShaderToy Ref. https://www.shadertoy.com/view/XfBfW3
            fixed4 frag (v2f i) : SV_Target
            {
                float2 p = getScreenPos(i.uv);
                float d = 1E3;
                
                // Create 5 circles
                for (int i = 0; i < 4; ++i) 
                {
                    float2 ip = p;
                    float itime = iTime + float(i);
                    ip.x += cos(sqrt(1.2) * itime);
                    ip.y += sin(sqrt(0.7) * itime);
                    float id = circle(ip, 0.4);
                    d = pmin(d, id, 0.5);
                }

                // Distance field for the border
                float od = abs(d) - 0.025;

                float3 col = 0.;
                if (d < 0.) 
                    col = palette(8. * d - _Time.y);
                if (od < 0.) 
                    col = 1.;
                return float4(sqrt(col), 1.0);
            }
            ENDCG
        }
    }
}
