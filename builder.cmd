@echo off


rem https://stackoverflow.com/questions/3785976/cmake-generate-visual-studio-2008-solution-for-win32-and-x64


rem ===== Usage
rem builder [-32bit|-64bit] [-Debug|-Release]
rem --> Defaults: -64bit -Release


rem Global configuration variables. Should be update based on your system
SET VISUAL_STUDIO_HOME=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC
SET VISUAL_STUDIO_NAME=Visual Studio 16 2019
SET CMAKE_HOME=C:\Program Files\CMake

rem First parameter is project folder path
SET PROJECT_DIR="%~dp0"
SET ORIGINAL_DIR="%cd%"
SET CMAKE="%CMAKE_HOME%\bin\cmake.exe"

rem Go to project directory
cd %PROJECT_DIR%

rem Second parameter defines 32 bit or 64 bit compilation
if "%1"=="-32bit" (
  echo === Generating 32bit project ===

  rmdir /s /q build_32
  md build_32
  cd build_32
  %CMAKE% .. -G "%VISUAL_STUDIO_NAME%" -A Win32
) ELSE (
  echo === Generating 64bit project ===

  rmdir /s /q build_64
  md build_64
  cd build_64
  %CMAKE% .. -G "%VISUAL_STUDIO_NAME%" -A x64
)

rem Third parameter defines debug or release compilation
if "%2"=="-Debug" (
  echo === Building in Debug mode ===
  %CMAKE% --build . --target PACKAGE --config Debug
) ELSE (
  echo === Building in Release mode ===
  %CMAKE% --build . --target PACKAGE --config Release
)


rem Go to source code directory and finalize script
cd %ORIGINAL_DIR%

@echo on
