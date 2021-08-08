Shader "Custom/Sample" {
    // Parametares:変数
    Properties {
        // インスペクタから操作できるようにする
        // _BaseColor ("Base Color", Color) = (1, 1, 1, 1)
        // _BaseColor:公開する変数名
        // "Base Color":インスペクタ上の表示
        // Color:型名
        // (1, 1, 1, 1):初期値
        _Alpha ("Alpha", Range(0, 100)) = 1.5
    }
    SubShader {
        // Shader Settings:ライティングや透明度の設定
        Tags { "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        // Surface Shader:シェーダー本体
        sampler2D _MainTex;

        // ★重要
        struct Input {
            float3 worldNormal; // オブジェクトの法線ベクトル
            float3 viewDir;     // 視線ベクトル
        };

        half _Alpha;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        // ★重要 <- Surface Shaderの肝
        // 出力用の構造体(SurfaceOutputStandard)がもつ(oのこと?)Albedo変数に色情報を指定
        void surf (Input IN, inout SurfaceOutputStandard o) {
            // Albedo comes from a texture tinted by color
            o.Albedo = fixed4(1, 1, 1, 1);
            float alpha = 1 - (abs(dot(IN.viewDir, IN.worldNormal)));
            o.Alpha = alpha * _Alpha;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
