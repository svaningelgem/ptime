@echo off


set MY_DIR="%cd%"

cd "%~dp0"

call builder -32bit -Release
call builder -64bit -Release

cd %MY_DIR%


@echo on
