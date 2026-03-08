const std = @import("std");
const gremlin = @import("gremlin");
// structs
const TrackDescriptorWire = struct {
    const UUID_WIRE: gremlin.ProtoWireNumber = 1;
    const PARENT_UUID_WIRE: gremlin.ProtoWireNumber = 5;
    const DESCRIPTION_WIRE: gremlin.ProtoWireNumber = 14;
    const PROCESS_WIRE: gremlin.ProtoWireNumber = 3;
    const CHROME_PROCESS_WIRE: gremlin.ProtoWireNumber = 6;
    const THREAD_WIRE: gremlin.ProtoWireNumber = 4;
    const CHROME_THREAD_WIRE: gremlin.ProtoWireNumber = 7;
    const COUNTER_WIRE: gremlin.ProtoWireNumber = 8;
    const DISALLOW_MERGING_WITH_SYSTEM_TRACKS_WIRE: gremlin.ProtoWireNumber = 9;
    const CHILD_ORDERING_WIRE: gremlin.ProtoWireNumber = 11;
    const SIBLING_ORDER_RANK_WIRE: gremlin.ProtoWireNumber = 12;
    const SIBLING_MERGE_BEHAVIOR_WIRE: gremlin.ProtoWireNumber = 15;
    const NAME_WIRE: gremlin.ProtoWireNumber = 2;
    const STATIC_NAME_WIRE: gremlin.ProtoWireNumber = 10;
    const ATRACE_NAME_WIRE: gremlin.ProtoWireNumber = 13;
    const SIBLING_MERGE_KEY_WIRE: gremlin.ProtoWireNumber = 16;
    const SIBLING_MERGE_KEY_INT_WIRE: gremlin.ProtoWireNumber = 17;
};
pub const TrackDescriptor = struct {
    // nested enums
    pub const ChildTracksOrdering = enum(i32) {
        UNKNOWN = 0,
        LEXICOGRAPHIC = 1,
        CHRONOLOGICAL = 2,
        EXPLICIT = 3,
    };
    pub const SiblingMergeBehavior = enum(i32) {
        SIBLING_MERGE_BEHAVIOR_UNSPECIFIED = 0,
        SIBLING_MERGE_BEHAVIOR_BY_TRACK_NAME = 1,
        SIBLING_MERGE_BEHAVIOR_NONE = 2,
        SIBLING_MERGE_BEHAVIOR_BY_SIBLING_MERGE_KEY = 3,
    };
    // fields
    // KEEP:
    // - uuid
    // - parent_uuid
    // - sibling_...
    // - name
    uuid: u64 = 0,
    parent_uuid: u64 = 0,
    description: ?[]const u8 = null,
    disallow_merging_with_system_tracks: bool = false,
    child_ordering: TrackDescriptor.ChildTracksOrdering = @enumFromInt(0),
    sibling_order_rank: i32 = 0,
    sibling_merge_behavior: TrackDescriptor.SiblingMergeBehavior = @enumFromInt(0),
    name: ?[]const u8 = null,
    static_name: ?[]const u8 = null,
    atrace_name: ?[]const u8 = null,
    sibling_merge_key: ?[]const u8 = null,
    sibling_merge_key_int: u64 = 0,
    pub fn calcProtobufSize(self: *const TrackDescriptor) usize {
        var res: usize = 0;
        if (self.uuid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.UUID_WIRE) + gremlin.sizes.sizeU64(self.uuid);
        }
        if (self.parent_uuid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.PARENT_UUID_WIRE) + gremlin.sizes.sizeU64(self.parent_uuid);
        }
        if (self.description) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.DESCRIPTION_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.disallow_merging_with_system_tracks != false) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.DISALLOW_MERGING_WITH_SYSTEM_TRACKS_WIRE) + gremlin.sizes.sizeBool(self.disallow_merging_with_system_tracks);
        }
        if (@intFromEnum(self.child_ordering) != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.CHILD_ORDERING_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.child_ordering));
        }
        if (self.sibling_order_rank != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.SIBLING_ORDER_RANK_WIRE) + gremlin.sizes.sizeI32(self.sibling_order_rank);
        }
        if (@intFromEnum(self.sibling_merge_behavior) != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.SIBLING_MERGE_BEHAVIOR_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.sibling_merge_behavior));
        }
        if (self.name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.static_name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.STATIC_NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.atrace_name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.ATRACE_NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.sibling_merge_key) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.SIBLING_MERGE_KEY_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.sibling_merge_key_int != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackDescriptorWire.SIBLING_MERGE_KEY_INT_WIRE) + gremlin.sizes.sizeU64(self.sibling_merge_key_int);
        }
        return res;
    }
    pub fn encode(self: *const TrackDescriptor, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
        const size = self.calcProtobufSize();
        if (size == 0) {
            return &[_]u8{};
        }
        const buf = try allocator.alloc(u8, self.calcProtobufSize());
        var writer = gremlin.Writer.init(buf);
        self.encodeTo(&writer);
        return buf;
    }
    pub fn encodeTo(self: *const TrackDescriptor, target: *gremlin.Writer) void {
        if (self.uuid != 0) {
            target.appendUint64(TrackDescriptorWire.UUID_WIRE, self.uuid);
        }
        if (self.parent_uuid != 0) {
            target.appendUint64(TrackDescriptorWire.PARENT_UUID_WIRE, self.parent_uuid);
        }
        if (self.description) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackDescriptorWire.DESCRIPTION_WIRE, v);
            }
        }
        if (self.disallow_merging_with_system_tracks != false) {
            target.appendBool(TrackDescriptorWire.DISALLOW_MERGING_WITH_SYSTEM_TRACKS_WIRE, self.disallow_merging_with_system_tracks);
        }
        if (@intFromEnum(self.child_ordering) != 0) {
            target.appendInt32(TrackDescriptorWire.CHILD_ORDERING_WIRE, @intFromEnum(self.child_ordering));
        }
        if (self.sibling_order_rank != 0) {
            target.appendInt32(TrackDescriptorWire.SIBLING_ORDER_RANK_WIRE, self.sibling_order_rank);
        }
        if (@intFromEnum(self.sibling_merge_behavior) != 0) {
            target.appendInt32(TrackDescriptorWire.SIBLING_MERGE_BEHAVIOR_WIRE, @intFromEnum(self.sibling_merge_behavior));
        }
        if (self.name) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackDescriptorWire.NAME_WIRE, v);
            }
        }
        if (self.static_name) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackDescriptorWire.STATIC_NAME_WIRE, v);
            }
        }
        if (self.atrace_name) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackDescriptorWire.ATRACE_NAME_WIRE, v);
            }
        }
        if (self.sibling_merge_key) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackDescriptorWire.SIBLING_MERGE_KEY_WIRE, v);
            }
        }
        if (self.sibling_merge_key_int != 0) {
            target.appendUint64(TrackDescriptorWire.SIBLING_MERGE_KEY_INT_WIRE, self.sibling_merge_key_int);
        }
    }
};
