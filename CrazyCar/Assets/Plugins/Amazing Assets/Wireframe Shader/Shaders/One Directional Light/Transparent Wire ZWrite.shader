


Shader "Hidden/Amazing Assets/Wireframe Shader/One Directional Light/Transparent/ZWrite/Wire Only"
{
	Properties     
	{        
[WireframeCurvedWorldTitle] _CurvedWorldTitle("", Float) = 0
//[CurvedWorldBendSettings] _CurvedWorldBendSettings("0|1|1", Vector) = (0, 0, 0, 0)
		  
		
		//Rendering Options
		[WireframeTitle] _Wireframe_Title_Rendering_Options("Rendering Options", float) = 0  
		[WireframeRenderingOptions] _Wireframe_RenderingOptions_ODLEnumID("", float) = 0
		 
		[MaterialEnum(Off,0,Front,1,Back,2)] _Cull ("Cull", Int) = 2		 		

		//Base
		[HideInInspector] _Color("", color) = (1, 1, 1, 1)
		[HideInInspector] _MainTex("", 2D) = "white"{}						 				 	

		     
		//Wire S Options  
		[WireframeTitle] _Wireframe_Title_S_Options("Wireframe Shader Options", float) = 0  		
		
		//Source
		_WireframeShader_Thickness("Thickness", Range(0, 1)) = 0.01
		_WireframeShader_Smoothness("Smoothness", Range(0, 1)) = 0	
		_WireframeShader_Diameter("Diameter", Range(0, 1)) = 1

		//Wire Options  
		[WireframeHeader] _Wireframe_Title_W_Options("Base Options", float) = 0  	

		_Wireframe_Color("Color (RGB) Trans (A)", color) = (1, 0, 0, 1)
		[WireframePositiveFloat]_Wireframe_ColorEmissionStrength("Emission Strength", float) = 0
		_Wireframe_ColorTexture("Color Texture (RGBA)", 2D) = "white"{}
		[WireframeUVScroll] _Wireframe_ColorTexture_Scroll("", vector) = (0, 0, 0, 0)
		
		
		//Vertex Color
		[Enum(Off,0,On,1)] _Wireframe_WireVertexColor("Vertex Color", Float) = 0

		//Light
		[WireframeLightInteraction] _Wireframe_IncludeLightEnumID ("", float) = 0

		//Transparency          
		[WireframeHeader]		  _Wireframe_Transparency_M_Options("Transparency Options", float) = 0  
		[WireframeTextureTransparency] _Wireframe_TransparencyEnumID("", float) = 0 				
		[HideInInspector]	  _Wireframe_TransparentTex_Invert("    ", float) = 0
		[HideInInspector]	  _Wireframe_TransparentTex_Alpha_Offset("    ", Range(-1, 1)) = 0
				 
		//Fresnel
	    [WireframeFresnel]  _Wireframe_FresnelEnumID ("Fresnel", Float) = 0	
		[HideInInspector] _Wireframe_FresnelInvert("", float) = 0
		[HideInInspector] _Wireframe_FresnelBias("", Range(-1, 1)) = 0
		[HideInInspector] _Wireframe_FresnelPow("", Range(1, 16)) = 1

		//Distance Fade  
	    [WireframeDistanceFade]  _Wireframe_DistanceFade ("Distance Fade", Float) = 0
		[HideInInspector] _Wireframe_DistanceFadeStart("", Float) = 5
		[HideInInspector] _Wireframe_DistanceFadeEnd("", Float) = 10

		//Dynamic Mask
		[WireframeHeader]		 _Wireframe_Title_M_Options("Dynamic Mask Options", float) = 0  
		[WireframeDynamicMask] _Wireframe_DynamicMaskEnumID("", float) = 0
		[HideInInspector]    _Wireframe_DynamicMaskInvert("", float) = 0
		[HideInInspector]    _Wireframe_DynamicMaskEffectsBaseTexEnumID("", int) = 0
		[HideInInspector]    _Wireframe_DynamicMaskEffectsBaseTexInvert("", float) = 0	
		[HideInInspector]    _Wireframe_DynamicMaskType("", Float) = 1
		[HideInInspector][PositiveFloatDrawer]    _Wireframe_DynamicMaskEdgeSmooth("", float) = 0

		[WireframeTitle]		 _Wireframe_Title_UAR_Options("Unity Advanced Rendering Options", float) = 0 
	}


	SubShader 
	{
		Tags { "Queue"="Transparent" 
		       "IgnoreProjector"="True" 
			   "RenderType"="Transparent"
			 }
		LOD 200		
		Cull [_Cull]
		Blend SrcAlpha OneMinusSrcAlpha 		      


		//Color Mask 0 NoInstance
		Pass  
		{
			Name "COLORMASK"  

			ZWrite On
			ColorMask 0
		 

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag  
			#include "UnityCG.cginc"    


//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"


			#include "../cginc/WireframeColorMask0.cginc"   

			ENDCG   
		} //Pass


		//PassName "FORWARD" 
		Pass
	    { 
			Name "FORWARD" 
			Tags { "LightMode" = "ForwardBase" } 
			  
			CGPROGRAM            
			#pragma vertex vert   
	    	#pragma fragment frag  		  
			#pragma multi_compile_fwdbase nodirlightmap nodynlightmap
			#pragma target 3.0
			       
			#pragma multi_compile_fog   


//#define CURVEDWORLD_BEND_TYPE_CLASSICRUNNER_X_POSITIVE
//#define CURVEDWORLD_BEND_ID_1
//#pragma shader_feature_local CURVEDWORLD_DISABLED_ON
//#pragma shader_feature_local CURVEDWORLD_NORMAL_TRANSFORMATION_ON
//#include "Assets/Amazing Assets/Curved World/Shaders/Core/CurvedWorldTransform.cginc"
			

			#ifdef UNITY_PASS_DEFERRED
				#define WIREFRAME_LIGHT_ATTENTION_ON
			#else
				#pragma shader_feature_local WIREFRAME_LIGHT_ATTENTION_ON
			#endif

			#pragma shader_feature_local WIREFRAME_COLOR_TEXTURE_TRANSPARENCY_ON
			#pragma shader_feature_local WIREFRAME_FRESNEL_ON
			#pragma shader_feature_local WIREFRAME_DISTANCE_FADE_ON	
			#pragma shader_feature_local _ WIREFRAME_DYNAMIC_MASK_PLANE WIREFRAME_DYNAMIC_MASK_SPHERE WIREFRAME_DYNAMIC_MASK_BOX 
		   			 
			#define WIREFRAME_TRANSPARENT
			#define WIREFRAME_NO_COLOR_BLACK
			#define WIREFRAME_SAME_COLOR

			#include "../cginc/WireframeForwardBase.cginc"
			ENDCG   			 
		} //Pass   	
			 
	} //SubShader

	FallBack "Hidden/Amazing Assets/Wireframe Shader/Vertex Lit/Transparent/Wire Only"
} //Shader