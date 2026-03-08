const std = @import("std");
const trace = @import("trace.zig");

pub fn main() !void {
    var impl = std.heap.GeneralPurposeAllocator(.{}).init;
    const gpa = impl.allocator();
    defer _ = impl.deinit();

    const dummy_trace = trace.Trace{ .packet = null };
    _ = try dummy_trace.encode(gpa);
}
