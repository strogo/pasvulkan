(******************************************************************************
 *                                 PasVulkan                                  *
 ******************************************************************************
 *                       Version see PasVulkan.Framework.pas                  *
 ******************************************************************************
 *                                zlib license                                *
 *============================================================================*
 *                                                                            *
 * Copyright (C) 2016-2017, Benjamin Rosseaux (benjamin@rosseaux.de)          *
 *                                                                            *
 * This software is provided 'as-is', without any express or implied          *
 * warranty. In no event will the authors be held liable for any damages      *
 * arising from the use of this software.                                     *
 *                                                                            *
 * Permission is granted to anyone to use this software for any purpose,      *
 * including commercial applications, and to alter it and redistribute it     *
 * freely, subject to the following restrictions:                             *
 *                                                                            *
 * 1. The origin of this software must not be misrepresented; you must not    *
 *    claim that you wrote the original software. If you use this software    *
 *    in a product, an acknowledgement in the product documentation would be  *
 *    appreciated but is not required.                                        *
 * 2. Altered source versions must be plainly marked as such, and must not be *
 *    misrepresented as being the original software.                          *
 * 3. This notice may not be removed or altered from any source distribution. *
 *                                                                            *
 ******************************************************************************
 *                  General guidelines for code contributors                  *
 *============================================================================*
 *                                                                            *
 * 1. Make sure you are legally allowed to make a contribution under the zlib *
 *    license.                                                                *
 * 2. The zlib license header goes at the top of each source file, with       *
 *    appropriate copyright notice.                                           *
 * 3. This PasVulkan wrapper may be used only with the PasVulkan-own Vulkan   *
 *    Pascal header.                                                          *
 * 4. After a pull request, check the status of your pull request on          *
      http://github.com/BeRo1985/pasvulkan                                    *
 * 5. Write code which's compatible with Delphi >= 2009 and FreePascal >= 3.0 *
 * 6. Don't use Delphi-only, FreePascal-only or Lazarus-only libraries/units, *
 *    but if needed, make it out-ifdef-able.                                  *
 * 7. No use of third-party libraries/units as possible, but if needed, make  *
 *    it out-ifdef-able.                                                      *
 * 8. Try to use const when possible.                                         *
 * 9. Make sure to comment out writeln, used while debugging.                 *
 * 10. Make sure the code compiles on 32-bit and 64-bit platforms (x86-32,    *
 *     x86-64, ARM, ARM64, etc.).                                             *
 * 11. Make sure the code runs on all platforms with Vulkan support           *
 *                                                                            *
 ******************************************************************************)
unit PasVulkan.Types;
{$i PasVulkan.inc}
{$ifndef fpc}
 {$ifdef conditionalexpressions}
  {$if CompilerVersion>=24.0}
   {$legacyifend on}
  {$ifend}
 {$endif}
{$endif}

interface

type PPpvInt8=^PpvInt8;
     PpvInt8=^TpvInt8;
     TpvInt8={$ifdef fpc}Int8{$else}shortint{$endif};

     PPpvUInt8=^PpvUInt8;
     PpvUInt8=^TpvUInt8;
     TpvUInt8={$ifdef fpc}UInt8{$else}byte{$endif};

     PPpvInt16=^PpvInt16;
     PpvInt16=^TpvInt16;
     TpvInt16={$ifdef fpc}Int16{$else}smallint{$endif};

     PPpvUInt16=^PpvUInt16;
     PpvUInt16=^TpvUInt16;
     TpvUInt16={$ifdef fpc}UInt16{$else}word{$endif};

     PPpvInt32=^PpvInt32;
     PpvInt32=^TpvInt32;
     TpvInt32={$ifdef fpc}Int32{$else}longint{$endif};

     PPpvUInt32=^PpvUInt32;
     PpvUInt32=^TpvUInt32;
     TpvUInt32={$ifdef fpc}UInt32{$else}longword{$endif};

     PPpvInt64=^PpvInt64;
     PpvInt64=^TpvInt64;
     TpvInt64=Int64;

     PPpvUInt64=^PpvUInt64;
     PpvUInt64=^TpvUInt64;
     TpvUInt64=UInt64;

     PPChar=^PChar;
     PChar=PAnsiChar;
     TChar=AnsiChar;

     PPpvPointer=^PpvPointer;
     PpvPointer=^TpvPointer;
     TpvPointer=Pointer;

     PPPointers=^PPointers;
     PPointers=^TPointers;
     TPointers=array[0..65535] of pointer;

     PPpvVoid=^PpvVoid;
     PpvVoid=Pointer;

     PPpvFloat=^PpvFloat;
     PpvFloat=^TpvFloat;
     TpvFloat=Single;

     PPpvDouble=^PpvDouble;
     PpvDouble=^TpvDouble;
     TpvDouble=Double;

