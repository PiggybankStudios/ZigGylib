@echo off

echo [Testing...]
rem zig test -femit-docs ../main.zig
rem zig test ../main.zig
zig test ../learning1.zig
echo [Building...]
rem zig build-exe ../main.zig
zig build-exe ../learning1.zig
echo [Done!]
