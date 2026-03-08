const std = @import("std");
const gremlin = @import("gremlin");
const trace_packet = @import("trace_packet.zig");

const TraceWire = struct {
    const PACKET_WIRE: gremlin.ProtoWireNumber = 1;
};
pub const Trace = struct {
    // fields
    packet: ?[]const ?trace_packet.TracePacket = null,
    pub fn calcProtobufSize(self: *const Trace) usize {
        var res: usize = 0;
        if (self.packet) |arr| {
            for (arr) |maybe_v| {
                res += gremlin.sizes.sizeWireNumber(TraceWire.PACKET_WIRE);
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    res += gremlin.sizes.sizeUsize(size) + size;
                } else {
                    res += gremlin.sizes.sizeUsize(0);
                }
            }
        }
        return res;
    }
    pub fn encode(self: *const Trace, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
        const size = self.calcProtobufSize();
        if (size == 0) {
            return &[_]u8{};
        }
        const buf = try allocator.alloc(u8, self.calcProtobufSize());
        var writer = gremlin.Writer.init(buf);
        self.encodeTo(&writer);
        return buf;
    }
    pub fn encodeTo(self: *const Trace, target: *gremlin.Writer) void {
        if (self.packet) |arr| {
            for (arr) |maybe_v| {
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    target.appendBytesTag(TraceWire.PACKET_WIRE, size);
                    v.encodeTo(target);
                } else {
                    target.appendBytesTag(TraceWire.PACKET_WIRE, 0);
                }
            }
        }
    }
};
