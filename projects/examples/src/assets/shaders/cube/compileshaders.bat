@echo off
"%VULKAN_SDK%/Bin32/glslangValidator.exe" -V cube.vert -o cube_vert.spv
"%VULKAN_SDK%/Bin32/glslangValidator.exe" -V cube.frag -o cube_frag.spv
for %%f in (*.spv) do (
  spirv-opt --strip-debug --unify-const --flatten-decorations --eliminate-dead-const %%f -o %%f
)
copy /y cube_vert.spv ..\..\..\..\assets\cube_vert.spv
copy /y cube_frag.spv ..\..\..\..\assets\cube_frag.spv
del /f /q *.spv



