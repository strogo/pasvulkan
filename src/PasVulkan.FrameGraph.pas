(******************************************************************************
 *                                 PasVulkan                                  *
 ******************************************************************************
 *                       Version see PasVulkan.FrameFrame.pas                  *
 ******************************************************************************
 *                                zlib license                                *
 *============================================================================*
 *                                                                            *
 * Copyright (C) 2016-2018, Benjamin Rosseaux (benjamin@rosseaux.de)          *
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
 * 5. Write code which's compatible with Delphi >= 2009 and FreePascal >=     *
 *    3.1.1                                                                   *
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
unit PasVulkan.FrameGraph;
{$i PasVulkan.inc}
{$ifndef fpc}
 {$ifdef conditionalexpressions}
  {$if CompilerVersion>=24.0}
   {$legacyifend on}
  {$ifend}
 {$endif}
{$endif}

interface

uses SysUtils,
     Classes,
     Math,
     Vulkan,
     PasVulkan.Types,
     PasVulkan.Math,
     PasVulkan.Collections,
     PasVulkan.Framework;

// Inspired from:
//   https://www.ea.com/frostbite/news/framegraph-extensible-rendering-architecture-in-frostbite
//   https://www.gdcvault.com/play/1024612/FrameGraph-Extensible-Rendering-Architecture-in
//   https://www.slideshare.net/DICEStudio/framegraph-extensible-rendering-architecture-in-frostbite
//   http://themaister.net/blog/2017/08/15/render-graphs-and-vulkan-a-deep-dive/

// Attention: It is still work in progress

type EpvFrameGraph=class(Exception);

     EpvFrameGraphEmptyName=class(EpvFrameGraph);

     EpvFrameGraphDuplicateName=class(EpvFrameGraph);

     TpvFrameGraph=class
      public
       type TFrameGraphObject=class
             private
              fFrameGraph:TpvFrameGraph;
              fName:TpvRawByteString;
             public
              constructor Create(const aFrameGraph:TpvFrameGraph;
                                 const aName:TpvRawByteString); virtual;
              destructor Destroy; override;
             published
              property FrameGraph:TpvFrameGraph read fFrameGraph;
              property Name:TpvRawByteString read fName write fName;
            end;
            TFrameGraphObjectList=TpvObjectGenericList<TFrameGraphObject>;
            TFrameGraphObjectNameHashMap=TpvStringHashMap<TFrameGraphObject>;
            TAttachmentType=
             (
              Undefined,
              Surface,
              Color,
              Depth,
              DepthStencil,
              Stencil
             );
            PAttachmentType=^TAttachmentType;
            TAttachmentSize=record
             public
              type TKind=
                    (
                     Undefined,
                     Absolute,
                     SurfaceDependent
                    );
                   PKind=^TKind;
             public
              Kind:TKind;
              Size:TVkExtent3D;
              class function CreateEmpty:TAttachmentSize; static;
              constructor Create(const aKind:TAttachmentSize.TKind;
                                 const aWidth:TpvUInt32=1;
                                 const aHeight:TpvUInt32=1;
                                 const aDepth:TpvUInt32=1); overload;
              constructor Create(const aKind:TAttachmentSize.TKind;
                                 const aSize:TVkExtent2D;
                                 const aDepth:TpvUInt32=1); overload;
              constructor Create(const aKind:TAttachmentSize.TKind;
                                 const aSize:TVkExtent3D); overload;
              class operator Equal(const aLeft,aRight:TAttachmentSize):boolean;
              class operator NotEqual(const aLeft,aRight:TAttachmentSize):boolean;
            end;
            PAttachmentSize=^TAttachmentSize;
            TResourceType=class(TFrameGraphObject)
             public
              type TMetaType=
                    (
                     None,
                     Attachment,
                     Image,
                     Buffer
                    );
                    PMetaType=^TMetaType;
                    TAttachmentData=record
                     public
                      Format:TVkFormat;
                      Samples:TVkSampleCountFlagBits;
                      AttachmentType:TAttachmentType;
                      AttachmentSize:TAttachmentSize;
                      ImageUsage:TVkImageUsageFlags;
                      Components:TVkComponentMapping;
                      class function CreateEmpty:TAttachmentData; static;
                      constructor Create(const aFormat:TVkFormat;
                                         const aSamples:TVkSampleCountFlagBits;
                                         const aAttachmentType:TAttachmentType;
                                         const aAttachmentSize:TAttachmentSize;
                                         const aImageUsage:TVkImageUsageFlags;
                                         const aComponents:TVkComponentMapping);
                      class operator Equal(const aLeft,aRight:TAttachmentData):boolean;
                      class operator NotEqual(const aLeft,aRight:TAttachmentData):boolean;
                    end;
                    PAttachmentData=^TAttachmentData;
             private
              fPersientent:boolean;
              fMetaType:TMetaType;
              fAttachmentData:TAttachmentData;
              fPointerToAttachmentData:PAttachmentData;
             public
              constructor Create(const aFrameGraph:TpvFrameGraph;
                                 const aName:TpvRawByteString;
                                 const aPersientent:boolean;
                                 const aMetaType:TMetaType;
                                 const aAttachmentData:TAttachmentData); reintroduce; overload;
              constructor Create(const aFrameGraph:TpvFrameGraph;
                                 const aName:TpvRawByteString;
                                 const aPersientent:boolean;
                                 const aMetaType:TMetaType); reintroduce; overload;
              constructor CreateAttachment(const aFrameGraph:TpvFrameGraph;
                                           const aName:TpvRawByteString;
                                           const aPersientent:boolean;
                                           const aFormat:TVkFormat;
                                           const aSamples:TVkSampleCountFlagBits;
                                           const aAttachmentType:TAttachmentType;
                                           const aAttachmentSize:TAttachmentSize;
                                           const aImageUsage:TVkImageUsageFlags;
                                           const aComponents:TVkComponentMapping); reintroduce; overload;
              constructor CreateAttachment(const aFrameGraph:TpvFrameGraph;
                                           const aName:TpvRawByteString;
                                           const aPersientent:boolean;
                                           const aFormat:TVkFormat;
                                           const aSamples:TVkSampleCountFlagBits;
                                           const aAttachmentType:TAttachmentType;
                                           const aAttachmentSize:TAttachmentSize;
                                           const aImageUsage:TVkImageUsageFlags); reintroduce; overload;
              destructor Destroy; override;
             public
              property AttachmentData:TAttachmentData read fAttachmentData write fAttachmentData;
              property PointerToAttachmentData:PAttachmentData read fPointerToAttachmentData write fPointerToAttachmentData;
             published
              property Persientent:boolean read fPersientent write fPersientent;
              property MetaType:TMetaType read fMetaType write fMetaType;
            end;
            TPass=class(TFrameGraphObject)
             private
             public
             published
            end;
            TComputePass=class(TPass)
            end;
            TRenderPass=class(TPass)
            end;
      private
       fObjectList:TFrameGraphObjectList;
       fObjectNameHashMap:TFrameGraphObjectNameHashMap;
      public
       constructor Create;
       destructor Destroy; override;
     end;

implementation

{ TpvFrameGraph.TFrameGraphObject }

constructor TpvFrameGraph.TFrameGraphObject.Create(const aFrameGraph:TpvFrameGraph;
                                              const aName:TpvRawByteString);
begin
 inherited Create;
 if length(trim(fName))=0 then begin
  raise EpvFrameGraphEmptyName.Create('Empty name');
 end;
 if aFrameGraph.fObjectNameHashMap.ExistKey(aName) then begin
  raise EpvFrameGraphDuplicateName.Create('Duplicate name');
 end;
 fFrameGraph:=aFrameGraph;
 fName:=aName;
 fFrameGraph.fObjectList.Add(self);
 fFrameGraph.fObjectNameHashMap.Add(fName,self);
end;

destructor TpvFrameGraph.TFrameGraphObject.Destroy;
begin
 if assigned(fFrameGraph) then begin
  fFrameGraph.fObjectList.Remove(self);
  fFrameGraph.fObjectNameHashMap.Delete(fName);
 end;
 fFrameGraph:=nil;
 inherited Destroy;
end;

{ TpvFrameGraph.TAttachmentSize }

class function TpvFrameGraph.TAttachmentSize.CreateEmpty:TAttachmentSize;
begin
 result.Kind:=TpvFrameGraph.TAttachmentSize.TKind.Undefined;
 result.Size:=TVkExtent3D.Create(0,0,0);
end;

constructor TpvFrameGraph.TAttachmentSize.Create(const aKind:TAttachmentSize.TKind;
                                                 const aWidth:TpvUInt32=1;
                                                 const aHeight:TpvUInt32=1;
                                                 const aDepth:TpvUInt32=1);
begin
 Kind:=aKind;
 Size:=TVkExtent3D.Create(aWidth,aHeight,aDepth);
end;

constructor TpvFrameGraph.TAttachmentSize.Create(const aKind:TAttachmentSize.TKind;
                                                 const aSize:TVkExtent2D;
                                                 const aDepth:TpvUInt32=1);
begin
 Kind:=aKind;
 Size:=TVkExtent3D.Create(aSize.Width,aSize.Height,aDepth);
end;

constructor TpvFrameGraph.TAttachmentSize.Create(const aKind:TAttachmentSize.TKind;
                                                 const aSize:TVkExtent3D);
begin
 Kind:=aKind;
 Size:=aSize;
end;

class operator TpvFrameGraph.TAttachmentSize.Equal(const aLeft,aRight:TAttachmentSize):boolean;
begin
 result:=(aLeft.Kind=aRight.Kind) and
         (aLeft.Size.Width=aRight.Size.Width) and
         (aLeft.Size.Height=aRight.Size.Height) and
         (aLeft.Size.Depth=aRight.Size.Depth);
end;

class operator TpvFrameGraph.TAttachmentSize.NotEqual(const aLeft,aRight:TAttachmentSize):boolean;
begin
 result:=(aLeft.Kind<>aRight.Kind) or
         (aLeft.Size.Width<>aRight.Size.Width) or
         (aLeft.Size.Height<>aRight.Size.Height) or
         (aLeft.Size.Depth<>aRight.Size.Depth);
end;

{ TpvFrameGraph.TResourceType.TAttachmentData }

class function TpvFrameGraph.TResourceType.TAttachmentData.CreateEmpty:TAttachmentData;
begin
 result.Format:=VK_FORMAT_UNDEFINED;
 result.Samples:=VK_SAMPLE_COUNT_1_BIT;
 result.AttachmentType:=TAttachmentType.Undefined;
 result.AttachmentSize:=TAttachmentSize.CreateEmpty;
 result.ImageUsage:=TVkImageUsageFlags(VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT);
 result.Components:=TVkComponentMapping.Create(VK_COMPONENT_SWIZZLE_R,
                                               VK_COMPONENT_SWIZZLE_G,
                                               VK_COMPONENT_SWIZZLE_B,
                                               VK_COMPONENT_SWIZZLE_A);
end;

constructor TpvFrameGraph.TResourceType.TAttachmentData.Create(const aFormat:TVkFormat;
                                                               const aSamples:TVkSampleCountFlagBits;
                                                               const aAttachmentType:TAttachmentType;
                                                               const aAttachmentSize:TAttachmentSize;
                                                               const aImageUsage:TVkImageUsageFlags;
                                                               const aComponents:TVkComponentMapping);
begin
 Format:=aFormat;
 Samples:=aSamples;
 AttachmentType:=aAttachmentType;
 AttachmentSize:=aAttachmentSize;
 ImageUsage:=aImageUsage;
 Components:=aComponents;
end;

class operator TpvFrameGraph.TResourceType.TAttachmentData.Equal(const aLeft,aRight:TAttachmentData):boolean;
begin
 result:=(aLeft.Format=aRight.Format) and
         (aLeft.Samples=aRight.Samples) and
         (aLeft.AttachmentType=aRight.AttachmentType) and
         (aLeft.AttachmentSize=aRight.AttachmentSize) and
         (aLeft.ImageUsage=aRight.ImageUsage) and
         (aLeft.Components.r=aRight.Components.r) and
         (aLeft.Components.g=aRight.Components.g) and
         (aLeft.Components.b=aRight.Components.b) and
         (aLeft.Components.a=aRight.Components.a);
end;

class operator TpvFrameGraph.TResourceType.TAttachmentData.NotEqual(const aLeft,aRight:TAttachmentData):boolean;
begin
 result:=(aLeft.Format<>aRight.Format) or
         (aLeft.Samples<>aRight.Samples) or
         (aLeft.AttachmentType<>aRight.AttachmentType) or
         (aLeft.AttachmentSize<>aRight.AttachmentSize) or
         (aLeft.ImageUsage<>aRight.ImageUsage) or
         (aLeft.Components.r<>aRight.Components.r) or
         (aLeft.Components.g<>aRight.Components.g) or
         (aLeft.Components.b<>aRight.Components.b) or
         (aLeft.Components.a<>aRight.Components.a);
end;

{ TpvFrameGraph.TResourceType }

constructor TpvFrameGraph.TResourceType.Create(const aFrameGraph:TpvFrameGraph;
                                               const aName:TpvRawByteString;
                                               const aPersientent:boolean;
                                               const aMetaType:TMetaType;
                                               const aAttachmentData:TAttachmentData);
begin
 inherited Create(fFrameGraph,fName);
 fPersientent:=aPersientent;
 fMetaType:=aMetaType;
 fAttachmentData:=aAttachmentData;
 fPointerToAttachmentData:=@fAttachmentData;
end;

constructor TpvFrameGraph.TResourceType.Create(const aFrameGraph:TpvFrameGraph;
                                               const aName:TpvRawByteString;
                                               const aPersientent:boolean;
                                               const aMetaType:TMetaType);
begin
 Create(aFrameGraph,
        aName,
        aPersientent,
        aMetaType,
        TAttachmentData.CreateEmpty);
end;

constructor TpvFrameGraph.TResourceType.CreateAttachment(const aFrameGraph:TpvFrameGraph;
                                                         const aName:TpvRawByteString;
                                                         const aPersientent:boolean;
                                                         const aFormat:TVkFormat;
                                                         const aSamples:TVkSampleCountFlagBits;
                                                         const aAttachmentType:TAttachmentType;
                                                         const aAttachmentSize:TAttachmentSize;
                                                         const aImageUsage:TVkImageUsageFlags;
                                                         const aComponents:TVkComponentMapping);
begin
 Create(aFrameGraph,
        aName,
        aPersientent,
        TMetaType.Attachment,
        TAttachmentData.Create(aFormat,
                               aSamples,
                               aAttachmentType,
                               aAttachmentSize,
                               aImageUsage,
                               aComponents));
end;

constructor TpvFrameGraph.TResourceType.CreateAttachment(const aFrameGraph:TpvFrameGraph;
                                                         const aName:TpvRawByteString;
                                                         const aPersientent:boolean;
                                                         const aFormat:TVkFormat;
                                                         const aSamples:TVkSampleCountFlagBits;
                                                         const aAttachmentType:TAttachmentType;
                                                         const aAttachmentSize:TAttachmentSize;
                                                         const aImageUsage:TVkImageUsageFlags);
begin
 CreateAttachment(aFrameGraph,
                  aName,
                  aPersientent,
                  aFormat,
                  aSamples,
                  aAttachmentType,
                  aAttachmentSize,
                  aImageUsage,
                  TVkComponentMapping.Create(VK_COMPONENT_SWIZZLE_R,
                                             VK_COMPONENT_SWIZZLE_G,
                                             VK_COMPONENT_SWIZZLE_B,
                                             VK_COMPONENT_SWIZZLE_A));
end;

destructor TpvFrameGraph.TResourceType.Destroy;
begin
 inherited Destroy;
end;

{ TpvFrameGraph }

constructor TpvFrameGraph.Create;
begin
 inherited Create;
 fObjectList:=TFrameGraphObjectList.Create;
 fObjectList.OwnsObjects:=false;
 fObjectNameHashMap:=TFrameGraphObjectNameHashMap.Create(nil);
end;

destructor TpvFrameGraph.Destroy;
begin
 while fObjectList.Count>0 do begin
  fObjectList.Items[fObjectList.Count-1].Free;
 end;
 FreeAndNil(fObjectList);
 FreeAndNil(fObjectNameHashMap);
 inherited Destroy;
end;

end.