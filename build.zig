


//TODO: Figure out how to run tests, like running 'zig test file.zig'
// https://github.com/ZystemOS/pluto/blob/develop/build.zig#L122
// https://www.reddit.com/r/Zig/comments/y65qa6/how_to_test_every_file_in_a_simple_zig_project/

pub fn build(b: *std.Build) void
{
	b.release_mode = .safe;
	b.dest_dir = "build";
	b.exe_dir = "build";
	b.lib_dir = "build";
	// const lib = b.addSharedLibrary("mathtest", "mathtest.zig", b.version(1, 0, 0));
	const exe = b.addExecutable(.{
		.name = "learning1",
		.root_source_file = b.path("learning1.zig"),
		.target = b.host,
		.optimize = .Debug, //.Debug, .ReleaseSafe, .ReleaseFast, .ReleaseSmall
	});
	// const exe_tests = b.addTest(.{
	// 	.name = "learning1_test",
	// 	.root_source_file = b.path("learning1.zig"),
	// 	.target = b.host,
	// 	.optimize = .Debug, //.Debug, .ReleaseSafe, .ReleaseFast, .ReleaseSmall
	// });
	
	// exe.addSourceFile("learning1.zig", &[_][]const u8{"-std=c99"});
	// exe.linkLibrary(lib);
	// exe.linkSystemLibrary("c");
	
	// b.default_step.dependOn(&exe.step);
	
	// const run_cmd = exe.run();
	// const test_step = b.step("test", "Test the program");
	// test_step.dependOn(&run_cmd.step);
	
	b.installArtifact(exe);
	// b.installArtifact(t);
	// const test_step = b.step("test", "Run tests");
	// test_step.dependOn(&exe_tests.step);
	// b.installArtifact(test_step);
	
	//https://ziglang.org/learn/build-system/
	//https://ziglang.org/documentation/master/std/#std.Build
	
	// +==================================+
	// | Functions Available in std.Build |
	// +==================================+
	// const assembly: *Step.Compile = b.addAssembly(options: AssemblyOptions); //TODO: Check options contents
	// const checkFile: *Step.CheckFile = b.addCheckFile(file_source: LazyPath, options: Step.CheckFile.Options, ); //TODO: Check options contents
	// const configHeader: *Step.ConfigHeader = b.addConfigHeader(options: Step.ConfigHeader.Options, values: anytype, ); //TODO: Check options contents
	// const exe: *Step.Compile = b.addExecutable(options: ExecutableOptions); //TODO: Check options contents
	// const fail: *Step.Fail = b.addFail(error_msg: []const u8);
	// const format: *Step.Fmt = b.addFmt(options: Step.Fmt.Options);
	// const lib: *Step.Compile = b.addSharedLibrary(options: SharedLibraryOptions); //TODO: Check options contents
	// const test: *Step.Compile = b.addTest(options: TestOptions); //TODO: Check options contents
	// b.installArtifact(exe);
	
	// +===============================+
	// | Possible Options in std.Build |
	// +===============================+
	// b.graph: *Graph; //Shared state among all Build instances
	// b.graph.host: ResolvedTarget; //Information about the native target. Computed before build() is invoked
	// b.install_tls = ?; b.uninstall_tls = ?;
	// b.allocator: Allocator
	// b.user_input_options: UserInputOptionsMap; b.available_options_map: AvailableOptionsMap; b.available_options_list: ArrayList(AvailableOption);
	// b.verbose = true; //verbose_link, verbose_cc, verbose_air, verbose_llvm_ir, verbose_llvm_bc, verbose_cimport, verbose_llvm_cpu_features
	// b.reference_trace: ?u32;
	// if (b.invalid_user_input) { ... }
	// b.default_step: *Step
	// 		Call b.default_step.dependOn(&exe.step);
	// b.top_level_steps: std.StringArrayHashMapUnmanaged(*TopLevelStep)
	// b.install_prefix = "string"; b.install_path = "string";
	// b.dest_dir = "string"; b.exe_dir = "string"; b.lib_dir = "string"; b.h_dir = "string";
	// b.sys_root: ?[]const u8;
	// b.search_prefixes: std.ArrayListUnmanaged([]const u8);
	// b.libc_file: ?[]const u8;
	// b.build_root: Cache.Directory; b.cache_root: Cache.Directory; //TODO: Can't change these?? I guess .zig-cache will always be created?
	// b.pkg_config_pkg_list;
	// b.args: ?[]const []const u8;
	// b.debug_log_scopes: []const []const u8;
	// if (b.debug_compile_errors) {...}
	// b.debug_stack_frames_count = 0; //disables stack collection
	// b.enable_darling = true; //experimental. Use system Darling installation to run cross compiled macOS artifacts
	// b.enable_qemu = true; //Use system QEMU installation to run cross compiled foreign architecture build artifacts
	// b.enable_rosetta = true; //Darwin. Use Rosetta to run x86_64 macOS build artifacts on arm64 macOS
	// b.enable_wasmtime = true; //Use system Wasmtime installation to run cross compiled wasm/wasi build artifacts
	// b.enable_wine = true; //Use system Wine installation to run cross compiled Windows build artifacts
	// b.glibc_runtimes_dir = "string"; //After following the steps in https://github.com/ziglang/zig/wiki/Updating-libc#glibc, this will be the directory $glibc-build-dir/install/glibcs Given the example of the aarch64 target, this is the directory that contains the path aarch64-linux-gnu/lib/ld-linux-aarch64.so.1.
	// b.dep_prefix = "string";
	// b.modules: std.StringArrayHashMap(*Module);
	// b.named_writefiles: std.StringArrayHashMap(*Step.WriteFile);
	// b.named_lazy_paths: std.StringArrayHashMap(LazyPath);
	// b.pkg_hash: []const u8; //"" means we're the root package
	// b.available_deps: AvailableDeps; //A mapping from dependency names to package hashes
	// b.release_mode = .off; //.any, .fast, .safe, .small
}

const std = @import("std");
