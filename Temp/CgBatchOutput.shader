Shader "Hidden/ColorCorrectionCurvesSimple" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "" {}
		_RgbTex ("_RgbTex (RGB)", 2D) = "" {}
	}
	
	// Shader code pasted into all further CGPROGRAM blocks
	#LINE 46
 
	
Subshader {
 Pass {
	  ZTest Always Cull Off ZWrite Off
	  Fog { Mode off }      

      Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 5 to 5
//   d3d9 - ALU: 5 to 5
//   d3d11 - ALU: 1 to 1, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 1 to 1, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
# 5 ALU
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerDraw" 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedgcclnnbgpijgpddakojponflfpghdgniabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying mediump vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying mediump vec2 xlv_TEXCOORD0;
uniform lowp float _Saturation;
uniform sampler2D _RgbTex;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.125;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec2 tmpvar_4;
  tmpvar_4.y = 0.375;
  tmpvar_4.x = tmpvar_2.y;
  lowp vec2 tmpvar_5;
  tmpvar_5.y = 0.625;
  tmpvar_5.x = tmpvar_2.z;
  lowp vec4 tmpvar_6;
  tmpvar_6.xyz = (((texture2D (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0)) + (texture2D (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))) + (texture2D (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0)));
  tmpvar_6.w = tmpvar_2.w;
  color_1.w = tmpvar_6.w;
  color_1.xyz = mix (vec3(dot (tmpvar_6.xyz, vec3(0.22, 0.707, 0.071))), tmpvar_6.xyz, vec3(_Saturation));
  gl_FragData[0] = color_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying mediump vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying mediump vec2 xlv_TEXCOORD0;
uniform lowp float _Saturation;
uniform sampler2D _RgbTex;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.125;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec2 tmpvar_4;
  tmpvar_4.y = 0.375;
  tmpvar_4.x = tmpvar_2.y;
  lowp vec2 tmpvar_5;
  tmpvar_5.y = 0.625;
  tmpvar_5.x = tmpvar_2.z;
  lowp vec4 tmpvar_6;
  tmpvar_6.xyz = (((texture2D (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0)) + (texture2D (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))) + (texture2D (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0)));
  tmpvar_6.w = tmpvar_2.w;
  color_1.w = tmpvar_6.w;
  color_1.xyz = mix (vec3(dot (tmpvar_6.xyz, vec3(0.22, 0.707, 0.071))), tmpvar_6.xyz, vec3(_Saturation));
  gl_FragData[0] = color_1;
}



#endif"
}

