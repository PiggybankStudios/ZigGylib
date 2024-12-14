@echo off

echo [Testing...]
rem zig test -femit-docs ../main.zig
rem zig test ../main.zig
zig test ../learning1.zig
echo [Building...]
rem zig build-exe ../main.zig
rem zig build-exe ../learning1.zig
rem TODO: Still now sure how to get this compiling fully. Need to figure out how to link with libc
rem zig build-exe ../sine_wave.zig -L"D:/gamedev/lib" -llibc
echo [Done!]
