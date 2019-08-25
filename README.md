# pasvulkan

Vulkan header generator and Vulkan OOP-style API wrapper for Object Pascal (FreePascal >= 3.1.1 FPC SVN revision 33196 and Delphi >= 2009)

The Vulkan.pas binding header unit itself (including the vkxml2pas.dpr converter) is and stays also compatible with the old Delphi 7 version, but the PasVulkan.*.pas framework units are no more Delphi 7 compatible, because they are using new Object Pascal syntax features, as such as generics, operator overloading, advanced records and so on, which for these the old Delphi 7 compiler version have no support for.

## Support me

[Support me at Patreon](https://www.patreon.com/bero)

## About me / My contact details

- [My website](https://www.rosseaux.net)
- [My blog](https://blog.rosseaux.net)
- [My Twitter account](https://twitter.com/coder)
- [My Facebook account](https://www.facebook.com/benjamin.rosseaux)

## Important information

You must first compile the (yet incomplete) PasVulkan project manager using compileprojectmanager (*nix) or compileprojectmanager.bat (Windows) so that you can then use the PasVulkan project manager as a command line tool named projectmanager(.exe) .

And you do need either the most current Delphi version or the most current SVN trunk version of the FreePascal compiler (and not just the stable version of the FreePascal compiler), including correct paths in your PATH environment variable to these compiler binaries. And if you also want to use the Android target, the same applies to Android Studio, the Java SDK, the Android SDK and the Android NDK, that these must be installed at their default locations (as Google prescribes or specifies these default locations, without exceptions) and must be correctly exist in the system environment variables.

## How to build and to run the example project

After you've compiled the projectmanager binary, you need to do the following: 
  
| Step | Windows                                  | *nix                                      | Description                                |
| ---- | ---------------------------------------- | ----------------------------------------- | ------------------------------------------ |
| 1.   | `projectmanager compileassets examples`  | `./projectmanager compileassets examples` | It compiles the asset files                |
| 2.   | `projectmanager build examples`          | `./projectmanager build examples`         | It compiles the example code itself        |
| 3.   | `projectmanager run examples`            | `./projectmanager run examples`           | It starts the example binary               |

[![Video example](https://img.youtube.com/vi/GepQbRIjbeQ/0.jpg)](https://www.youtube.com/watch?v=GepQbRIjbeQ)

## How to create a new project

After you've compiled the projectmanager binary, you need to do the following: 
  
| Step | Windows                                   | *nix                                        | Description                                |
| ---- | ----------------------------------------- | ------------------------------------------- | ------------------------------------------ |
| 1.   | `projectmanager create [yourprojectname]` | `./projectmanager create [yourprojectname]` | It creates the new project                 |

*Important:* Where the project name must be a valid lowercase pascal *and* java identifier *and* even a valid file name at the same time!

[![Video example](https://img.youtube.com/vi/dgRwS3oWUNc/0.jpg)](https://www.youtube.com/watch?v=dgRwS3oWUNc)

## For further information regarding the project manager

After you've compiled the projectmanager binary, just execute `projectmanager -h` in your shell or console for a detailed help output. 

## Features

- C-API-style Vulkan header (Vulkan.pas which is generated by vkxml2pas.dpr)
    - It's always up-to-date, since it's auto-generated through the vkxml2pas.dpr
    - Supported platforms:
        - Windows (x86-32, x86-64)
        - Android (x86-32, x86-64, ARM)
        - Linux (x86-32, x86-64, ARM)
            - X11
            - Wayland
        - MoltenVK wrapper (untested)
            - iOS
            - MacOS
- OOP-based Vulkan Framework (PasVulkan.Framework.pas)
    - Object oriented Vulkan API abstraction
    - Best-fit red-black-tree based memory manager for the Vulkan memory management, for to manage the sub-allocations in the allocated buffers and for to keep the total count of simultaneous live allocations as much low as possible and less than TVkPhysicalDeviceLimits.maxMemoryAllocationCount.
    - Texture loaders with own ObjectPascal-native loader implementations, so it is independent of external third-party image loaders, even independent of the VCL, LCL and FCL.  
        - BMP (untested, but it should work)
        - DDS
        - HDR
        - KTX
        - JPG / JPEG (only baseline, only Huffman-coded and only YCrCb at the moment now) 
        - PNG (all types, including 16-bit channel PNGs)
        - TGA
    - Features swap chain screenshot API functions
        - including an own ObjectPascal-native minimal PNG writer implementation (including an own minimal static-huffman only deflate implementation)
        - including an own ObjectPascal-native JPEG writer implementation
    - Optional automatic GPU-based texture mipmap generation (with help of vkCmdBlitImage)
    - Own ObjectPascal-native TrueType/OpenType Font loader implementation
        - With experimental PostScript-flavoured OpenType Font support (CFF Type 2)
        - With semi-working TrueType-flavoured OpenType Font hinting byte code interpreter as an optional option
        - With automatic on-the-fly high-quality fast parallizied signed distance field generation (based on the implementation ideas from [Practical Analytic 2D Signed Distance Field Generation](https://web.archive.org/web/20160909051854/http://malideveloper.arm.com/downloads/Presentations/Siggraph16/Practical_Analytic_2D_Signed_Distance_Field_Generation.pdf) and with [PasMP](https://github.com/BeRo1985/pasmp) )
        - A [font vector textures](http://wdobbie.com/post/gpu-text-rendering-with-vector-textures/) feature is also planned for the future, for an own combined signed-distance-field + vector-texture hybrid font rendering technology implementation, dependently by the font size and so on, where the RGB channels of a texel would be then the together OR'ed 24-bit first-bezier-linked-list-index (to a Vulkan buffer with the bezier data, 0xffffff = no (next) bezier), and the alpha channel of a texel would be just the 8-bit signed distance field.
    - Sprite batch class
    - Sprite atlases
        - With automatic fast on-the-fly sprite atlas constructions with optional automatic cropping/trimming, so that you don't need external sprite atlas generation tools, but nevertheless, the output of the TexturePacker tool is also supported by PasVulkan
    - and more useful utils and stuff for Vulkan-programming
    - Supported platforms:
        - Windows (x86-32, x86-64)
        - Android (x86-32, x86-64, ARM32, ARM64/AArch64)
        - Linux (x86-32, x86-64, ARM)
            - X11
            - Mir
            - Wayland
        - MoltenVK wrapper (untested)
            - iOS
            - MacOS
- OOP-style Vulkan-optimized Application framework (PasVulkan.Application.pas PasVulkan.Android.pas PasVulkan.SDL2.pas PasVulkan.StarticLinking.pas)
    - The overall design of this Vulkan-optimized Application framework is mixture between the VCL/LCL/FCL and libGDX design concepts (and some of my own design ideas, of course).
    - It uses SDL 2.x as OS-API abstraction layer API
    - Single-window-only, so it is cross-platform-friendly to the maximum, as far as it is possible.
        - For multi-window applications, you must do your own stuff (for example, own framework or using the VCL/LCL etc.), because it is out of the focus of the targets from this Vulkan-optimized Application framework
    - Automatic recovery for:
        - VK_ERROR_SURFACE_LOST_KHR
        - VK_ERROR_OUT_OF_DATE_KHR
        - VK_SUBOPTIMAL_KHR
        - but not for, for example, VK_ERROR_DEVICE_LOST, VK_ERROR_OUT_OF_DEVICE_MEMORY or VK_ERROR_OUT_OF_HOST_MEMORY, because that are critical situations, which you must handle yourself.
    - Automatic Swap Chain creation and recreation
    - Re-abstraction of the SDL2 abstraction, for the possible future case, when this Vulkan-optimized Application framework will be not SDL 2.0 based for possible further following target platforms, the Nintendo Switch as example, or when this Vulkan-optimized Application framework will be no more SDL 2.0 based for some already supported target platforms.  
    - Supported platforms:
        - Windows (x86-32, x86-64)
        - Android (x86-32, x86-64, ARM32, ARM64/AArch64 ) 
        - Linux (x86-32, x86-64, ARM)
            - X11
            - Mir
            - Wayland
        - But no MoltenVK yet (since SDL 2.x has no support for it yet, so far I know) 
            
## License (zlib)

    Copyright (C) 2016-2017, Benjamin Rosseaux (benjamin@rosseaux.de)          
                                                                             
    This software is provided 'as-is', without any express or implied          
    warranty. In no event will the authors be held liable for any damages      
    arising from the use of this software.                                     
                                                                             
    Permission is granted to anyone to use this software for any purpose,     
    including commercial applications, and to alter it and redistribute it    
    freely, subject to the following restrictions:                            
 
    1. The origin of this software must not be misrepresented; you must not    
       claim that you wrote the original software. If you use this software    
       in a product, an acknowledgement in the product documentation would be  
       appreciated but is not required.                                        
    2. Altered source versions must be plainly marked as such, and must not be 
       misrepresented as being the original software.                          
    3. This notice may not be removed or altered from any source distribution. 
     
## General guidelines for code contributors 

 1. Make sure you are legally allowed to make a contribution under the zlib license.
 2. The zlib license header goes at the top of each source file, with appropriate copyright notice.
 3. This PasVulkan wrapper may be used only with the PasVulkan-own Vulkan Pascal header.
 4. After a pull request, check the status of your pull request on https://github.com/BeRo1985/pasvulkan
 5. Write code which's compatible with Delphi >= 2009 and FreePascal >= 3.1.1 
 6. Don't use Delphi-only, FreePascal-only or Lazarus-only libraries/units, but if needed, make it out-ifdef-able.
 7. No use of third-party libraries/units as possible, but if needed, make it out-ifdef-able.                       
 8. Try to use const when possible.
 9. Make sure to comment out writeln, used while debugging.
 10. Make sure the code compiles on 32-bit and 64-bit platforms (x86-32, x86-64, ARM, ARM64, etc.).
 11. Make sure the code runs on all platforms with Vulkan support           
          
## Showcase videos

- For more recent showcase videos see [Youtube playlist](https://www.youtube.com/playlist?list=PLoqdQblnX8vTx3menwS15yIMAldRZzPa7)

- PasVulkan on Android 7.0 on a NVIDIA Shield K1 Tablet
  [![PasVulkan on Android 7.0 on a NVIDIA Shield K1 Tablet](https://img.youtube.com/vi/aXIaW7-rHGI/0.jpg)](https://www.youtube.com/watch?v=aXIaW7-rHGI)

- PasVulkan on a NVIDIA Geforce GTX 970 under Windows 10 Pro
  [![PasVulkan on a NVIDIA Geforce GTX 970 under Windows 10 Pro](https://img.youtube.com/vi/6nWdgry84vM/0.jpg)](https://www.youtube.com/watch?v=6nWdgry84vM)

  
