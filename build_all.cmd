@echo off


set MY_DIR="%cd%"

cd "%~dp0"

call builder -32bit -Release -upx
call builder -64bit -Release -upx

cd %MY_DIR%


@echo on
