const std = @import("std");
const gremlin = @import("gremlin");
// structs
const DebugAnnotationWire = struct {
    const PROTO_VALUE_WIRE: gremlin.ProtoWireNumber = 14;
    const DICT_ENTRIES_WIRE: gremlin.ProtoWireNumber = 11;
    const ARRAY_VALUES_WIRE: gremlin.ProtoWireNumber = 12;
    const NAME_IID_WIRE: gremlin.ProtoWireNumber = 1;
    const NAME_WIRE: gremlin.ProtoWireNumber = 10;
    const BOOL_VALUE_WIRE: gremlin.ProtoWireNumber = 2;
    const UINT_VALUE_WIRE: gremlin.ProtoWireNumber = 3;
    const INT_VALUE_WIRE: gremlin.ProtoWireNumber = 4;
    const DOUBLE_VALUE_WIRE: gremlin.ProtoWireNumber = 5;
    const POINTER_VALUE_WIRE: gremlin.ProtoWireNumber = 7;
    const NESTED_VALUE_WIRE: gremlin.ProtoWireNumber = 8;
    const LEGACY_JSON_VALUE_WIRE: gremlin.ProtoWireNumber = 9;
    const STRING_VALUE_WIRE: gremlin.ProtoWireNumber = 6;
    const STRING_VALUE_IID_WIRE: gremlin.ProtoWireNumber = 17;
    const PROTO_TYPE_NAME_WIRE: gremlin.ProtoWireNumber = 16;
    const PROTO_TYPE_NAME_IID_WIRE: gremlin.ProtoWireNumber = 13;
};
pub const DebugAnnotation = struct {
    // nested structs
    const NestedValueWire = struct {
        const NESTED_TYPE_WIRE: gremlin.ProtoWireNumber = 1;
        const DICT_KEYS_WIRE: gremlin.ProtoWireNumber = 2;
        const DICT_VALUES_WIRE: gremlin.ProtoWireNumber = 3;
        const ARRAY_VALUES_WIRE: gremlin.ProtoWireNumber = 4;
        const INT_VALUE_WIRE: gremlin.ProtoWireNumber = 5;
        const DOUBLE_VALUE_WIRE: gremlin.ProtoWireNumber = 6;
        const BOOL_VALUE_WIRE: gremlin.ProtoWireNumber = 7;
        const STRING_VALUE_WIRE: gremlin.ProtoWireNumber = 8;
    };
    pub const NestedValue = struct {
        // nested enums
        pub const NestedType = enum(i32) {
            UNSPECIFIED = 0,
            DICT = 1,
            ARRAY = 2,
        };
        // fields
        nested_type: DebugAnnotation.NestedValue.NestedType = @enumFromInt(0),
        dict_keys: ?[]const ?[]const u8 = null,
        dict_values: ?[]const ?DebugAnnotation.NestedValue = null,
        array_values: ?[]const ?DebugAnnotation.NestedValue = null,
        int_value: i64 = 0,
        double_value: f64 = 0.0,
        bool_value: bool = false,
        string_value: ?[]const u8 = null,
        pub fn calcProtobufSize(self: *const DebugAnnotation.NestedValue) usize {
            var res: usize = 0;
            if (@intFromEnum(self.nested_type) != 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.NESTED_TYPE_WIRE) + gremlin.sizes.sizeI32(@intFromEnum(self.nested_type));
            }
            if (self.dict_keys) |arr| {
                for (arr) |maybe_v| {
                    res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.DICT_KEYS_WIRE);
                    if (maybe_v) |v| {
                        res += gremlin.sizes.sizeUsize(v.len) + v.len;
                    } else {
                        res += gremlin.sizes.sizeUsize(0);
                    }
                }
            }
            if (self.dict_values) |arr| {
                for (arr) |maybe_v| {
                    res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.DICT_VALUES_WIRE);
                    if (maybe_v) |v| {
                        const size = v.calcProtobufSize();
                        res += gremlin.sizes.sizeUsize(size) + size;
                    } else {
                        res += gremlin.sizes.sizeUsize(0);
                    }
                }
            }
            if (self.array_values) |arr| {
                for (arr) |maybe_v| {
                    res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.ARRAY_VALUES_WIRE);
                    if (maybe_v) |v| {
                        const size = v.calcProtobufSize();
                        res += gremlin.sizes.sizeUsize(size) + size;
                    } else {
                        res += gremlin.sizes.sizeUsize(0);
                    }
                }
            }
            if (self.int_value != 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.INT_VALUE_WIRE) + gremlin.sizes.sizeI64(self.int_value);
            }
            if (self.double_value != 0.0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.DOUBLE_VALUE_WIRE) + gremlin.sizes.sizeDouble(self.double_value);
            }
            if (self.bool_value != false) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.BOOL_VALUE_WIRE) + gremlin.sizes.sizeBool(self.bool_value);
            }
            if (self.string_value) |v| {
                if (v.len > 0) {
                    res += gremlin.sizes.sizeWireNumber(DebugAnnotation.NestedValueWire.STRING_VALUE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
                }
            }
            return res;
        }
        pub fn encode(self: *const DebugAnnotation.NestedValue, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
            const size = self.calcProtobufSize();
            if (size == 0) {
                return &[_]u8{};
            }
            const buf = try allocator.alloc(u8, self.calcProtobufSize());
            var writer = gremlin.Writer.init(buf);
            self.encodeTo(&writer);
            return buf;
        }
        pub fn encodeTo(self: *const DebugAnnotation.NestedValue, target: *gremlin.Writer) void {
            if (@intFromEnum(self.nested_type) != 0) {
                target.appendInt32(DebugAnnotation.NestedValueWire.NESTED_TYPE_WIRE, @intFromEnum(self.nested_type));
            }
            if (self.dict_keys) |arr| {
                for (arr) |maybe_v| {
                    if (maybe_v) |v| {
                        target.appendBytes(DebugAnnotation.NestedValueWire.DICT_KEYS_WIRE, v);
                    } else {
                        target.appendBytesTag(DebugAnnotation.NestedValueWire.DICT_KEYS_WIRE, 0);
                    }
                }
            }
            if (self.dict_values) |arr| {
                for (arr) |maybe_v| {
                    if (maybe_v) |v| {
                        const size = v.calcProtobufSize();
                        target.appendBytesTag(DebugAnnotation.NestedValueWire.DICT_VALUES_WIRE, size);
                        v.encodeTo(target);
                    } else {
                        target.appendBytesTag(DebugAnnotation.NestedValueWire.DICT_VALUES_WIRE, 0);
                    }
                }
            }
            if (self.array_values) |arr| {
                for (arr) |maybe_v| {
                    if (maybe_v) |v| {
                        const size = v.calcProtobufSize();
                        target.appendBytesTag(DebugAnnotation.NestedValueWire.ARRAY_VALUES_WIRE, size);
                        v.encodeTo(target);
                    } else {
                        target.appendBytesTag(DebugAnnotation.NestedValueWire.ARRAY_VALUES_WIRE, 0);
                    }
                }
            }
            if (self.int_value != 0) {
                target.appendInt64(DebugAnnotation.NestedValueWire.INT_VALUE_WIRE, self.int_value);
            }
            if (self.double_value != 0.0) {
                target.appendFloat64(DebugAnnotation.NestedValueWire.DOUBLE_VALUE_WIRE, self.double_value);
            }
            if (self.bool_value != false) {
                target.appendBool(DebugAnnotation.NestedValueWire.BOOL_VALUE_WIRE, self.bool_value);
            }
            if (self.string_value) |v| {
                if (v.len > 0) {
                    target.appendBytes(DebugAnnotation.NestedValueWire.STRING_VALUE_WIRE, v);
                }
            }
        }
    };
    pub const NestedValueReader = struct {
        buf: gremlin.Reader,
        _nested_type: DebugAnnotation.NestedValue.NestedType = @enumFromInt(0),
        _dict_keys_offset: ?usize = null,
        _dict_keys_last_offset: ?usize = null,
        _dict_keys_cnt: usize = 0,
        _dict_values_offset: ?usize = null,
        _dict_values_last_offset: ?usize = null,
        _dict_values_cnt: usize = 0,
        _array_values_offset: ?usize = null,
        _array_values_last_offset: ?usize = null,
        _array_values_cnt: usize = 0,
        _int_value: i64 = 0,
        _double_value: f64 = 0.0,
        _bool_value: bool = false,
        _string_value: ?[]const u8 = null,
        pub fn init(src: []const u8) gremlin.Error!DebugAnnotation.NestedValueReader {
            const buf = gremlin.Reader.init(src);
            var res = DebugAnnotation.NestedValueReader{ .buf = buf };
            if (buf.buf.len == 0) {
                return res;
            }
            var offset: usize = 0;
            while (buf.hasNext(offset, 0)) {
                const tag = try buf.readTagAt(offset);
                offset += tag.size;
                switch (tag.number) {
                    DebugAnnotation.NestedValueWire.NESTED_TYPE_WIRE => {
                        const result = try buf.readInt32(offset);
                        offset += result.size;
                        res._nested_type = @enumFromInt(result.value);
                    },
                    DebugAnnotation.NestedValueWire.DICT_KEYS_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        if (res._dict_keys_offset == null) {
                            res._dict_keys_offset = offset - result.size;
                        }
                        res._dict_keys_last_offset = offset;
                        res._dict_keys_cnt += 1;
                    },
                    DebugAnnotation.NestedValueWire.DICT_VALUES_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        if (res._dict_values_offset == null) {
                            res._dict_values_offset = offset - result.size;
                        }
                        res._dict_values_last_offset = offset;
                        res._dict_values_cnt += 1;
                    },
                    DebugAnnotation.NestedValueWire.ARRAY_VALUES_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        if (res._array_values_offset == null) {
                            res._array_values_offset = offset - result.size;
                        }
                        res._array_values_last_offset = offset;
                        res._array_values_cnt += 1;
                    },
                    DebugAnnotation.NestedValueWire.INT_VALUE_WIRE => {
                        const result = try buf.readInt64(offset);
                        offset += result.size;
                        res._int_value = result.value;
                    },
                    DebugAnnotation.NestedValueWire.DOUBLE_VALUE_WIRE => {
                        const result = try buf.readFloat64(offset);
                        offset += result.size;
                        res._double_value = result.value;
                    },
                    DebugAnnotation.NestedValueWire.BOOL_VALUE_WIRE => {
                        const result = try buf.readBool(offset);
                        offset += result.size;
                        res._bool_value = result.value;
                    },
                    DebugAnnotation.NestedValueWire.STRING_VALUE_WIRE => {
                        const result = try buf.readBytes(offset);
                        offset += result.size;
                        res._string_value = result.value;
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
        pub inline fn getNestedType(self: *const DebugAnnotation.NestedValueReader) DebugAnnotation.NestedValue.NestedType {
            return self._nested_type;
        }
        pub fn dictKeysCount(self: *const DebugAnnotation.NestedValueReader) usize {
            return self._dict_keys_cnt;
        }
        pub fn dictKeysNext(self: *DebugAnnotation.NestedValueReader) ?[]const u8 {
            if (self._dict_keys_offset == null) return null;
            const current_offset = self._dict_keys_offset.?;
            const result = self.buf.readBytes(current_offset) catch return null;
            if (self._dict_keys_last_offset != null and current_offset >= self._dict_keys_last_offset.?) {
                self._dict_keys_offset = null;
                return result.value;
            }
            if (self._dict_keys_last_offset == null) unreachable;
            var next_offset = current_offset + result.size;
            const max_offset = self._dict_keys_last_offset.?;
            while (next_offset <= max_offset and self.buf.hasNext(next_offset, 0)) {
                const tag = self.buf.readTagAt(next_offset) catch break;
                next_offset += tag.size;
                if (tag.number == DebugAnnotation.NestedValueWire.DICT_KEYS_WIRE) {
                    self._dict_keys_offset = next_offset;
                    return result.value;
                } else {
                    next_offset = self.buf.skipData(next_offset, tag.wire) catch break;
                }
            }
            self._dict_keys_offset = null;
            return result.value;
        }
        pub fn dictValuesCount(self: *const DebugAnnotation.NestedValueReader) usize {
            return self._dict_values_cnt;
        }
        pub fn dictValuesNext(self: *DebugAnnotation.NestedValueReader) ?DebugAnnotation.NestedValueReader {
            if (self._dict_values_offset == null) return null;
            const current_offset = self._dict_values_offset.?;
            const result = self.buf.readBytes(current_offset) catch return null;
            const msg = DebugAnnotation.NestedValueReader.init(result.value) catch return null;
            if (self._dict_values_last_offset != null and current_offset >= self._dict_values_last_offset.?) {
                self._dict_values_offset = null;
                return msg;
            }
            if (self._dict_values_last_offset == null) unreachable;
            var next_offset = current_offset + result.size;
            const max_offset = self._dict_values_last_offset.?;
            while (next_offset <= max_offset and self.buf.hasNext(next_offset, 0)) {
                const tag = self.buf.readTagAt(next_offset) catch break;
                next_offset += tag.size;
                if (tag.number == DebugAnnotation.NestedValueWire.DICT_VALUES_WIRE) {
                    self._dict_values_offset = next_offset;
                    return msg;
                } else {
                    next_offset = self.buf.skipData(next_offset, tag.wire) catch break;
                }
            }
            self._dict_values_offset = null;
            return msg;
        }
        pub fn arrayValuesCount(self: *const DebugAnnotation.NestedValueReader) usize {
            return self._array_values_cnt;
        }
        pub fn arrayValuesNext(self: *DebugAnnotation.NestedValueReader) ?DebugAnnotation.NestedValueReader {
            if (self._array_values_offset == null) return null;
            const current_offset = self._array_values_offset.?;
            const result = self.buf.readBytes(current_offset) catch return null;
            const msg = DebugAnnotation.NestedValueReader.init(result.value) catch return null;
            if (self._array_values_last_offset != null and current_offset >= self._array_values_last_offset.?) {
                self._array_values_offset = null;
                return msg;
            }
            if (self._array_values_last_offset == null) unreachable;
            var next_offset = current_offset + result.size;
            const max_offset = self._array_values_last_offset.?;
            while (next_offset <= max_offset and self.buf.hasNext(next_offset, 0)) {
                const tag = self.buf.readTagAt(next_offset) catch break;
                next_offset += tag.size;
                if (tag.number == DebugAnnotation.NestedValueWire.ARRAY_VALUES_WIRE) {
                    self._array_values_offset = next_offset;
                    return msg;
                } else {
                    next_offset = self.buf.skipData(next_offset, tag.wire) catch break;
                }
            }
            self._array_values_offset = null;
            return msg;
        }
        pub inline fn getIntValue(self: *const DebugAnnotation.NestedValueReader) i64 {
            return self._int_value;
        }
        pub inline fn getDoubleValue(self: *const DebugAnnotation.NestedValueReader) f64 {
            return self._double_value;
        }
        pub inline fn getBoolValue(self: *const DebugAnnotation.NestedValueReader) bool {
            return self._bool_value;
        }
        pub inline fn getStringValue(self: *const DebugAnnotation.NestedValueReader) []const u8 {
            return self._string_value orelse &[_]u8{};
        }
    };
    // fields
    proto_value: ?[]const u8 = null,
    dict_entries: ?[]const ?DebugAnnotation = null,
    array_values: ?[]const ?DebugAnnotation = null,
    name_iid: u64 = 0,
    name: ?[]const u8 = null,
    bool_value: bool = false,
    uint_value: u64 = 0,
    int_value: i64 = 0,
    double_value: f64 = 0.0,
    pointer_value: u64 = 0,
    nested_value: ?DebugAnnotation.NestedValue = null,
    legacy_json_value: ?[]const u8 = null,
    string_value: ?[]const u8 = null,
    string_value_iid: u64 = 0,
    proto_type_name: ?[]const u8 = null,
    proto_type_name_iid: u64 = 0,
    pub fn calcProtobufSize(self: *const DebugAnnotation) usize {
        var res: usize = 0;
        if (self.proto_value) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.PROTO_VALUE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.dict_entries) |arr| {
            for (arr) |maybe_v| {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.DICT_ENTRIES_WIRE);
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    res += gremlin.sizes.sizeUsize(size) + size;
                } else {
                    res += gremlin.sizes.sizeUsize(0);
                }
            }
        }
        if (self.array_values) |arr| {
            for (arr) |maybe_v| {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.ARRAY_VALUES_WIRE);
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    res += gremlin.sizes.sizeUsize(size) + size;
                } else {
                    res += gremlin.sizes.sizeUsize(0);
                }
            }
        }
        if (self.name_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.NAME_IID_WIRE) + gremlin.sizes.sizeU64(self.name_iid);
        }
        if (self.name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.bool_value != false) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.BOOL_VALUE_WIRE) + gremlin.sizes.sizeBool(self.bool_value);
        }
        if (self.uint_value != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.UINT_VALUE_WIRE) + gremlin.sizes.sizeU64(self.uint_value);
        }
        if (self.int_value != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.INT_VALUE_WIRE) + gremlin.sizes.sizeI64(self.int_value);
        }
        if (self.double_value != 0.0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.DOUBLE_VALUE_WIRE) + gremlin.sizes.sizeDouble(self.double_value);
        }
        if (self.pointer_value != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.POINTER_VALUE_WIRE) + gremlin.sizes.sizeU64(self.pointer_value);
        }
        if (self.nested_value) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.NESTED_VALUE_WIRE) + gremlin.sizes.sizeUsize(size) + size;
            }
        }
        if (self.legacy_json_value) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.LEGACY_JSON_VALUE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.string_value) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.STRING_VALUE_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.string_value_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.STRING_VALUE_IID_WIRE) + gremlin.sizes.sizeU64(self.string_value_iid);
        }
        if (self.proto_type_name) |v| {
            if (v.len > 0) {
                res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.PROTO_TYPE_NAME_WIRE) + gremlin.sizes.sizeUsize(v.len) + v.len;
            }
        }
        if (self.proto_type_name_iid != 0) {
            res += gremlin.sizes.sizeWireNumber(DebugAnnotationWire.PROTO_TYPE_NAME_IID_WIRE) + gremlin.sizes.sizeU64(self.proto_type_name_iid);
        }
        return res;
    }
    pub fn encode(self: *const DebugAnnotation, allocator: std.mem.Allocator) gremlin.Error![]const u8 {
        const size = self.calcProtobufSize();
        if (size == 0) {
            return &[_]u8{};
        }
        const buf = try allocator.alloc(u8, self.calcProtobufSize());
        var writer = gremlin.Writer.init(buf);
        self.encodeTo(&writer);
        return buf;
    }
    pub fn encodeTo(self: *const DebugAnnotation, target: *gremlin.Writer) void {
        if (self.proto_value) |v| {
            if (v.len > 0) {
                target.appendBytes(DebugAnnotationWire.PROTO_VALUE_WIRE, v);
            }
        }
        if (self.dict_entries) |arr| {
            for (arr) |maybe_v| {
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    target.appendBytesTag(DebugAnnotationWire.DICT_ENTRIES_WIRE, size);
                    v.encodeTo(target);
                } else {
                    target.appendBytesTag(DebugAnnotationWire.DICT_ENTRIES_WIRE, 0);
                }
            }
        }
        if (self.array_values) |arr| {
            for (arr) |maybe_v| {
                if (maybe_v) |v| {
                    const size = v.calcProtobufSize();
                    target.appendBytesTag(DebugAnnotationWire.ARRAY_VALUES_WIRE, size);
                    v.encodeTo(target);
                } else {
                    target.appendBytesTag(DebugAnnotationWire.ARRAY_VALUES_WIRE, 0);
                }
            }
        }
        if (self.name_iid != 0) {
            target.appendUint64(DebugAnnotationWire.NAME_IID_WIRE, self.name_iid);
        }
        if (self.name) |v| {
            if (v.len > 0) {
                target.appendBytes(DebugAnnotationWire.NAME_WIRE, v);
            }
        }
        if (self.bool_value != false) {
            target.appendBool(DebugAnnotationWire.BOOL_VALUE_WIRE, self.bool_value);
        }
        if (self.uint_value != 0) {
            target.appendUint64(DebugAnnotationWire.UINT_VALUE_WIRE, self.uint_value);
        }
        if (self.int_value != 0) {
            target.appendInt64(DebugAnnotationWire.INT_VALUE_WIRE, self.int_value);
        }
        if (self.double_value != 0.0) {
            target.appendFloat64(DebugAnnotationWire.DOUBLE_VALUE_WIRE, self.double_value);
        }
        if (self.pointer_value != 0) {
            target.appendUint64(DebugAnnotationWire.POINTER_VALUE_WIRE, self.pointer_value);
        }
        if (self.nested_value) |v| {
            const size = v.calcProtobufSize();
            if (size > 0) {
                target.appendBytesTag(DebugAnnotationWire.NESTED_VALUE_WIRE, size);
                v.encodeTo(target);
            }
        }
        if (self.legacy_json_value) |v| {
            if (v.len > 0) {
                target.appendBytes(DebugAnnotationWire.LEGACY_JSON_VALUE_WIRE, v);
            }
        }
        if (self.string_value) |v| {
            if (v.len > 0) {
                target.appendBytes(DebugAnnotationWire.STRING_VALUE_WIRE, v);
            }
        }
        if (self.string_value_iid != 0) {
            target.appendUint64(DebugAnnotationWire.STRING_VALUE_IID_WIRE, self.string_value_iid);
        }
        if (self.proto_type_name) |v| {
            if (v.len > 0) {
                target.appendBytes(DebugAnnotationWire.PROTO_TYPE_NAME_WIRE, v);
            }
        }
        if (self.proto_type_name_iid != 0) {
            target.appendUint64(DebugAnnotationWire.PROTO_TYPE_NAME_IID_WIRE, self.proto_type_name_iid);
        }
    }
};
