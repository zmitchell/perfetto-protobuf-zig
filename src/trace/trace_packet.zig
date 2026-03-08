const std = @import("std");
const gremlin = @import("gremlin");
const track_event = @import("track_event.zig");
const track_descriptor = @import("track_descriptor.zig");

const TracePacketWire = struct {
    const TIMESTAMP_WIRE: gremlin.ProtoWireNumber = 8;
    const TIMESTAMP_CLOCK_ID_WIRE: gremlin.ProtoWireNumber = 58;
    const TRUSTED_PID_WIRE: gremlin.ProtoWireNumber = 79;
    const INTERNED_DATA_WIRE: gremlin.ProtoWireNumber = 12;
    const SEQUENCE_FLAGS_WIRE: gremlin.ProtoWireNumber = 13;
    const INCREMENTAL_STATE_CLEARED_WIRE: gremlin.ProtoWireNumber = 41;
    const TRACE_PACKET_DEFAULTS_WIRE: gremlin.ProtoWireNumber = 59;
    const PREVIOUS_PACKET_DROPPED_WIRE: gremlin.ProtoWireNumber = 42;
    const FIRST_PACKET_ON_SEQUENCE_WIRE: gremlin.ProtoWireNumber = 87;
    const MACHINE_ID_WIRE: gremlin.ProtoWireNumber = 98;
    const PROCESS_TREE_WIRE: gremlin.ProtoWireNumber = 2;
    const PROCESS_STATS_WIRE: gremlin.ProtoWireNumber = 9;
    const INODE_FILE_MAP_WIRE: gremlin.ProtoWireNumber = 4;
    const CHROME_EVENTS_WIRE: gremlin.ProtoWireNumber = 5;
    const CLOCK_SNAPSHOT_WIRE: gremlin.ProtoWireNumber = 6;
    const SYS_STATS_WIRE: gremlin.ProtoWireNumber = 7;
    const TRACK_EVENT_WIRE: gremlin.ProtoWireNumber = 11;
    const TRACE_UUID_WIRE: gremlin.ProtoWireNumber = 89;
    const TRACE_CONFIG_WIRE: gremlin.ProtoWireNumber = 33;
    const FTRACE_STATS_WIRE: gremlin.ProtoWireNumber = 34;
    const TRACE_STATS_WIRE: gremlin.ProtoWireNumber = 35;
    const PROFILE_PACKET_WIRE: gremlin.ProtoWireNumber = 37;
    const STREAMING_ALLOCATION_WIRE: gremlin.ProtoWireNumber = 74;
    const STREAMING_FREE_WIRE: gremlin.ProtoWireNumber = 75;
    const BATTERY_WIRE: gremlin.ProtoWireNumber = 38;
    const POWER_RAILS_WIRE: gremlin.ProtoWireNumber = 40;
    const ANDROID_LOG_WIRE: gremlin.ProtoWireNumber = 39;
    const SYSTEM_INFO_WIRE: gremlin.ProtoWireNumber = 45;
    const TRIGGER_WIRE: gremlin.ProtoWireNumber = 46;
    const CHROME_TRIGGER_WIRE: gremlin.ProtoWireNumber = 109;
    const PACKAGES_LIST_WIRE: gremlin.ProtoWireNumber = 47;
    const CHROME_BENCHMARK_METADATA_WIRE: gremlin.ProtoWireNumber = 48;
    const PERFETTO_METATRACE_WIRE: gremlin.ProtoWireNumber = 49;
    const CHROME_METADATA_WIRE: gremlin.ProtoWireNumber = 51;
    const GPU_COUNTER_EVENT_WIRE: gremlin.ProtoWireNumber = 52;
    const GPU_RENDER_STAGE_EVENT_WIRE: gremlin.ProtoWireNumber = 53;
    const STREAMING_PROFILE_PACKET_WIRE: gremlin.ProtoWireNumber = 54;
    const HEAP_GRAPH_WIRE: gremlin.ProtoWireNumber = 56;
    const GRAPHICS_FRAME_EVENT_WIRE: gremlin.ProtoWireNumber = 57;
    const VULKAN_MEMORY_EVENT_WIRE: gremlin.ProtoWireNumber = 62;
    const GPU_LOG_WIRE: gremlin.ProtoWireNumber = 63;
    const VULKAN_API_EVENT_WIRE: gremlin.ProtoWireNumber = 65;
    const PERF_SAMPLE_WIRE: gremlin.ProtoWireNumber = 66;
    const CPU_INFO_WIRE: gremlin.ProtoWireNumber = 67;
    const SMAPS_PACKET_WIRE: gremlin.ProtoWireNumber = 68;
    const SERVICE_EVENT_WIRE: gremlin.ProtoWireNumber = 69;
    const INITIAL_DISPLAY_STATE_WIRE: gremlin.ProtoWireNumber = 70;
    const GPU_MEM_TOTAL_EVENT_WIRE: gremlin.ProtoWireNumber = 71;
    const MEMORY_TRACKER_SNAPSHOT_WIRE: gremlin.ProtoWireNumber = 73;
    const FRAME_TIMELINE_EVENT_WIRE: gremlin.ProtoWireNumber = 76;
    const ANDROID_ENERGY_ESTIMATION_BREAKDOWN_WIRE: gremlin.ProtoWireNumber = 77;
    const UI_STATE_WIRE: gremlin.ProtoWireNumber = 78;
    const ANDROID_CAMERA_FRAME_EVENT_WIRE: gremlin.ProtoWireNumber = 80;
    const ANDROID_CAMERA_SESSION_STATS_WIRE: gremlin.ProtoWireNumber = 81;
    const TRANSLATION_TABLE_WIRE: gremlin.ProtoWireNumber = 82;
    const ANDROID_GAME_INTERVENTION_LIST_WIRE: gremlin.ProtoWireNumber = 83;
    const STATSD_ATOM_WIRE: gremlin.ProtoWireNumber = 84;
    const ANDROID_SYSTEM_PROPERTY_WIRE: gremlin.ProtoWireNumber = 86;
    const ENTITY_STATE_RESIDENCY_WIRE: gremlin.ProtoWireNumber = 91;
    const MODULE_SYMBOLS_WIRE: gremlin.ProtoWireNumber = 61;
    const DEOBFUSCATION_MAPPING_WIRE: gremlin.ProtoWireNumber = 64;
    const TRACK_DESCRIPTOR_WIRE: gremlin.ProtoWireNumber = 60;
    const PROCESS_DESCRIPTOR_WIRE: gremlin.ProtoWireNumber = 43;
    const THREAD_DESCRIPTOR_WIRE: gremlin.ProtoWireNumber = 44;
    const FTRACE_EVENTS_WIRE: gremlin.ProtoWireNumber = 1;
    const SYNCHRONIZATION_MARKER_WIRE: gremlin.ProtoWireNumber = 36;
    const COMPRESSED_PACKETS_WIRE: gremlin.ProtoWireNumber = 50;
    const EXTENSION_DESCRIPTOR_WIRE: gremlin.ProtoWireNumber = 72;
    const NETWORK_PACKET_WIRE: gremlin.ProtoWireNumber = 88;
    const NETWORK_PACKET_BUNDLE_WIRE: gremlin.ProtoWireNumber = 92;
    const TRACK_EVENT_RANGE_OF_INTEREST_WIRE: gremlin.ProtoWireNumber = 90;
    const SURFACEFLINGER_LAYERS_SNAPSHOT_WIRE: gremlin.ProtoWireNumber = 93;
    const SURFACEFLINGER_TRANSACTIONS_WIRE: gremlin.ProtoWireNumber = 94;
    const SHELL_TRANSITION_WIRE: gremlin.ProtoWireNumber = 96;
    const SHELL_HANDLER_MAPPINGS_WIRE: gremlin.ProtoWireNumber = 97;
    const PROTOLOG_MESSAGE_WIRE: gremlin.ProtoWireNumber = 104;
    const PROTOLOG_VIEWER_CONFIG_WIRE: gremlin.ProtoWireNumber = 105;
    const WINSCOPE_EXTENSIONS_WIRE: gremlin.ProtoWireNumber = 112;
    const ETW_EVENTS_WIRE: gremlin.ProtoWireNumber = 95;
    const V8_JS_CODE_WIRE: gremlin.ProtoWireNumber = 99;
    const V8_INTERNAL_CODE_WIRE: gremlin.ProtoWireNumber = 100;
    const V8_WASM_CODE_WIRE: gremlin.ProtoWireNumber = 101;
    const V8_REG_EXP_CODE_WIRE: gremlin.ProtoWireNumber = 102;
    const V8_CODE_MOVE_WIRE: gremlin.ProtoWireNumber = 103;
    const REMOTE_CLOCK_SYNC_WIRE: gremlin.ProtoWireNumber = 107;
    const PIXEL_MODEM_EVENTS_WIRE: gremlin.ProtoWireNumber = 110;
    const PIXEL_MODEM_TOKEN_DATABASE_WIRE: gremlin.ProtoWireNumber = 111;
    const CLONE_SNAPSHOT_TRIGGER_WIRE: gremlin.ProtoWireNumber = 113;
    const BLUETOOTH_TRACE_EVENT_WIRE: gremlin.ProtoWireNumber = 114;
    const KERNEL_WAKELOCK_DATA_WIRE: gremlin.ProtoWireNumber = 115;
    const APP_WAKELOCK_BUNDLE_WIRE: gremlin.ProtoWireNumber = 116;
    const GENERIC_KERNEL_TASK_STATE_EVENT_WIRE: gremlin.ProtoWireNumber = 117;
    const GENERIC_KERNEL_CPU_FREQ_EVENT_WIRE: gremlin.ProtoWireNumber = 118;
    const GENERIC_KERNEL_TASK_RENAME_EVENT_WIRE: gremlin.ProtoWireNumber = 120;
    const GENERIC_KERNEL_PROCESS_TREE_WIRE: gremlin.ProtoWireNumber = 122;
    const CPU_PER_UID_DATA_WIRE: gremlin.ProtoWireNumber = 119;
    const EVDEV_EVENT_WIRE: gremlin.ProtoWireNumber = 121;
    const FOR_TESTING_WIRE: gremlin.ProtoWireNumber = 900;
    const TRUSTED_UID_WIRE: gremlin.ProtoWireNumber = 3;
    const TRUSTED_PACKET_SEQUENCE_ID_WIRE: gremlin.ProtoWireNumber = 10;
};
pub const TracePacket = struct {
    // nested enums
    pub const SequenceFlags = enum(i32) {
        SEQ_UNSPECIFIED = 0,
        SEQ_INCREMENTAL_STATE_CLEARED = 1,
        SEQ_NEEDS_INCREMENTAL_STATE = 2,
    };
    // fields
    timestamp: u64 = 0,
    timestamp_clock_id: u32 = 0,
    trusted_pid: i32 = 0,
    sequence_flags: u32 = 0,
    incremental_state_cleared: bool = false,
    previous_packet_dropped: bool = false,
    first_packet_on_sequence: bool = false,
    machine_id: u32 = 0,
    track_event: ?track_event.TrackEvent = null,
    track_descriptor: ?track_descriptor.TrackDescriptor = null,
    trusted_uid: i32 = 0,
    trusted_packet_sequence_id: u32 = 0,
    pub fn calcProtobufSize(self: *const TracePacket) usize {
        var res: usize = 0;
        if (self.timestamp != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.TIMESTAMP_WIRE) + gremlin.sizes.sizeU64(self.timestamp);
        }
        if (self.timestamp_clock_id != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.TIMESTAMP_CLOCK_ID_WIRE) + gremlin.sizes.sizeU32(self.timestamp_clock_id);
        }
        if (self.trusted_pid != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.TRUSTED_PID_WIRE) + gremlin.sizes.sizeI32(self.trusted_pid);
        }
        if (self.sequence_flags != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.SEQUENCE_FLAGS_WIRE) + gremlin.sizes.sizeU32(self.sequence_flags);
        }
        if (self.incremental_state_cleared != false) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.INCREMENTAL_STATE_CLEARED_WIRE) + gremlin.sizes.sizeBool(self.incremental_state_cleared);
        }
        if (self.previous_packet_dropped != false) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.PREVIOUS_PACKET_DROPPED_WIRE) + gremlin.sizes.sizeBool(self.previous_packet_dropped);
        }
        if (self.first_packet_on_sequence != false) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.FIRST_PACKET_ON_SEQUENCE_WIRE) + gremlin.sizes.sizeBool(self.first_packet_on_sequence);
        }
        if (self.machine_id != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.MACHINE_ID_WIRE) + gremlin.sizes.sizeU32(self.machine_id);
        }
        if (self.track_event) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                res += gremlin.sizes.sizeWireNumber(TracePacketWire.TRACK_EVENT_WIRE) + gremlin.sizes.sizeUsize(size) + size;
            }
        }
        if (self.track_descriptor) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                res += gremlin.sizes.sizeWireNumber(TracePacketWire.TRACK_DESCRIPTOR_WIRE) + gremlin.sizes.sizeUsize(size) + size;
            }
        }
        if (self.trusted_uid != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.TRUSTED_UID_WIRE) + gremlin.sizes.sizeI32(self.trusted_uid);
        }
        if (self.trusted_packet_sequence_id != 0) {
            res += gremlin.sizes.sizeWireNumber(TracePacketWire.TRUSTED_PACKET_SEQUENCE_ID_WIRE) + gremlin.sizes.sizeU32(self.trusted_packet_sequence_id);
        }
        return res;
    }
    pub fn encode(self: *const TracePacket, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
        const size = self.calcProtobufSize();
        if (size == 0) {
            return &[_]u8{};
        }
        const buf = try allocator.alloc(u8, self.calcProtobufSize());
        var writer = gremlin.Writer.init(buf);
        self.encodeTo(&writer);
        return buf;
    }
    pub fn encodeTo(self: *const TracePacket, target: *gremlin.Writer) void {
        if (self.timestamp != 0) {
            target.appendUint64(TracePacketWire.TIMESTAMP_WIRE, self.timestamp);
        }
        if (self.timestamp_clock_id != 0) {
            target.appendUint32(TracePacketWire.TIMESTAMP_CLOCK_ID_WIRE, self.timestamp_clock_id);
        }
        if (self.trusted_pid != 0) {
            target.appendInt32(TracePacketWire.TRUSTED_PID_WIRE, self.trusted_pid);
        }
        if (self.sequence_flags != 0) {
            target.appendUint32(TracePacketWire.SEQUENCE_FLAGS_WIRE, self.sequence_flags);
        }
        if (self.incremental_state_cleared != false) {
            target.appendBool(TracePacketWire.INCREMENTAL_STATE_CLEARED_WIRE, self.incremental_state_cleared);
        }
        if (self.previous_packet_dropped != false) {
            target.appendBool(TracePacketWire.PREVIOUS_PACKET_DROPPED_WIRE, self.previous_packet_dropped);
        }
        if (self.first_packet_on_sequence != false) {
            target.appendBool(TracePacketWire.FIRST_PACKET_ON_SEQUENCE_WIRE, self.first_packet_on_sequence);
        }
        if (self.machine_id != 0) {
            target.appendUint32(TracePacketWire.MACHINE_ID_WIRE, self.machine_id);
        }
        if (self.track_event) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                target.appendBytesTag(TracePacketWire.TRACK_EVENT_WIRE, size);
                v.encodeTo(target);
            }
        }
        if (self.track_descriptor) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                target.appendBytesTag(TracePacketWire.TRACK_DESCRIPTOR_WIRE, size);
                v.encodeTo(target);
            }
        }
        if (self.trusted_uid != 0) {
            target.appendInt32(TracePacketWire.TRUSTED_UID_WIRE, self.trusted_uid);
        }
        if (self.trusted_packet_sequence_id != 0) {
            target.appendUint32(TracePacketWire.TRUSTED_PACKET_SEQUENCE_ID_WIRE, self.trusted_packet_sequence_id);
        }
    }
};
