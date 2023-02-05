Shader "Custom/PBR_Spec_Shader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex("Metallic (R)", 2D) = "white" {}
        _Specular("Specular",Color) = (1,1,1,1)
    }
        SubShader
        {
            Tags {"Queue" = "Geometry"}

            CGPROGRAM
            #pragma surface surf StandardSpecular
            #pragma target 3.0

            sampler2D _MetallicTex;
            fixed4 _Specular;
            fixed4 _Color;

            struct Input
            {
                float2 uv_MetallicTex;
            };

            void surf(Input IN, inout SurfaceOutputStandardSpecular o)
            {
                o.Albedo = _Color.rgb;
                o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
                o.Specular = _Specular.rgb;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
