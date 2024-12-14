//Following: https://ziglang.org/learn/overview/
// Also referenced: https://zig.guide/

// +--------------------------------------------------------------+
// |                   unsafe_integer_overflow                    |
// +--------------------------------------------------------------+
test "unsafe_integer_overflow"
{
	@setRuntimeSafety(false);
	var x: u8 = 255;
	x += 1;
	// std.debug.print("\nu8 after overflow becomes: {d}\n", .{x});
	assert(x == 0 or x == 255);
}

// +--------------------------------------------------------------+
// |                       null_ptrFromInt                        |
// +--------------------------------------------------------------+
test "null_ptrFromInt"
{
	// const pointer: *i32 = @ptrFromInt(0); //Causes error: pointer type '*i32' does not allow address zero
	// _ = pointer;
	
	const optional_pointer: ?*i32 = @ptrFromInt(0);
	assert(optional_pointer == null);
}

// +--------------------------------------------------------------+
// |                    dealing_with_optionals                    |
// +--------------------------------------------------------------+
fn nullIfEven(value: i32) ?*u8
{
	if (@mod(value, 2) == 0) { return null; }
	else { return @ptrFromInt(1); }
}

test "dealing_with_optionals"
{
	if (nullIfEven(1)) |memoryPntr|
	{
		assert(memoryPntr == @as(*u8, @ptrFromInt(1)));
	}
	else { assert(false); }
	
	const anotherPntr = nullIfEven(3) orelse return;
	_ = anotherPntr;
	
	// print("\n", .{});
	const message = "hello this is dog";
	var iter = std.mem.tokenizeAny(u8, message, " ");
	var tokenIndex: i32 = 0;
	while (iter.next()) |token|
	{
		// print("Token[{d}]: \"{s}\"\n", .{tokenIndex, token});
		_ = token;
		tokenIndex += 1;
	}
}

// +--------------------------------------------------------------+
// |                    fixed_buffer_allocator                    |
// +--------------------------------------------------------------+
test "fixed_buffer_allocator"
{
	var testAllocatorBuffer: [128]u8 = undefined;
	var testAllocator = std.heap.FixedBufferAllocator.init(&testAllocatorBuffer);
	const allocator = testAllocator.allocator();
	
	{
		const allocatedInt = allocator.alloc(i32, 1) catch return;
		defer allocator.free(allocatedInt);
		
		allocatedInt[0] = 5;
		assert(allocatedInt[0] == 5);
		assert(testAllocatorBuffer[0] == 0x05 and testAllocatorBuffer[1] == 0x00 and testAllocatorBuffer[2] == 0x00 and testAllocatorBuffer[3] == 0x00);
		// print("\nBuffer: {any}\n", .{testAllocatorBuffer});
	}
	
	assert(testAllocatorBuffer[0] == 0xAA and testAllocatorBuffer[1] == 0xAA and testAllocatorBuffer[2] == 0xAA and testAllocatorBuffer[3] == 0xAA);
	// print("\nBuffer: {any}\n", .{testAllocatorBuffer});
}

// +--------------------------------------------------------------+
// |                errdefer_inside_struct_create                 |
// +--------------------------------------------------------------+
const MyType = struct
{
	name: []u8,
	
	fn create(allocator: std.mem.Allocator, id: i32) !*MyType
	{
		const result = try allocator.create(MyType);
		errdefer allocator.destroy(result);
		
		result.name = try std.fmt.allocPrint(allocator, "MyType(id={d})", .{id});
		errdefer allocator.free(result.name);
		
		if (id == 0) return error.ReservedDeviceId;
		
		return result;
	}
};

test "errdefer_inside_struct_create"
{
	var testAllocatorBuffer: [2048]u8 = undefined;
	var testAllocator = std.heap.FixedBufferAllocator.init(&testAllocatorBuffer);
	const allocator = testAllocator.allocator();
	
	var myType: *MyType = MyType.create(allocator, 14) catch |err|
	{
		print("\nMyType.create failed: {}\n", .{err});
		return;
	};
	_ = &myType;
}

// +--------------------------------------------------------------+
// |                 file_writing_and_catch_label                 |
// +--------------------------------------------------------------+
test "file_writing_and_catch_label"
{
	const fileOrOutput = std.fs.cwd().openFile("test.txt", .{ .mode = .read_write }) catch |err| label:
	{
		print("openFile Failed! {}...", .{err});
		const stderr = std.io.getStdErr();
		break :label stderr;
	};
	try fileOrOutput.writeAll("Writing to output...");
	
	const file2 = try std.fs.cwd().createFile("test2.txt", .{});
	defer file2.close();
	try file2.writeAll("Writing to test2.txt, only if we succeeded to create the file");
}

// +--------------------------------------------------------------+
// |                             main                             |
// +--------------------------------------------------------------+
pub fn main() void
{
	print("Hello World!\n", .{});
	
	while (true) { }
}

const std = @import("std");
const assert = std.debug.assert;
const print = std.debug.print;
const expect = std.testing.expect;
