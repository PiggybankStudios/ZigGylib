const std = @import("std");
const print = std.debug.print;
const assert = std.debug.assert;
const os = std.os;
const win32 = std.os.windows;

// extern "user32" fn MessageBoxA(?win32.HWND, [*:0]const u8, [*:0]const u8, u32) callconv(win32.WINAPI) i32;
extern "Kernel32" fn OutputDebugStringA([*:0]const u8) callconv(win32.WINAPI) void;

// var mainHeap: ?std.mem.Allocator = null;
// var gpa = std.heap.GeneralPurposeAllocator(.{}){};

fn PrintLine_I(comptime format: [*:0]const u8, args: anytype) void
{
	std.debug.print(format[0..std.mem.len(format)], args);
	var printBuffer: [1024]u8 = undefined;
	const result = std.fmt.bufPrint(&printBuffer, format[0..std.mem.len(format)], args) catch null;
	_ = result;
	
	OutputDebugStringA(printBuffer);
}

pub fn main() void
{
	var a: i32 = 24;
	_ = &a;
	PrintLine_I("Hello World!\n", .{});
	PrintLine_I("{}", .{@TypeOf(a)});
	while (true) { }
	
}