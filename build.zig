const std = @import("std");
const ProtoGenStep = @import("gremlin").ProtoGenStep;
const build_helpers = @import("zig_build_helpers");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const perfetto_src = b.dependency("perfetto_src", .{ .target = target, .optimize = .optimize });

    const gremlin_dep = b.dependency("gremlin", .{
        .target = target,
        .optimize = optimize,
    });
    const gremlin_mod = gremlin_dep.module("gremlin");

    const proto_gen_step = ProtoGenStep.create(b, .{
        .name = "protobuf",
        .proto_sources = perfetto_src.path(""),
        .target = b.path("src/gen"),
        .ignore_masks = &.{"*/chromium/optimization_guide/*"},
    });
    const gen_step = b.step("gen", "Generate the Zig code for the protobufs");
    gen_step.dependOn(&proto_gen_step.step);

    const mod = b.addModule("perfetto_protobuf_zig", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });
    mod.addImport("gremlin", gremlin_mod);

    build_helpers.addCheckStep(b, "perfetto-protobuf-zig", "Check without installing output files", mod);
    build_helpers.addTestStep(b, target, optimize, &.{mod}, &.{});
}
