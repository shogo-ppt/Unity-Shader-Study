Shader "Custom/Water" {
    Properties {
        _MainTex ("Water Texture", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        // Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200
        Cull off // テクスチャの両面表示をする記述
        // Blend SrcAlpha OneMinusSrcAlpha

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o) {
            // Albedo comes from a texture tinted by color
            fixed2 uv = IN.uv_MainTex;
            uv.x += 0.1 * _Time;
            uv.y += 0.2 * _Time;
            o.Albedo = tex2D (_MainTex, uv);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