{    PPTime=^PTime;
     PTime=^TTime;
     TTime=TpvInt64;}

     PPpvPtrUInt=^PpvPtrUInt;
     PPpvPtrInt=^PpvPtrInt;
     PpvPtrUInt=^TpvPtrUInt;
     PpvPtrInt=^TpvPtrInt;
{$ifdef fpc}
     TpvPtrUInt=PtrUInt;
     TpvPtrInt=PtrInt;
 {$undef OldDelphi}
{$else}
 {$ifdef conditionalexpressions}
  {$if CompilerVersion>=23.0}
   {$undef OldDelphi}
     TpvPtrUInt=NativeUInt;
     TpvPtrInt=NativeInt;
  {$else}
   {$define OldDelphi}
  {$ifend}
 {$else}
  {$define OldDelphi}
 {$endif}
{$endif}
{$ifdef OldDelphi}
{$ifdef cpu64}
     TpvPtrUInt=uint64;
     TpvPtrInt=int64;
{$else}
     TpvPtrUInt=longword;
     TpvPtrInt=longint;
{$endif}
{$endif}

     PPpvSizeUInt=^PpvSizeUInt;
     PpvSizeUInt=^TpvSizeUInt;
     TpvSizeUInt=TpvPtrUInt;

     PPpvSizeInt=^PpvSizeInt;
     PpvSizeInt=^TpvSizeInt;
     TpvSizeInt=TpvPtrInt;

     PPpvSize=^PpvSizeUInt;
     PpvSize=^TpvSizeUInt;
     TpvSize=TpvPtrUInt;

     PPpvPtrDiff=^PpvPtrDiff;
     PpvPtrDiff=^TpvPtrDiff;
     TpvPtrDiff=TpvPtrInt;

     PPpvRawByteString=^PpvRawByteString;
     PpvRawByteString=^TpvRawByteString;
     TpvRawByteString=RawByteString;

     PPpvUTF8String=^PpvUTF8String;
     PpvUTF8String=^TpvUTF8String;
     TpvUTF8String=UTF8String;

     PPpvUnicodeString=^PpvUnicodeString;
     PpvUnicodeString=^TpvUnicodeString;
     TpvUnicodeString=UnicodeString;

     PPpvFileName=^PpvFileName;
     PpvFileName=^TpvFileName;
     TpvFileName=String;

     PpvHandle=^TpvHandle;
     TpvHandle={$ifdef fpc}bitpacked{$endif} record
      Index:TpvUInt32;
      Generation:TpvUInt32;
     end;

     PpvID=^TpvID;
     TpvID={$ifdef fpc}bitpacked{$endif} record
      Index:TpvUInt32;
      Generation:TpvUInt32;
     end;

     PPpvUInt128=^PpvUInt128;
     PpvUInt128=^TpvUInt128;
     TpvUInt128=packed record
      public
       class operator Implicit(const a:TpvUInt64):TpvUInt128; {$ifdef caninline}inline;{$endif}
       class operator Implicit(const a:TpvUInt128):TpvUInt64; {$ifdef caninline}inline;{$endif}
       class operator Explicit(const a:TpvUInt64):TpvUInt128; {$ifdef caninline}inline;{$endif}
       class operator Explicit(const a:TpvUInt128):TpvUInt64; {$ifdef caninline}inline;{$endif}
       class operator Add(const a,b:TpvUInt128):TpvUInt128; {$ifdef caninline}inline;{$endif}
       class operator Multiply(const a,b:TpvUInt128):TpvUInt128;
       class operator IntDivide(const a:TpvUInt128;const b:TpvUInt64):TpvUInt128;
       class function Mul64(const a,b:TpvUInt64):TpvUInt128; static;
{$ifdef BIG_ENDIAN}
       case byte of
        0:(
         Hi,Lo:TpvUInt64;
        );
        1:(
         Q3,Q2,Q1,Q0:TpvUInt32;
        );
{$else}
       case byte of
        0:(
         Lo,Hi:TpvUInt64;
        );
        1:(
         Q0,Q1,Q2,Q3:TpvUInt32;
        );
 {$endif}
     end;

     PPpvHalfFloat=^PpvHalfFloat;
     PpvHalfFloat=^TpvHalfFloat;
     TpvHalfFloat=record
      public
       Value:TpvUInt16;
       constructor Create(const pValue:TpvFloat);
       class function FromFloat(const pValue:TpvFloat):TpvHalfFloat; static; {$ifdef CAN_INLINE}inline;{$endif}
       function ToFloat:TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Implicit(const a:TpvFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Implicit(const a:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Explicit(const a:TpvFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Explicit(const a:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Equal(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Equal(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Equal(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator NotEqual(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator NotEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator NotEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThan(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThan(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThan(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThanOrEqual(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThanOrEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator GreaterThanOrEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThan(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThan(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThan(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThanOrEqual(const a,b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThanOrEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator LessThanOrEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Inc(const a:TpvHalfFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Dec(const a:TpvHalfFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Add(const a,b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Add(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Add(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Subtract(const a,b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Subtract(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Subtract(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Multiply(const a,b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Multiply(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Multiply(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Divide(const a,b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Divide(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Divide(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Modulus(const a,b:TpvHalfFloat):TpvFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Negative(const a:TpvHalfFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Positive(const a:TpvHalfFloat):TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       function Abs:TpvHalfFloat; {$ifdef CAN_INLINE}inline;{$endif}
       function IsNaN:boolean; {$ifdef CAN_INLINE}inline;{$endif}
       function IsInfinity:boolean; {$ifdef CAN_INLINE}inline;{$endif}
       function IsNegativeInfinity:boolean; {$ifdef CAN_INLINE}inline;{$endif}
       function IsPositiveInfinity:boolean; {$ifdef CAN_INLINE}inline;{$endif}
     end;

     PPpvUUIDString=^PpvUUIDString;
     PpvUUIDString=^TpvUUIDString;
     TpvUUIDString=string;

     PPpvUUID=^PpvUUID;
     PpvUUID=^TpvUUID;
     TpvUUID=packed record
      public
       class function Create:TpvUUID; static;
       constructor CreateFromString(const UUID:TpvUUIDString);
       function ToString:TpvUUIDString;
       class operator Implicit(const a:TpvUUID):TpvUUIDString; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Implicit(const a:TpvUUIDString):TpvUUID; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Explicit(const a:TpvUUID):TpvUUIDString; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Explicit(const a:TpvUUIDString):TpvUUID; {$ifdef CAN_INLINE}inline;{$endif}
       class operator Equal(const a,b:TpvUUID):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       class operator NotEqual(const a,b:TpvUUID):boolean; {$ifdef CAN_INLINE}inline;{$endif}
       case longint of
        0:(
         GUID:TGUID;
        );
        1:(
         D1:TpvUInt32;
         D2:TpvUInt16;
         D3:TpvUInt16;
         D4:array[0..7] of TpvUInt8;
        );
        2:(
         TpvUInt8s:array[0..15] of TpvUInt8;
        );
        3:(
         TpvUInt16s:array[0..7] of TpvUInt16;
        );
        4:(
         DoubleTpvUInt16s:array[0..3] of TpvUInt32;
        );
        5:(
         QuadTpvUInt16s:array[0..1] of TpvUInt64;
        );
     end;

var FloatToHalfFloatBaseTable:array[0..511] of TpvUInt16;
    FloatToHalfFloatShiftTable:array[0..511] of TpvUInt8;

    HalfFloatToFloatMantissaTable:array[0..2047] of TpvUInt32;
    HalfFloatToFloatExponentTable:array[0..63] of TpvUInt32;
    HalfFloatToFloatOffsetTable:array[0..63] of TpvUInt32;

implementation

uses SysUtils,
     Classes,
     Math;

procedure GenerateHalfFloatLookUpTables;
var i,e:TpvInt32;
    Mantissa,Exponent:TpvUInt32;
begin
 for i:=0 to 255 do begin
  e:=i-127;
  case e of
   -127..-25:begin
    // Very small numbers maps to zero
    FloatToHalfFloatBaseTable[i or $000]:=$0000;
    FloatToHalfFloatBaseTable[i or $100]:=$8000;
    FloatToHalfFloatShiftTable[i or $000]:=24;
    FloatToHalfFloatShiftTable[i or $100]:=24;
   end;
   -24..-15:begin
    // Small numbers maps to denormals
    FloatToHalfFloatBaseTable[i or $000]:=($0400 shr ((-e)-14)) or $0000;
    FloatToHalfFloatBaseTable[i or $100]:=($0400 shr ((-e)-14)) or $8000;
    FloatToHalfFloatShiftTable[i or $000]:=(-e)-1;
    FloatToHalfFloatShiftTable[i or $100]:=(-e)-1;
   end;
   -14..15:begin
    // Normal numbers just loses precision
    FloatToHalfFloatBaseTable[i or $000]:=((e+15) shl 10) or $0000;
    FloatToHalfFloatBaseTable[i or $100]:=((e+15) shl 10) or $8000;
    FloatToHalfFloatShiftTable[i or $000]:=13;
    FloatToHalfFloatShiftTable[i or $100]:=13;
   end;
   16..127:begin
    // Large numbers maps to infinity
    FloatToHalfFloatBaseTable[i or $000]:=$7c00;
    FloatToHalfFloatBaseTable[i or $100]:=$fc00;
    FloatToHalfFloatShiftTable[i or $000]:=24;
    FloatToHalfFloatShiftTable[i or $100]:=24;
   end;
   else begin
    // Infinity and NaN's stay infinity and NaN's
    FloatToHalfFloatBaseTable[i or $000]:=$7c00;
    FloatToHalfFloatBaseTable[i or $100]:=$fc00;
    FloatToHalfFloatShiftTable[i or $000]:=13;
    FloatToHalfFloatShiftTable[i or $100]:=13;
   end;
  end;
 end;
 begin
  begin
   HalfFloatToFloatMantissaTable[0]:=0;
   for i:=1 to 1023 do begin
    Mantissa:=i shl 13;
    Exponent:=0;
    while (Mantissa and $00800000)=0 do begin // While not normalized
     dec(Exponent,$00800000);                 // Decrement exponent by 1 shl 23
     Mantissa:=Mantissa shl 1;                // Shift mantissa
    end;
    Mantissa:=Mantissa and not $00800000;     // Clear leading 1 bit
    inc(Exponent,$38800000);                  // Adjust bias by (127-14) shl 23
    HalfFloatToFloatMantissaTable[i]:=Mantissa or Exponent;
   end;
   for i:=1024 to 2047 do begin
    HalfFloatToFloatMantissaTable[i]:=TpvUInt32($38000000)+TpvUInt32(TpvUInt32(i-1024) shl 13);
   end;
  end;
  begin
   HalfFloatToFloatExponentTable[0]:=0;
   for i:=1 to 30 do begin
    HalfFloatToFloatExponentTable[i]:=i shl 23;
   end;
   HalfFloatToFloatExponentTable[31]:=$47800000;
   HalfFloatToFloatExponentTable[32]:=0;
   for i:=33 to 62 do begin
    HalfFloatToFloatExponentTable[i]:=TpvUInt32(TpvUInt32(i-32) shl 23) or TpvUInt32($80000000);
   end;
   HalfFloatToFloatExponentTable[63]:=$c7800000;
  end;
  begin
   HalfFloatToFloatOffsetTable[0]:=0;
   for i:=1 to 31 do begin
    HalfFloatToFloatOffsetTable[i]:=1024;
   end;
   HalfFloatToFloatOffsetTable[32]:=0;
   for i:=33 to 63 do begin
    HalfFloatToFloatOffsetTable[i]:=1024;
   end;
  end;
 end;
end;

function AddWithCarry(const a,b:TpvUInt32;var Carry:TpvUInt32):TpvUInt32; {$ifdef caninline}inline;{$endif}
var r:TpvUInt64;
begin
 r:=TpvUInt64(a)+TpvUInt64(b)+TpvUInt64(Carry);
 Carry:=(r shr 32) and 1;
 result:=r and $ffffffff;
end;

function MultiplyWithCarry(const a,b:TpvUInt32;var Carry:TpvUInt32):TpvUInt32; {$ifdef caninline}inline;{$endif}
var r:TpvUInt64;
begin
 r:=(TpvUInt64(a)*TpvUInt64(b))+TpvUInt64(Carry);
 Carry:=r shr 32;
 result:=r and $ffffffff;
end;

function DivideWithRemainder(const a,b:TpvUInt32;var Remainder:TpvUInt32):TpvUInt32; {$ifdef caninline}inline;{$endif}
var r:TpvUInt64;
begin
 r:=(TpvUInt64(Remainder) shl 32) or a;
 Remainder:=r mod b;
 result:=r div b;
end;

class operator TpvUInt128.Implicit(const a:TpvUInt64):TpvUInt128;
begin
 result.Hi:=0;
 result.Lo:=a;
end;

class operator TpvUInt128.Implicit(const a:TpvUInt128):TpvUInt64;
begin
 result:=a.Lo;
end;

class operator TpvUInt128.Explicit(const a:TpvUInt64):TpvUInt128;
begin
 result.Hi:=0;
 result.Lo:=a;
end;

class operator TpvUInt128.Explicit(const a:TpvUInt128):TpvUInt64;
begin
 result:=a.Lo;
end;

class operator TpvUInt128.Add(const a,b:TpvUInt128):TpvUInt128;
var t0,t1,t2,t3:TpvUInt64;
begin
 t0:=a.Hi shr 32;
 t1:=a.Hi and $ffffffff;
 t2:=a.Lo shr 32;
 t3:=a.Lo and $ffffffff;
 inc(t3,b.Lo and $ffffffff);
 inc(t2,(b.Lo shr 32)+(t3 shr 32));
 inc(t1,(b.Hi and $ffffffff)+(t2 shr 32));
 inc(t0,(b.Hi shr 32)+(t1 shr 32));
 result.Hi:=((t0 and $ffffffff) shl 32) or (t1 and $ffffffff);
 result.Lo:=((t2 and $ffffffff) shl 32) or (t3 and $ffffffff);
end;

class operator TpvUInt128.Multiply(const a,b:TpvUInt128):TpvUInt128;
var c,xw,yw,dw:array[0..15] of TpvUInt32;
    i,j,k:TpvInt32;
    v:TpvUInt32;
begin
 for i:=0 to 15 do begin
  c[i]:=0;
 end;
 xw[7]:=(a.Lo shr 0) and $ffff;
 xw[6]:=(a.Lo shr 16) and $ffff;
 xw[5]:=(a.Lo shr 32) and $ffff;
 xw[4]:=(a.Lo shr 48) and $ffff;
 xw[3]:=(a.Hi shr 0) and $ffff;
 xw[2]:=(a.Hi shr 16) and $ffff;
 xw[1]:=(a.Hi shr 32) and $ffff;
 xw[0]:=(a.Hi shr 48) and $ffff;
 yw[7]:=(b.Lo shr 0) and $ffff;
 yw[6]:=(b.Lo shr 16) and $ffff;
 yw[5]:=(b.Lo shr 32) and $ffff;
 yw[4]:=(b.Lo shr 48) and $ffff;
 yw[3]:=(b.Hi shr 0) and $ffff;
 yw[2]:=(b.Hi shr 16) and $ffff;
 yw[1]:=(b.Hi shr 32) and $ffff;
 yw[0]:=(b.Hi shr 48) and $ffff;
 for i:=0 to 7 do begin
  for j:=0 to 7 do begin
   v:=xw[i]*yw[j];
   k:=i+j;
   inc(c[k],v shr 16);
   inc(c[k+1],v and $ffff);
  end;
 end;
 for i:=15 downto 1 do begin
  inc(c[i-1],c[i] shr 16);
  c[i]:=c[i] and $ffff;
 end;
 for i:=0 to 7 do begin
  dw[i]:=c[8+i];
 end;
 result.Hi:=(TpvUInt64(dw[0] and $ffff) shl 48) or (TpvUInt64(dw[1] and $ffff) shl 32) or (TpvUInt64(dw[2] and $ffff) shl 16) or (TpvUInt64(dw[3] and $ffff) shl 0);
 result.Lo:=(TpvUInt64(dw[4] and $ffff) shl 48) or (TpvUInt64(dw[5] and $ffff) shl 32) or (TpvUInt64(dw[6] and $ffff) shl 16) or (TpvUInt64(dw[7] and $ffff) shl 0);
end;

class operator TpvUInt128.IntDivide(const a:TpvUInt128;const b:TpvUInt64):TpvUInt128;
var Quotient:TpvUInt128;
    Remainder:TpvUInt64;
    Bit:TpvInt32;
    Dividend:TpvUInt128 absolute a;
    Divisor:TpvUInt64 absolute b;
begin
 Quotient:=Dividend;
 Remainder:=0;
 for Bit:=1 to 128 do begin
  Remainder:=(Remainder shl 1) or (ord((Quotient.Hi and $8000000000000000)<>0) and 1);
  Quotient.Hi:=(Quotient.Hi shl 1) or (Quotient.Lo shr 63);
  Quotient.Lo:=Quotient.Lo shl 1;
  if (TpvUInt32(Remainder shr 32)>TpvUInt32(Divisor shr 32)) or
     ((TpvUInt32(Remainder shr 32)=TpvUInt32(Divisor shr 32)) and (TpvUInt32(Remainder and $ffffffff)>=TpvUInt32(Divisor and $ffffffff))) then begin
   dec(Remainder,Divisor);
   Quotient.Lo:=Quotient.Lo or 1;
  end;
 end;
 result:=Quotient;
end;

class function TpvUInt128.Mul64(const a,b:TpvUInt64):TpvUInt128;
var u0,u1,v0,v1,k,t,w0,w1,w2:TpvUInt64;
begin
 u1:=a shr 32;
 u0:=a and TpvUInt64($ffffffff);
 v1:=b shr 32;
 v0:=b and TpvUInt64($ffffffff);
 t:=u0*v0;
 w0:=t and TpvUInt64($ffffffff);
 k:=t shr 32;
 t:=(u1*v0)+k;
 w1:=t and TpvUInt64($ffffffff);
 w2:=t shr 32;
 t:=(u0*v1)+w1;
 k:=t shr 32;
 result.Lo:=(t shl 32)+w0;
 result.Hi:=((u1*v1)+w2)+k;
end;

constructor TpvHalfFloat.Create(const pValue:TpvFloat);
var CastedValue:TpvUInt32 absolute pValue;
begin
 Value:=FloatToHalfFloatBaseTable[CastedValue shr 23]+TpvUInt16((CastedValue and $007fffff) shr FloatToHalfFloatShiftTable[CastedValue shr 23]);
end;

class function TpvHalfFloat.FromFloat(const pValue:TpvFloat):TpvHalfFloat;
var CastedValue:TpvUInt32 absolute pValue;
begin
 result.Value:=FloatToHalfFloatBaseTable[CastedValue shr 23]+TpvUInt16((CastedValue and $007fffff) shr FloatToHalfFloatShiftTable[CastedValue shr 23]);
end;

function TpvHalfFloat.ToFloat:TpvFloat;
var f:TpvUInt32;
begin
 f:=HalfFloatToFloatMantissaTable[HalfFloatToFloatOffsetTable[Value shr 10]+(Value and $3ff)]+HalfFloatToFloatExponentTable[Value shr 10];
 result:=TpvFloat(pointer(@f)^);
end;

class operator TpvHalfFloat.Implicit(const a:TpvFloat):TpvHalfFloat;
begin
 result:=TpvHalfFloat.FromFloat(a);
end;

class operator TpvHalfFloat.Implicit(const a:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat;
end;

class operator TpvHalfFloat.Explicit(const a:TpvFloat):TpvHalfFloat;
begin
 result:=TpvHalfFloat.FromFloat(a);
end;

class operator TpvHalfFloat.Explicit(const a:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat;
end;

class operator TpvHalfFloat.Equal(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat=b.ToFloat;
end;

class operator TpvHalfFloat.Equal(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat=b;
end;

class operator TpvHalfFloat.Equal(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a=b.ToFloat;
end;

class operator TpvHalfFloat.NotEqual(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat=b.ToFloat;
end;

class operator TpvHalfFloat.NotEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat<>b;
end;

class operator TpvHalfFloat.NotEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a<>b.ToFloat;
end;

class operator TpvHalfFloat.GreaterThan(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat>b.ToFloat;
end;

class operator TpvHalfFloat.GreaterThan(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat>b;
end;

class operator TpvHalfFloat.GreaterThan(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a>b.ToFloat;
end;

class operator TpvHalfFloat.GreaterThanOrEqual(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat>=b.ToFloat;
end;

class operator TpvHalfFloat.GreaterThanOrEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat>=b;
end;

class operator TpvHalfFloat.GreaterThanOrEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a>=b.ToFloat;
end;

class operator TpvHalfFloat.LessThan(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat<b.ToFloat;
end;

class operator TpvHalfFloat.LessThan(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat<b;
end;

class operator TpvHalfFloat.LessThan(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a<b.ToFloat;
end;

class operator TpvHalfFloat.LessThanOrEqual(const a,b:TpvHalfFloat):boolean;
begin
 result:=a.ToFloat<=b.ToFloat;
end;

class operator TpvHalfFloat.LessThanOrEqual(const a:TpvHalfFloat;const b:TpvFloat):boolean;
begin
 result:=a.ToFloat<=b;
end;

class operator TpvHalfFloat.LessThanOrEqual(const a:TpvFloat;const b:TpvHalfFloat):boolean;
begin
 result:=a<=b.ToFloat;
end;

class operator TpvHalfFloat.Inc(const a:TpvHalfFloat):TpvHalfFloat;
begin
 result:=TpvHalfFloat.FromFloat(a.ToFloat+1.0);
end;

class operator TpvHalfFloat.Dec(const a:TpvHalfFloat):TpvHalfFloat;
begin
 result:=TpvHalfFloat.FromFloat(a.ToFloat-1.0);
end;

class operator TpvHalfFloat.Add(const a,b:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat+b.ToFloat;
end;

class operator TpvHalfFloat.Add(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat;
begin
 result:=a.ToFloat+b;
end;

class operator TpvHalfFloat.Add(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat;
begin
 result:=a+b.ToFloat;
end;

class operator TpvHalfFloat.Subtract(const a,b:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat-b.ToFloat;
end;

class operator TpvHalfFloat.Subtract(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat;
begin
 result:=a.ToFloat-b;
end;

class operator TpvHalfFloat.Subtract(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat;
begin
 result:=a-b.ToFloat;
end;

class operator TpvHalfFloat.Multiply(const a,b:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat*b.ToFloat;
end;

class operator TpvHalfFloat.Multiply(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat;
begin
 result:=a.ToFloat*b;
end;

class operator TpvHalfFloat.Multiply(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat;
begin
 result:=a*b.ToFloat;
end;

class operator TpvHalfFloat.Divide(const a,b:TpvHalfFloat):TpvFloat;
begin
 result:=a.ToFloat/b.ToFloat;
end;

class operator TpvHalfFloat.Divide(const a:TpvHalfFloat;const b:TpvFloat):TpvFloat;
begin
 result:=a.ToFloat/b;
end;

class operator TpvHalfFloat.Divide(const a:TpvFloat;const b:TpvHalfFloat):TpvFloat;
begin
 result:=a/b.ToFloat;
end;

class operator TpvHalfFloat.Modulus(const a,b:TpvHalfFloat):TpvFloat;
var x,y:TpvFloat;
begin
 x:=a.ToFloat;
 y:=b.ToFloat;
 result:=x-(floor(x/y)*y);
end;

class operator TpvHalfFloat.Negative(const a:TpvHalfFloat):TpvHalfFloat;
begin
 result.Value:=a.Value xor $8000;
end;

class operator TpvHalfFloat.Positive(const a:TpvHalfFloat):TpvHalfFloat;
begin
 result:=a;
end;

function TpvHalfFloat.Abs:TpvHalfFloat;
begin
 result.Value:=Value and $7fff;
end;

function TpvHalfFloat.IsNaN:boolean;
begin
 result:=(Value and $7fff)>$7c00;
end;

function TpvHalfFloat.IsInfinity:boolean;
begin
 result:=(Value and $7fff)=$7c00;
end;

function TpvHalfFloat.IsNegativeInfinity:boolean;
begin
 result:=Value=$fc00;
end;

function TpvHalfFloat.IsPositiveInfinity:boolean;
begin
 result:=Value=$7c00;
end;

class function TpvUUID.Create:TpvUUID;
begin
{$define UseCreateGUID}
{$ifdef UseCreateGUID}
 CreateGUID(result.GUID);
{$else}
 // Version 4 UUIDs use a scheme relying only on random numbers. This algorithm sets the version number
 // (4 bits) as well as two reserved bits. All other bits (the remaining 122 bits) are set using a random
 // or pseudorandom data source. Version 4 UUIDs have the form xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx where
 // x is any hexadecimal digit and y is one of 8, 9, A, or B (e.g., f47ac10b-58cc-4372-a567-0e02b2c3d479).
 result.QuadTpvUInt16s[0]:=RandomGenerator.Get64;
 result.QuadTpvUInt16s[1]:=RandomGenerator.Get64;
 result.D3:=(D3 and $0fff) or $4000;
 result.D4[0]:=(D4[0] and $3f) or $80;
{$endif}
end;

constructor TpvUUID.CreateFromString(const UUID:TpvUUIDString);
 function StringToHex(const Hex:TpvUUIDString):TpvUInt32;
 var Counter:TpvInt32;
     Nibble:TpvUInt8;
     c:AnsiChar;
 begin
  result:=0;
  for Counter:=1 to length(Hex) do begin
   c:=AnsiChar(Hex[Counter]);
   case C of
    'A'..'F':begin
     Nibble:=(TpvUInt8(AnsiChar(c))-TpvUInt8(AnsiChar('A')))+$a;
    end;
    'a'..'f':begin
     Nibble:=(TpvUInt8(AnsiChar(c))-TpvUInt8(AnsiChar('a')))+$a;
    end;
    '0'..'9':begin
     Nibble:=TpvUInt8(AnsiChar(c))-TpvUInt8(AnsiChar('0'));
    end;
    else begin
     Nibble:=0;
    end;
   end;
   result:=(result shl 4) or Nibble;
  end;
 end;
begin
 if (length(UUID)=38) and
    (UUID[1]='{') and
    (UUID[10]='-') and
    (UUID[15]='-') and
    (UUID[20]='-') and
    (UUID[25]='-') and
    (UUID[38]='}') then begin
  D1:=StringToHex(copy(UUID,2,8));
  D2:=StringToHex(copy(UUID,11,4));
  D3:=StringToHex(copy(UUID,16,4));
  D4[0]:=StringToHex(copy(UUID,21,2));
  D4[1]:=StringToHex(copy(UUID,23,2));
  D4[2]:=StringToHex(copy(UUID,26,2));
  D4[3]:=StringToHex(copy(UUID,28,2));
  D4[4]:=StringToHex(copy(UUID,30,2));
  D4[5]:=StringToHex(copy(UUID,32,2));
  D4[6]:=StringToHex(copy(UUID,34,2));
  D4[7]:=StringToHex(copy(UUID,36,2));
 end else begin
  QuadTpvUInt16s[0]:=0;
  QuadTpvUInt16s[1]:=0;
 end;
end;

function TpvUUID.ToString:TpvUUIDString;
 function HexToString(const Value:TpvUInt32;const Digits:longint):TpvUUIDString;
 var Index:TpvInt32;
     Nibble:TpvUInt8;
 begin
  result:='';
  SetLength(result,Digits);
  for Index:=1 to Digits do begin
   Nibble:=(Value shr ((Digits-Index) shl 2)) and $f;
   case Nibble of
    $0..$9:begin
     result[Index]:=Char(AnsiChar(TpvUInt8(Nibble+TpvUInt8(ansichar('0')))));
    end;
    $a..$f:begin
     result[Index]:=Char(AnsiChar(TpvUInt8((Nibble-$a)+TpvUInt8(ansichar('a')))));
    end;
   end;
  end;
 end;
begin
 result:='{'+HexToString(D1,8)+'-'+HexToString(D2,4)+'-'+HexToString(D3,4)+'-'+HexToString(D4[0],2)+HexToString(D4[1],2)+'-'+HexToString(D4[2],2)+HexToString(D4[3],2)+HexToString(D4[4],2)+HexToString(D4[5],2)+HexToString(D4[6],2)+HexToString(D4[7],2)+'}';
end;

class operator TpvUUID.Implicit(const a:TpvUUID):TpvUUIDString;
begin
 result:=a.ToString;
end;

class operator TpvUUID.Implicit(const a:TpvUUIDString):TpvUUID;
begin
 result:=TpvUUID.CreateFromString(a);
end;

class operator TpvUUID.Explicit(const a:TpvUUID):TpvUUIDString;
begin
 result:=a.ToString;
end;

class operator TpvUUID.Explicit(const a:TpvUUIDString):TpvUUID;
begin
 result:=TpvUUID.CreateFromString(a);
end;

class operator TpvUUID.Equal(const a,b:TpvUUID):boolean;
begin
 result:=(a.D1=b.D1) and
         (a.D2=b.D2) and
         (a.D3=b.D3) and
         (a.D4[0]=b.D4[0]) and
         (a.D4[1]=b.D4[1]) and
         (a.D4[2]=b.D4[2]) and
         (a.D4[3]=b.D4[3]) and
         (a.D4[4]=b.D4[4]) and
         (a.D4[5]=b.D4[5]) and
         (a.D4[6]=b.D4[6]) and
         (a.D4[7]=b.D4[7]);
end;

class operator TpvUUID.NotEqual(const a,b:TpvUUID):boolean;
begin
 result:=(a.D1<>b.D1) or
         (a.D2<>b.D2) or
         (a.D3<>b.D3) or
         (a.D4[0]<>b.D4[0]) or
         (a.D4[1]<>b.D4[1]) or
         (a.D4[2]<>b.D4[2]) or
         (a.D4[3]<>b.D4[3]) or
         (a.D4[4]<>b.D4[4]) or
         (a.D4[5]<>b.D4[5]) or
         (a.D4[6]<>b.D4[6]) or
         (a.D4[7]<>b.D4[7]);
end;

initialization
 GenerateHalfFloatLookUpTables;
end.
