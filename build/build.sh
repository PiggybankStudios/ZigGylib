
echo [Testing...]
# zig test -femit-docs ../main.zig
# zig test ../main.zig
zig test ../learning1.zig
echo [Building...]
# zig build-exe ../main.zig
# zig build-exe ../learning1.zig
# TODO: Still now sure how to get this compiling fully. Need to figure out how to link with libc
# zig build-exe ../sine_wave.zig -L"D:/gamedev/lib" -llibc
echo [Done!]