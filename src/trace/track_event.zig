const std = @import("std");
const gremlin = @import("gremlin");
const debug_annotation = @import("debug_annotation.zig");
// structs
const TrackEventWire = struct {
    const CATEGORY_IIDS_WIRE: gremlin.ProtoWireNumber = 3;
    const CATEGORIES_WIRE: gremlin.ProtoWireNumber = 22;
    const TYPE_WIRE: gremlin.ProtoWireNumber = 9;
    const TRACK_UUID_WIRE: gremlin.ProtoWireNumber = 11;
    const EXTRA_COUNTER_TRACK_UUIDS_WIRE: gremlin.ProtoWireNumber = 31;
    const EXTRA_COUNTER_VALUES_WIRE: gremlin.ProtoWireNumber = 12;
    const EXTRA_DOUBLE_COUNTER_TRACK_UUIDS_WIRE: gremlin.ProtoWireNumber = 45;
    const EXTRA_DOUBLE_COUNTER_VALUES_WIRE: gremlin.ProtoWireNumber = 46;
    const FLOW_IDS_OLD_WIRE: gremlin.ProtoWireNumber = 36;
    const FLOW_IDS_WIRE: gremlin.ProtoWireNumber = 47;
    const TERMINATING_FLOW_IDS_OLD_WIRE: gremlin.ProtoWireNumber = 42;
    const TERMINATING_FLOW_IDS_WIRE: gremlin.ProtoWireNumber = 48;
    const DEBUG_ANNOTATIONS_WIRE: gremlin.ProtoWireNumber = 4;
    const TASK_EXECUTION_WIRE: gremlin.ProtoWireNumber = 5;
    const LOG_MESSAGE_WIRE: gremlin.ProtoWireNumber = 21;
    const CC_SCHEDULER_STATE_WIRE: gremlin.ProtoWireNumber = 24;
    const CHROME_USER_EVENT_WIRE: gremlin.ProtoWireNumber = 25;
    const CHROME_KEYED_SERVICE_WIRE: gremlin.ProtoWireNumber = 26;
    const CHROME_LEGACY_IPC_WIRE: gremlin.ProtoWireNumber = 27;
    const CHROME_HISTOGRAM_SAMPLE_WIRE: gremlin.ProtoWireNumber = 28;
    const CHROME_LATENCY_INFO_WIRE: gremlin.ProtoWireNumber = 29;
    const CHROME_FRAME_REPORTER_WIRE: gremlin.ProtoWireNumber = 32;
    const CHROME_APPLICATION_STATE_INFO_WIRE: gremlin.ProtoWireNumber = 39;
    const CHROME_RENDERER_SCHEDULER_STATE_WIRE: gremlin.ProtoWireNumber = 40;
    const CHROME_WINDOW_HANDLE_EVENT_INFO_WIRE: gremlin.ProtoWireNumber = 41;
    const CHROME_CONTENT_SETTINGS_EVENT_INFO_WIRE: gremlin.ProtoWireNumber = 43;
    const CHROME_ACTIVE_PROCESSES_WIRE: gremlin.ProtoWireNumber = 49;
    const SCREENSHOT_WIRE: gremlin.ProtoWireNumber = 50;
    const CHROME_MESSAGE_PUMP_WIRE: gremlin.ProtoWireNumber = 35;
    const CHROME_MOJO_EVENT_INFO_WIRE: gremlin.ProtoWireNumber = 38;
    const LEGACY_EVENT_WIRE: gremlin.ProtoWireNumber = 6;
    const NAME_IID_WIRE: gremlin.ProtoWireNumber = 10;
    const NAME_WIRE: gremlin.ProtoWireNumber = 23;
    const COUNTER_VALUE_WIRE: gremlin.ProtoWireNumber = 30;
    const DOUBLE_COUNTER_VALUE_WIRE: gremlin.ProtoWireNumber = 44;
    const CORRELATION_ID_WIRE: gremlin.ProtoWireNumber = 52;
    const CORRELATION_ID_STR_WIRE: gremlin.ProtoWireNumber = 53;
    const CORRELATION_ID_STR_IID_WIRE: gremlin.ProtoWireNumber = 54;
    const CALLSTACK_WIRE: gremlin.ProtoWireNumber = 55;
    const CALLSTACK_IID_WIRE: gremlin.ProtoWireNumber = 56;
    const SOURCE_LOCATION_WIRE: gremlin.ProtoWireNumber = 33;
    const SOURCE_LOCATION_IID_WIRE: gremlin.ProtoWireNumber = 34;
    const TIMESTAMP_DELTA_US_WIRE: gremlin.ProtoWireNumber = 1;
    const TIMESTAMP_ABSOLUTE_US_WIRE: gremlin.ProtoWireNumber = 16;
    const THREAD_TIME_DELTA_US_WIRE: gremlin.ProtoWireNumber = 2;
    const THREAD_TIME_ABSOLUTE_US_WIRE: gremlin.ProtoWireNumber = 17;
    const THREAD_INSTRUCTION_COUNT_DELTA_WIRE: gremlin.ProtoWireNumber = 8;
    const THREAD_INSTRUCTION_COUNT_ABSOLUTE_WIRE: gremlin.ProtoWireNumber = 20;
};
pub const TrackEvent = struct {
    // nested enums
    pub const Type = enum(i32) {
        TYPE_UNSPECIFIED = 0,
        TYPE_SLICE_BEGIN = 1,
        TYPE_SLICE_END = 2,
        TYPE_INSTANT = 3,
        TYPE_COUNTER = 4,
    };
    // nested structs
    const CallstackWire = struct {
        const FRAMES_WIRE: gremlin.ProtoWireNumber = 1;
    };
    pub const Callstack = struct {
        // nested structs
        const FrameWire = struct {
            const FUNCTION_NAME_WIRE: gremlin.ProtoWireNumber = 1;
            const SOURCE_FILE_WIRE: gremlin.ProtoWireNumber = 2;
            const LINE_NUMBER_WIRE: gremlin.ProtoWireNumber = 3;
        };
        pub const Frame = struct {
            // fields
            function_name: ?[]const u8 = null,
            source_file: ?[]const u8 = null,
            line_number: u32 = 0,
            pub fn calcProtobufSize(self: *const TrackEvent.Callstack.Frame) usize {
                var res: usize = 0;
                if (self.function_name) |v| {
                    if (v.len > 0) {
                        res += gremlin.sizes.sizeWireNumber(TrackEvent.Callstack.FrameWire.FUNCTION_NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
                    }
                }
                if (self.source_file) |v| {
                    if (v.len > 0) {
                        res += gremlin.sizes.sizeWireNumber(TrackEvent.Callstack.FrameWire.SOURCE_FILE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
                    }
                }
                if (self.line_number != 0) {
                    res += gremlin.sizes.sizeWireNumber(TrackEvent.Callstack.FrameWire.LINE_NUMBER_WIRE) + gremlin.sizes.sizeU32(self.line_number);
                }
                return res;
            }
            pub fn encode(self: *const TrackEvent.Callstack.Frame, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
                const size = self.calcProtobufSize();
                if (size == 0) {
                    return &[_]u8{};
                }
                const buf = try allocator.alloc(u8, self.calcProtobufSize());
                var writer = gremlin.Writer.init(buf);
                self.encodeTo(&writer);
                return buf;
            }
            pub fn encodeTo(self: *const TrackEvent.Callstack.Frame, target: *gremlin.Writer) void {
                if (self.function_name) |v| {
                    if (v.len > 0) {
                        target.appendBytes(TrackEvent.Callstack.FrameWire.FUNCTION_NAME_WIRE, v);
                    }
                }
                if (self.source_file) |v| {
                    if (v.len > 0) {
                        target.appendBytes(TrackEvent.Callstack.FrameWire.SOURCE_FILE_WIRE, v);
                    }
                }
                if (self.line_number != 0) {
                    target.appendUint32(TrackEvent.Callstack.FrameWire.LINE_NUMBER_WIRE, self.line_number);
                }
            }
        };
        pub const FrameReader = struct {
            buf: gremlin.Reader,
            _function_name: ?[]const u8 = null,
            _source_file: ?[]const u8 = null,
            _line_number: u32 = 0,
            pub fn init(src: []const u8) gremlin.Error!TrackEvent.Callstack.FrameReader {
                const buf = gremlin.Reader.init(src);
                var res = TrackEvent.Callstack.FrameReader{ .buf = buf };
                if (buf.buf.len == 0) {
                    return res;
                }
                var offset: usize = 0;
                while (buf.hasNext(offset, 0)) {
                    const tag = try buf.readTagAt(offset);
                    offset += tag.size;
                    switch (tag.number) {
                        TrackEvent.Callstack.FrameWire.FUNCTION_NAME_WIRE => {
                            const result = try buf.readBytes(offset);
                            offset += result.size;
                            res._function_name = result.value;
                        },
                        TrackEvent.Callstack.FrameWire.SOURCE_FILE_WIRE => {
                            const result = try buf.readBytes(offset);
                            offset += result.size;
                            res._source_file = result.value;
                        },
                        TrackEvent.Callstack.FrameWire.LINE_NUMBER_WIRE => {
                            const result = try buf.readUInt32(offset);
                            offset += result.size;
                            res._line_number = result.value;
                        },
                        else => {
                            offset = try buf.skipData(offset, tag.wire);
                        },
                    }
                }
                return res;
            }
            pub fn sourceBytes(self: *const @This()) []const u8 {
                return self.buf.buf;
            }
            pub inline fn getFunctionName(self: *const TrackEvent.Callstack.FrameReader) []const u8 {
                return self._function_name orelse &[_]u8{};
            }
            pub inline fn getSourceFile(self: *const TrackEvent.Callstack.FrameReader) []const u8 {
                return self._source_file orelse &[_]u8{};
            }
            pub inline fn getLineNumber(self: *const TrackEvent.Callstack.FrameReader) u32 {
                return self._line_number;
            }
        };
        // fields
        frames: ?[]const ?TrackEvent.Callstack.Frame = null,
        pub fn calcProtobufSize(self: *const TrackEvent.Callstack) usize {
            var res: usize = 0;
            if (self.frames) |arr| {
                for (arr) |maybe_v| {
                    res += gremlin.sizes.sizeWireNumber(TrackEvent.CallstackWire.FRAMES_WIRE);
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
        pub fn encode(self: *const TrackEvent.Callstack, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
            const size = self.calcProtobufSize();
            if (size == 0) {
                return &[_]u8{};
            }
            const buf = try allocator.alloc(u8, self.calcProtobufSize());
            var writer = gremlin.Writer.init(buf);
            self.encodeTo(&writer);
            return buf;
        }
        pub fn encodeTo(self: *const TrackEvent.Callstack, target: *gremlin.Writer) void {
            if (self.frames) |arr| {
                for (arr) |maybe_v| {
                    if (maybe_v) |v| {
                        const size = v.calcProtobufSize();
                        target.appendBytesTag(TrackEvent.CallstackWire.FRAMES_WIRE, size);
                        v.encodeTo(target);
                    } else {
                        target.appendBytesTag(TrackEvent.CallstackWire.FRAMES_WIRE, 0);
                    }
                }
            }
        }
    };
    pub const CallstackReader = struct {
        buf: gremlin.Reader,
        _frames_offset: ?usize = null,
        _frames_last_offset: ?usize = null,
        _frames_cnt: usize = 0,
        pub fn init(src: []const u8) gremlin.Error!TrackEvent.CallstackReader {
            const buf = gremlin.Reader.init(src);
            var res = TrackEvent.CallstackReader{ .buf = buf };
            if (buf.buf.len == 0) {
                return res;
            }
            var offset: usize = 0;
            while (buf.hasNext(offset, 0)) {
                const tag = try buf.readTagAt(offset);
                offset += tag.size;
                switch (tag.number) {
                    TrackEvent.CallstackWire.FRAMES_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        if (res._frames_offset == null) {
                            res._frames_offset = offset - result.size;
                        }
                        res._frames_last_offset = offset;
                        res._frames_cnt += 1;
                    },
                    else => {
                        offset = try buf.skipData(offset, tag.wire);
                    },
                }
            }
            return res;
        }
        pub fn sourceBytes(self: *const @This()) []const u8 {
            return self.buf.buf;
        }
        pub fn framesCount(self: *const TrackEvent.CallstackReader) usize {
            return self._frames_cnt;
        }
        pub fn framesNext(self: *TrackEvent.CallstackReader) ?TrackEvent.Callstack.FrameReader {
            if (self._frames_offset == null) return null;
            const current_offset = self._frames_offset.?;
            const result = self.buf.readBytes(current_offset) catch return null;
            const msg = TrackEvent.Callstack.FrameReader.init(result.value) catch return null;
            if (self._frames_last_offset != null and current_offset >= self._frames_last_offset.?) {
                self._frames_offset = null;
                return msg;
            }
            if (self._frames_last_offset == null) unreachable;
            var next_offset = current_offset + result.size;
            const max_offset = self._frames_last_offset.?;
            while (next_offset <= max_offset and self.buf.hasNext(next_offset, 0)) {
                const tag = self.buf.readTagAt(next_offset) catch break;
                next_offset += tag.size;
                if (tag.number == TrackEvent.CallstackWire.FRAMES_WIRE) {
                    self._frames_offset = next_offset;
                    return msg;
                } else {
                    next_offset = self.buf.skipData(next_offset, tag.wire) catch break;
                }
            }
            self._frames_offset = null;
            return msg;
        }
    };
    const LegacyEventWire = struct {
        const NAME_IID_WIRE: gremlin.ProtoWireNumber = 1;
        const PHASE_WIRE: gremlin.ProtoWireNumber = 2;
        const DURATION_US_WIRE: gremlin.ProtoWireNumber = 3;
        const THREAD_DURATION_US_WIRE: gremlin.ProtoWireNumber = 4;
        const THREAD_INSTRUCTION_DELTA_WIRE: gremlin.ProtoWireNumber = 15;
        const ID_SCOPE_WIRE: gremlin.ProtoWireNumber = 7;
        const USE_ASYNC_TTS_WIRE: gremlin.ProtoWireNumber = 9;
        const BIND_ID_WIRE: gremlin.ProtoWireNumber = 8;
        const BIND_TO_ENCLOSING_WIRE: gremlin.ProtoWireNumber = 12;
        const FLOW_DIRECTION_WIRE: gremlin.ProtoWireNumber = 13;
        const INSTANT_EVENT_SCOPE_WIRE: gremlin.ProtoWireNumber = 14;
        const PID_OVERRIDE_WIRE: gremlin.ProtoWireNumber = 18;
        const TID_OVERRIDE_WIRE: gremlin.ProtoWireNumber = 19;
        const UNSCOPED_ID_WIRE: gremlin.ProtoWireNumber = 6;
        const LOCAL_ID_WIRE: gremlin.ProtoWireNumber = 10;
        const GLOBAL_ID_WIRE: gremlin.ProtoWireNumber = 11;
    };
    pub const LegacyEvent = struct {
        // nested enums
        pub const FlowDirection = enum(i32) {
            FLOW_UNSPECIFIED = 0,
            FLOW_IN = 1,
            FLOW_OUT = 2,
            FLOW_INOUT = 3,
        };
        pub const InstantEventScope = enum(i32) {
            SCOPE_UNSPECIFIED = 0,
            SCOPE_GLOBAL = 1,
            SCOPE_PROCESS = 2,
            SCOPE_THREAD = 3,
        };
        // fields
        name_iid: u64 = 0,
        phase: i32 = 0,
        duration_us: i64 = 0,
        thread_duration_us: i64 = 0,
        thread_instruction_delta: i64 = 0,
        id_scope: ?[]const u8 = null,
        use_async_tts: bool = false,
        bind_id: u64 = 0,
        bind_to_enclosing: bool = false,
        flow_direction: TrackEvent.LegacyEvent.FlowDirection = @enumFromInt(0),
        instant_event_scope: TrackEvent.LegacyEvent.InstantEventScope = @enumFromInt(0),
        pid_override: i32 = 0,
        tid_override: i32 = 0,
        unscoped_id: u64 = 0,
        local_id: u64 = 0,
        global_id: u64 = 0,
        pub fn calcProtobufSize(self: *const TrackEvent.LegacyEvent) usize {
            var res: usize = 0;
            if (self.name_iid != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.NAME_IID_WIRE) + gremlin.sizes.sizeU64(self.name_iid);
            }
            if (self.phase != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.PHASE_WIRE) + gremlin.sizes.sizeI32(self.phase);
            }
            if (self.duration_us != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.DURATION_US_WIRE) + gremlin.sizes.sizeI64(self.duration_us);
            }
            if (self.thread_duration_us != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.THREAD_DURATION_US_WIRE) + gremlin.sizes.sizeI64(self.thread_duration_us);
            }
            if (self.thread_instruction_delta != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.THREAD_INSTRUCTION_DELTA_WIRE) + gremlin.sizes.sizeI64(self.thread_instruction_delta);
            }
            if (self.id_scope) |v| {
                if (v.len > 0) {
                    res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.ID_SCOPE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
                }
            }
            if (self.use_async_tts != false) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.USE_ASYNC_TTS_WIRE) + gremlin.sizes.sizeBool(self.use_async_tts);
            }
            if (self.bind_id != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.BIND_ID_WIRE) + gremlin.sizes.sizeU64(self.bind_id);
            }
            if (self.bind_to_enclosing != false) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.BIND_TO_ENCLOSING_WIRE) + gremlin.sizes.sizeBool(self.bind_to_enclosing);
            }
            if (@intFromEnum(self.flow_direction) != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.FLOW_DIRECTION_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.flow_direction));
            }
            if (@intFromEnum(self.instant_event_scope) != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.INSTANT_EVENT_SCOPE_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.instant_event_scope));
            }
            if (self.pid_override != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.PID_OVERRIDE_WIRE) + gremlin.sizes.sizeI32(self.pid_override);
            }
            if (self.tid_override != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.TID_OVERRIDE_WIRE) + gremlin.sizes.sizeI32(self.tid_override);
            }
            if (self.unscoped_id != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.UNSCOPED_ID_WIRE) + gremlin.sizes.sizeU64(self.unscoped_id);
            }
            if (self.local_id != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.LOCAL_ID_WIRE) + gremlin.sizes.sizeU64(self.local_id);
            }
            if (self.global_id != 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEvent.LegacyEventWire.GLOBAL_ID_WIRE) + gremlin.sizes.sizeU64(self.global_id);
            }
            return res;
        }
        pub fn encode(self: *const TrackEvent.LegacyEvent, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
            const size = self.calcProtobufSize();
            if (size == 0) {
                return &[_]u8{};
            }
            const buf = try allocator.alloc(u8, self.calcProtobufSize());
            var writer = gremlin.Writer.init(buf);
            self.encodeTo(&writer);
            return buf;
        }
        pub fn encodeTo(self: *const TrackEvent.LegacyEvent, target: *gremlin.Writer) void {
            if (self.name_iid != 0) {
                target.appendUint64(TrackEvent.LegacyEventWire.NAME_IID_WIRE, self.name_iid);
            }
            if (self.phase != 0) {
                target.appendInt32(TrackEvent.LegacyEventWire.PHASE_WIRE, self.phase);
            }
            if (self.duration_us != 0) {
                target.appendInt64(TrackEvent.LegacyEventWire.DURATION_US_WIRE, self.duration_us);
            }
            if (self.thread_duration_us != 0) {
                target.appendInt64(TrackEvent.LegacyEventWire.THREAD_DURATION_US_WIRE, self.thread_duration_us);
            }
            if (self.thread_instruction_delta != 0) {
                target.appendInt64(TrackEvent.LegacyEventWire.THREAD_INSTRUCTION_DELTA_WIRE, self.thread_instruction_delta);
            }
            if (self.id_scope) |v| {
                if (v.len > 0) {
                    target.appendBytes(TrackEvent.LegacyEventWire.ID_SCOPE_WIRE, v);
                }
            }
            if (self.use_async_tts != false) {
                target.appendBool(TrackEvent.LegacyEventWire.USE_ASYNC_TTS_WIRE, self.use_async_tts);
            }
            if (self.bind_id != 0) {
                target.appendUint64(TrackEvent.LegacyEventWire.BIND_ID_WIRE, self.bind_id);
            }
            if (self.bind_to_enclosing != false) {
                target.appendBool(TrackEvent.LegacyEventWire.BIND_TO_ENCLOSING_WIRE, self.bind_to_enclosing);
            }
            if (@intFromEnum(self.flow_direction) != 0) {
                target.appendInt32(TrackEvent.LegacyEventWire.FLOW_DIRECTION_WIRE, @intFromEnum(self.flow_direction));
            }
            if (@intFromEnum(self.instant_event_scope) != 0) {
                target.appendInt32(TrackEvent.LegacyEventWire.INSTANT_EVENT_SCOPE_WIRE, @intFromEnum(self.instant_event_scope));
            }
            if (self.pid_override != 0) {
                target.appendInt32(TrackEvent.LegacyEventWire.PID_OVERRIDE_WIRE, self.pid_override);
            }
            if (self.tid_override != 0) {
                target.appendInt32(TrackEvent.LegacyEventWire.TID_OVERRIDE_WIRE, self.tid_override);
            }
            if (self.unscoped_id != 0) {
                target.appendUint64(TrackEvent.LegacyEventWire.UNSCOPED_ID_WIRE, self.unscoped_id);
            }
            if (self.local_id != 0) {
                target.appendUint64(TrackEvent.LegacyEventWire.LOCAL_ID_WIRE, self.local_id);
            }
            if (self.global_id != 0) {
                target.appendUint64(TrackEvent.LegacyEventWire.GLOBAL_ID_WIRE, self.global_id);
            }
        }
    };
    pub const LegacyEventReader = struct {
        buf: gremlin.Reader,
        _name_iid: u64 = 0,
        _phase: i32 = 0,
        _duration_us: i64 = 0,
        _thread_duration_us: i64 = 0,
        _thread_instruction_delta: i64 = 0,
        _id_scope: ?[]const u8 = null,
        _use_async_tts: bool = false,
        _bind_id: u64 = 0,
        _bind_to_enclosing: bool = false,
        _flow_direction: TrackEvent.LegacyEvent.FlowDirection = @enumFromInt(0),
        _instant_event_scope: TrackEvent.LegacyEvent.InstantEventScope = @enumFromInt(0),
        _pid_override: i32 = 0,
        _tid_override: i32 = 0,
        _unscoped_id: u64 = 0,
        _local_id: u64 = 0,
        _global_id: u64 = 0,
        pub fn init(src: []const u8) gremlin.Error!TrackEvent.LegacyEventReader {
            const buf = gremlin.Reader.init(src);
            var res = TrackEvent.LegacyEventReader{ .buf = buf };
            if (buf.buf.len == 0) {
                return res;
            }
            var offset: usize = 0;
            while (buf.hasNext(offset, 0)) {
                const tag = try buf.readTagAt(offset);
                offset += tag.size;
                switch (tag.number) {
                    TrackEvent.LegacyEventWire.NAME_IID_WIRE => {
                        const result = try buf.readUInt64(offset);
                        offset += result.size;
                        res._name_iid = result.value;
                    },
                    TrackEvent.LegacyEventWire.PHASE_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._phase = result.value;
                    },
                    TrackEvent.LegacyEventWire.DURATION_US_WIRE => {
                        const result = try buf.readInt64(offset);
                        offset += result.size;
                        res._duration_us = result.value;
                    },
                    TrackEvent.LegacyEventWire.THREAD_DURATION_US_WIRE => {
                        const result = try buf.readInt64(offset);
                        offset += result.size;
                        res._thread_duration_us = result.value;
                    },
                    TrackEvent.LegacyEventWire.THREAD_INSTRUCTION_DELTA_WIRE => {
                        const result = try buf.readInt64(offset);
                        offset += result.size;
                        res._thread_instruction_delta = result.value;
                    },
                    TrackEvent.LegacyEventWire.ID_SCOPE_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        res._id_scope = result.value;
                    },
                    TrackEvent.LegacyEventWire.USE_ASYNC_TTS_WIRE => {
                        const result = try buf.readBool(offset);
                        offset += result.size;
                        res._use_async_tts = result.value;
                    },
                    TrackEvent.LegacyEventWire.BIND_ID_WIRE => {
                        const result = try buf.readUInt64(offset);
                        offset += result.size;
                        res._bind_id = result.value;
                    },
                    TrackEvent.LegacyEventWire.BIND_TO_ENCLOSING_WIRE => {
                        const result = try buf.readBool(offset);
                        offset += result.size;
                        res._bind_to_enclosing = result.value;
                    },
                    TrackEvent.LegacyEventWire.FLOW_DIRECTION_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._flow_direction = @enumFromInt(result.value);
                    },
                    TrackEvent.LegacyEventWire.INSTANT_EVENT_SCOPE_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._instant_event_scope = @enumFromInt(result.value);
                    },
                    TrackEvent.LegacyEventWire.PID_OVERRIDE_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._pid_override = result.value;
                    },
                    TrackEvent.LegacyEventWire.TID_OVERRIDE_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._tid_override = result.value;
                    },
                    TrackEvent.LegacyEventWire.UNSCOPED_ID_WIRE => {
                        const result = try buf.readUInt64(offset);
                        offset += result.size;
                        res._unscoped_id = result.value;
                    },
                    TrackEvent.LegacyEventWire.LOCAL_ID_WIRE => {
                        const result = try buf.readUInt64(offset);
                        offset += result.size;
                        res._local_id = result.value;
                    },
                    TrackEvent.LegacyEventWire.GLOBAL_ID_WIRE => {
                        const result = try buf.readUInt64(offset);
                        offset += result.size;
                        res._global_id = result.value;
                    },
                    else => {
                        offset = try buf.skipData(offset, tag.wire);
                    },
                }
            }
            return res;
        }
        pub fn sourceBytes(self: *const @This()) []const u8 {
            return self.buf.buf;
        }
        pub inline fn getNameIid(self: *const TrackEvent.LegacyEventReader) u64 {
            return self._name_iid;
        }
        pub inline fn getPhase(self: *const TrackEvent.LegacyEventReader) i32 {
            return self._phase;
        }
        pub inline fn getDurationUs(self: *const TrackEvent.LegacyEventReader) i64 {
            return self._duration_us;
        }
        pub inline fn getThreadDurationUs(self: *const TrackEvent.LegacyEventReader) i64 {
            return self._thread_duration_us;
        }
        pub inline fn getThreadInstructionDelta(self: *const TrackEvent.LegacyEventReader) i64 {
            return self._thread_instruction_delta;
        }
        pub inline fn getIdScope(self: *const TrackEvent.LegacyEventReader) []const u8 {
            return self._id_scope orelse &[_]u8{};
        }
        pub inline fn getUseAsyncTts(self: *const TrackEvent.LegacyEventReader) bool {
            return self._use_async_tts;
        }
        pub inline fn getBindId(self: *const TrackEvent.LegacyEventReader) u64 {
            return self._bind_id;
        }
        pub inline fn getBindToEnclosing(self: *const TrackEvent.LegacyEventReader) bool {
            return self._bind_to_enclosing;
        }
        pub inline fn getFlowDirection(self: *const TrackEvent.LegacyEventReader) TrackEvent.LegacyEvent.FlowDirection {
            return self._flow_direction;
        }
        pub inline fn getInstantEventScope(self: *const TrackEvent.LegacyEventReader) TrackEvent.LegacyEvent.InstantEventScope {
            return self._instant_event_scope;
        }
        pub inline fn getPidOverride(self: *const TrackEvent.LegacyEventReader) i32 {
            return self._pid_override;
        }
        pub inline fn getTidOverride(self: *const TrackEvent.LegacyEventReader) i32 {
            return self._tid_override;
        }
        pub inline fn getUnscopedId(self: *const TrackEvent.LegacyEventReader) u64 {
            return self._unscoped_id;
        }
        pub inline fn getLocalId(self: *const TrackEvent.LegacyEventReader) u64 {
            return self._local_id;
        }
        pub inline fn getGlobalId(self: *const TrackEvent.LegacyEventReader) u64 {
            return self._global_id;
        }
    };
    // fields
    // KEEP:
    // - name
    // - type
    // - track_uuid
    // - debug_annotations
    // - flow_ids
    // - terminating_flow_ids
    type: TrackEvent.Type = @enumFromInt(0),
    track_uuid: u64 = 0,
    flow_ids: ?[]const u64 = null,
    terminating_flow_ids: ?[]const u64 = null,
    debug_annotations: ?[]const ?debug_annotation.DebugAnnotation = null,
    name_iid: u64 = 0,
    name: ?[]const u8 = null,
    counter_value: i64 = 0,
    double_counter_value: f64 = 0.0,
    correlation_id: u64 = 0,
    correlation_id_str_iid: u64 = 0,
    callstack_iid: u64 = 0,
    source_location_iid: u64 = 0,
    timestamp_delta_us: i64 = 0,
    timestamp_absolute_us: i64 = 0,
    thread_time_delta_us: i64 = 0,
    thread_time_absolute_us: i64 = 0,
    thread_instruction_count_delta: i64 = 0,
    thread_instruction_count_absolute: i64 = 0,
    pub fn calcProtobufSize(self: *const TrackEvent) usize {
        var res: usize = 0;
        if (@intFromEnum(self.type) != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.TYPE_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.type));
        }
        if (self.track_uuid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.TRACK_UUID_WIRE) + gremlin.sizes.sizeU64(self.track_uuid);
        }
        if (self.flow_ids) |arr| {
            if (arr.len == 0) {} else if (arr.len == 1) {
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.FLOW_IDS_WIRE) + gremlin.sizes.sizeFixed64(arr[0]);
            } else {
                var packed_size: usize = 0;
                for (arr) |v| {
                    packed_size += gremlin.sizes.sizeFixed64(v);
                }
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.FLOW_IDS_WIRE) + gremlin.sizes.sizeUsize(packed_size) + packed_size;
            }
        }
        if (self.terminating_flow_ids) |arr| {
            if (arr.len == 0) {} else if (arr.len == 1) {
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.TERMINATING_FLOW_IDS_WIRE) + gremlin.sizes.sizeFixed64(arr[0]);
            } else {
                var packed_size: usize = 0;
                for (arr) |v| {
                    packed_size += gremlin.sizes.sizeFixed64(v);
                }
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.TERMINATING_FLOW_IDS_WIRE) + gremlin.sizes.sizeUsize(packed_size) + packed_size;
            }
        }
        if (self.debug_annotations) |arr| {
            for (arr) |maybe_v| {
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.DEBUG_ANNOTATIONS_WIRE);
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    res += gremlin.sizes.sizeUsize(size) + size;
                } else {
                    res += gremlin.sizes.sizeUsize(0);
                }
            }
        }
        if (self.name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(TrackEventWire.NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.counter_value != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.COUNTER_VALUE_WIRE) + gremlin.sizes.sizeI64(self.counter_value);
        }
        if (self.double_counter_value != 0.0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.DOUBLE_COUNTER_VALUE_WIRE) + gremlin.sizes.sizeDouble(self.double_counter_value);
        }
        if (self.correlation_id != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.CORRELATION_ID_WIRE) + gremlin.sizes.sizeU64(self.correlation_id);
        }
        if (self.correlation_id_str_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.CORRELATION_ID_STR_IID_WIRE) + gremlin.sizes.sizeU64(self.correlation_id_str_iid);
        }
        if (self.callstack_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.CALLSTACK_IID_WIRE) + gremlin.sizes.sizeU64(self.callstack_iid);
        }
        if (self.source_location_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.SOURCE_LOCATION_IID_WIRE) + gremlin.sizes.sizeU64(self.source_location_iid);
        }
        if (self.timestamp_delta_us != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.TIMESTAMP_DELTA_US_WIRE) + gremlin.sizes.sizeI64(self.timestamp_delta_us);
        }
        if (self.timestamp_absolute_us != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.TIMESTAMP_ABSOLUTE_US_WIRE) + gremlin.sizes.sizeI64(self.timestamp_absolute_us);
        }
        if (self.thread_time_delta_us != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.THREAD_TIME_DELTA_US_WIRE) + gremlin.sizes.sizeI64(self.thread_time_delta_us);
        }
        if (self.thread_time_absolute_us != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.THREAD_TIME_ABSOLUTE_US_WIRE) + gremlin.sizes.sizeI64(self.thread_time_absolute_us);
        }
        if (self.thread_instruction_count_delta != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.THREAD_INSTRUCTION_COUNT_DELTA_WIRE) + gremlin.sizes.sizeI64(self.thread_instruction_count_delta);
        }
        if (self.thread_instruction_count_absolute != 0) {
            res += gremlin.sizes.sizeWireNumber(TrackEventWire.THREAD_INSTRUCTION_COUNT_ABSOLUTE_WIRE) + gremlin.sizes.sizeI64(self.thread_instruction_count_absolute);
        }
        return res;
    }
    pub fn encode(self: *const TrackEvent, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
        const size = self.calcProtobufSize();
        if (size == 0) {
            return &[_]u8{};
        }
        const buf = try allocator.alloc(u8, self.calcProtobufSize());
        var writer = gremlin.Writer.init(buf);
        self.encodeTo(&writer);
        return buf;
    }
    pub fn encodeTo(self: *const TrackEvent, target: *gremlin.Writer) void {
        if (@intFromEnum(self.type) != 0) {
            target.appendInt32(TrackEventWire.TYPE_WIRE, @intFromEnum(self.type));
        }
        if (self.track_uuid != 0) {
            target.appendUint64(TrackEventWire.TRACK_UUID_WIRE, self.track_uuid);
        }
        if (self.flow_ids) |arr| {
            if (arr.len == 0) {} else if (arr.len == 1) {
                target.appendFixed64(TrackEventWire.FLOW_IDS_WIRE, arr[0]);
            } else {
                var packed_size: usize = 0;
                for (arr) |v| {
                    packed_size += gremlin.sizes.sizeFixed64(v);
                }
                target.appendBytesTag(TrackEventWire.FLOW_IDS_WIRE, packed_size);
                for (arr) |v| {
                    target.appendFixed64WithoutTag(v);
                }
            }
        }
        if (self.terminating_flow_ids) |arr| {
            if (arr.len == 0) {} else if (arr.len == 1) {
                target.appendFixed64(TrackEventWire.TERMINATING_FLOW_IDS_WIRE, arr[0]);
            } else {
                var packed_size: usize = 0;
                for (arr) |v| {
                    packed_size += gremlin.sizes.sizeFixed64(v);
                }
                target.appendBytesTag(TrackEventWire.TERMINATING_FLOW_IDS_WIRE, packed_size);
                for (arr) |v| {
                    target.appendFixed64WithoutTag(v);
                }
            }
        }
        if (self.debug_annotations) |arr| {
            for (arr) |maybe_v| {
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    target.appendBytesTag(TrackEventWire.DEBUG_ANNOTATIONS_WIRE, size);
                    v.encodeTo(target);
                } else {
                    target.appendBytesTag(TrackEventWire.DEBUG_ANNOTATIONS_WIRE, 0);
                }
            }
        }
        if (self.name_iid != 0) {
            target.appendUint64(TrackEventWire.NAME_IID_WIRE, self.name_iid);
        }
        if (self.name) |v| {
            if (v.len > 0) {
                target.appendBytes(TrackEventWire.NAME_WIRE, v);
            }
        }
        if (self.counter_value != 0) {
            target.appendInt64(TrackEventWire.COUNTER_VALUE_WIRE, self.counter_value);
        }
        if (self.double_counter_value != 0.0) {
            target.appendFloat64(TrackEventWire.DOUBLE_COUNTER_VALUE_WIRE, self.double_counter_value);
        }
        if (self.correlation_id != 0) {
            target.appendUint64(TrackEventWire.CORRELATION_ID_WIRE, self.correlation_id);
        }
        if (self.correlation_id_str_iid != 0) {
            target.appendUint64(TrackEventWire.CORRELATION_ID_STR_IID_WIRE, self.correlation_id_str_iid);
        }
        if (self.callstack_iid != 0) {
            target.appendUint64(TrackEventWire.CALLSTACK_IID_WIRE, self.callstack_iid);
        }
        if (self.source_location_iid != 0) {
            target.appendUint64(TrackEventWire.SOURCE_LOCATION_IID_WIRE, self.source_location_iid);
        }
        if (self.timestamp_delta_us != 0) {
            target.appendInt64(TrackEventWire.TIMESTAMP_DELTA_US_WIRE, self.timestamp_delta_us);
        }
        if (self.timestamp_absolute_us != 0) {
            target.appendInt64(TrackEventWire.TIMESTAMP_ABSOLUTE_US_WIRE, self.timestamp_absolute_us);
        }
        if (self.thread_time_delta_us != 0) {
            target.appendInt64(TrackEventWire.THREAD_TIME_DELTA_US_WIRE, self.thread_time_delta_us);
        }
        if (self.thread_time_absolute_us != 0) {
            target.appendInt64(TrackEventWire.THREAD_TIME_ABSOLUTE_US_WIRE, self.thread_time_absolute_us);
        }
        if (self.thread_instruction_count_delta != 0) {
            target.appendInt64(TrackEventWire.THREAD_INSTRUCTION_COUNT_DELTA_WIRE, self.thread_instruction_count_delta);
        }
        if (self.thread_instruction_count_absolute != 0) {
            target.appendInt64(TrackEventWire.THREAD_INSTRUCTION_COUNT_ABSOLUTE_WIRE, self.thread_instruction_count_absolute);
        }
    }
};
