Shader "Custom/Tex_Toon" {
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Main Texture", 2D) = "white"{}
        _TexFactor("Texture Factor", float) = 1
        _RampTex("Ramp Texture", 2D) = "white"{}

        _OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
        _OutlineThickness("Outline Thickness", Range(0,1)) = 0.1
    }
        SubShader{
            Tags{ "RenderType" = "Opaque" "Queue" = "Geometry"}

            CGPROGRAM
            #pragma surface surf ToonRamp

            float _TexFactor;
            float4 _Color;
            sampler2D _RampTex;
            sampler2D _MainTex;

            struct Input
            {
                float2 uv_MainTex;
            };

            float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten) {
                float diff = dot(s.Normal, lightDir);
                float h = diff * 0.5 + 0.5;
                float2 rh = h;
                float3 ramp = tex2D(_RampTex, rh).rgb;

                float4 c;
                c.rgb = s.Albedo * _LightColor0.rgb * ramp;
                c.a = s.Alpha;
                return c;
            }

            void surf(Input IN, inout SurfaceOutput o)
            {
                //o.Albedo = _Color.rgb;
                //Combines the txture with the base colour
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _TexFactor * _Color.rgb;
            }
            ENDCG

            //The second pass to render the outlines
            Pass{
                Cull Front

                CGPROGRAM
                #include "UnityCG.cginc"
                #pragma vertex vert
                #pragma fragment frag

                fixed4 _OutlineColor;
                float _OutlineThickness;

                struct appdata {
                    float4 vertex : POSITION;
                    float4 normal : NORMAL;
                };

                struct v2f {
                    float4 position : SV_POSITION;
                };

                v2f vert(appdata v) {
                    v2f o;
                    o.position = UnityObjectToClipPos(v.vertex + normalize(v.normal) * _OutlineThickness * 0.1);
                    return o;
                }

                fixed4 frag(v2f i) : SV_TARGET{
                    return _OutlineColor;
                }

                ENDCG
            }
        }
            FallBack "Standard"
}