SubProgram "flash " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"agal_vs
[bc]
aaaaaaaaaaaaadaeadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov v0.xy, a3
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "UnityPerDraw" 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedmldjmmohbhmjmnnblgkeoagbliecmmbkabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct v2f {
    highp vec4 pos;
    mediump vec2 uv;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 312
uniform sampler2D _MainTex;
uniform sampler2D _RgbTex;
uniform lowp float _Saturation;
#line 322
#line 315
v2f vert( in appdata_img v ) {
    #line 317
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = v.texcoord.xy;
    return o;
}
out mediump vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_img xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct v2f {
    highp vec4 pos;
    mediump vec2 uv;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 312
uniform sampler2D _MainTex;
uniform sampler2D _RgbTex;
uniform lowp float _Saturation;
#line 322
#line 172
lowp float Luminance( in lowp vec3 c ) {
    #line 174
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 322
lowp vec4 frag( in v2f i ) {
    lowp vec4 color = texture( _MainTex, i.uv);
    lowp vec3 red = (texture( _RgbTex, vec2( color.x, 0.125)).xyz * vec3( 1.0, 0.0, 0.0));
    #line 326
    lowp vec3 green = (texture( _RgbTex, vec2( color.y, 0.375)).xyz * vec3( 0.0, 1.0, 0.0));
    lowp vec3 blue = (texture( _RgbTex, vec2( color.z, 0.625)).xyz * vec3( 0.0, 0.0, 1.0));
    color = vec4( ((red + green) + blue), color.w);
    lowp float lum = Luminance( color.xyz);
    #line 330
    color.xyz = mix( vec3( lum, lum, lum), color.xyz, vec3( _Saturation));
    return color;
}
in mediump vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 18 to 18, TEX: 4 to 4
//   d3d9 - ALU: 25 to 25, TEX: 4 to 4
//   d3d11 - ALU: 3 to 3, TEX: 4 to 4, FLOW: 1 to 1
//   d3d11_9x - ALU: 3 to 3, TEX: 4 to 4, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Float 0 [_Saturation]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_RgbTex] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 4 TEX
PARAM c[3] = { program.local[0],
		{ 0.125, 1, 0, 0.375 },
		{ 0.625, 0.2199707, 0.70703125, 0.070983887 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MOV R1.x, R0.y;
MOV R1.z, R0;
MOV R0.y, c[1].x;
MOV R1.w, c[2].x;
MOV R1.y, c[1].w;
MOV result.color.w, R0;
TEX R2.xyz, R1.zwzw, texture[1], 2D;
TEX R0.xyz, R0, texture[1], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[1].zyzw;
MUL R0.xyz, R0, c[1].yzzw;
ADD R0.xyz, R0, R1;
MUL R2.xyz, R2, c[1].zzyw;
ADD R0.xyz, R0, R2;
DP3 R1.x, R0, c[2].yzww;
ADD R0.xyz, R0, -R1.x;
MAD result.color.xyz, R0, c[0].x, R1.x;
END
# 18 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Float 0 [_Saturation]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_RgbTex] 2D
"ps_2_0
; 25 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
def c1, 0.12500000, 1.00000000, 0.00000000, 0.37500000
def c2, 0.62500000, 0.21997070, 0.70703125, 0.07098389
dcl t0.xy
texld r3, t0, s0
mov_pp r0.x, r3.z
mov_pp r0.y, c2.x
mov_pp r1.x, r3.y
mov_pp r2.x, r3
mov_pp r1.y, c1.w
mov_pp r2.y, c1.x
mov r3.z, c1.y
mov r3.xy, c1.z
texld r0, r0, s1
texld r2, r2, s1
texld r1, r1, s1
mul r3.xyz, r0, r3
mov r0.xz, c1.z
mov r0.y, c1
mul r1.xyz, r1, r0
mov r0.yz, c1.z
mov r0.x, c1.y
mul r0.xyz, r2, r0
add_pp r0.xyz, r0, r1
add_pp r1.xyz, r0, r3
mov r0.x, c2.y
mov r0.z, c2.w
mov r0.y, c2.z
dp3_pp r2.x, r1, r0
add_pp r0.xyz, r1, -r2.x
mov_pp r0.w, r3
mad_pp r0.xyz, r0, c0.x, r2.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
ConstBuffer "$Globals" 32 // 20 used size, 2 vars
Float 16 [_Saturation]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 1
// 15 instructions, 3 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedkgjihgjcnbjcgljibpaibkchgdndmcnoabaaaaaabiadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfiacaaaa
eaaaaaaajgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaadgaaaaaikcaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadoaaaaaaaaaaaamadoefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaacghnbaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaffcaabaaaaaaaaaaa
fgagbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaabeaaaaaaaaacadpefaaaaajpcaabaaaabaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaiadpaaaaaaaaegacbaaa
aaaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaakoehgbdo
pepndedphdgijbdnaaaaaaaaaaaaaaaihcaabaaaaaaaaaaapgapbaiaebaaaaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "flash " {
Keywords { }
Float 0 [_Saturation]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_RgbTex] 2D
"agal_ps
c1 0.125 1.0 0.0 0.375
c2 0.625 0.219971 0.707031 0.070984
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaabacadaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r3.z
aaaaaaaaaaaaacacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.y, c2.x
aaaaaaaaabaaabacadaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r3.y
aaaaaaaaacaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r2.x, r3.x
aaaaaaaaabaaacacabaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r1.y, c1.w
aaaaaaaaacaaacacabaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r2.y, c1.x
aaaaaaaaadaaaeacabaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r3.z, c1.y
aaaaaaaaadaaadacabaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r3.xy, c1.z
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaacaaapacacaaaafeacaaaaaaabaaaaaaafaababb tex r2, r2.xyyy, s1 <2d wrap linear point>
ciaaaaaaabaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r1, r1.xyyy, s1 <2d wrap linear point>
adaaaaaaadaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa mul r3.xyz, r0.xyzz, r3.xyzz
aaaaaaaaaaaaafacabaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.xz, c1.z
aaaaaaaaaaaaacacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.y, c1
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r1.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaagacabaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.yz, c1.z
aaaaaaaaaaaaabacabaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c1.y
adaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
abaaaaaaabaaahacaaaaaakeacaaaaaaadaaaakeacaaaaaa add r1.xyz, r0.xyzz, r3.xyzz
aaaaaaaaaaaaabacacaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.x, c2.y
aaaaaaaaaaaaaeacacaaaappabaaaaaaaaaaaaaaaaaaaaaa mov r0.z, c2.w
aaaaaaaaaaaaacacacaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.y, c2.z
bcaaaaaaacaaabacabaaaakeacaaaaaaaaaaaakeacaaaaaa dp3 r2.x, r1.xyzz, r0.xyzz
acaaaaaaaaaaahacabaaaakeacaaaaaaacaaaaaaacaaaaaa sub r0.xyz, r1.xyzz, r2.x
aaaaaaaaaaaaaiacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r3.w
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c0.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaaaacaaaaaa add r0.xyz, r0.xyzz, r2.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { }
ConstBuffer "$Globals" 32 // 20 used size, 2 vars
Float 16 [_Saturation]
BindCB "$Globals" 0
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_RgbTex] 2D 1
// 15 instructions, 3 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 4 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedpcenfjdklcmijiajghnnceenejdkekikabaaaaaaleaeaaaaaeaaaaaa
daaaaaaamiabaaaaciaeaaaaiaaeaaaaebgpgodjjaabaaaajaabaaaaaaacpppp
fiabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaado
aaaamadoaaaacadpaaaaaaaafbaaaaafacaaapkaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaafbaaaaafadaaapkakoehgbdopepndedphdgijbdnaaaaaaaabpaaaaac
aaaaaaiaaaaacdlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaabaaaaacabaacciaabaaffkaabaaaaac
abaacbiaaaaaffiaabaaaaacaaaacciaabaaaakaabaaaaacacaacbiaaaaakkia
abaaaaacacaacciaabaakkkaecaaaaadabaaapiaabaaoeiaabaioekaecaaaaad
adaaapiaaaaaoeiaabaioekaecaaaaadacaaapiaacaaoeiaabaioekaafaaaaad
abaachiaabaaoeiaacaaoekaaeaaaaaeabaachiaadaaoeiaacaamjkaabaaoeia
aeaaaaaeabaachiaacaaoeiaacaanckaabaaoeiaaiaaaaadabaaciiaabaaoeia
adaaoekabcaaaaaeaaaachiaaaaaaakaabaaoeiaabaappiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcfiacaaaaeaaaaaaajgaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
dgaaaaaikcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadoaaaaaaaaaaaamado
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaacghnbaaaaaaaaaaaaagabaaa
aaaaaaaadgaaaaaffcaabaaaaaaaaaaafgagbaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaogakbaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadgaaaaafccaabaaaabaaaaaaabeaaaaaaaaacadp
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaiadpaaaaaaaaegacbaaaaaaaaaaabaaaaaakicaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaakoehgbdopepndedphdgijbdnaaaaaaaaaaaaaaai
hcaabaaaaaaaaaaapgapbaiaebaaaaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}

#LINE 56

  }
}

Fallback off
	
} // shader