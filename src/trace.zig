const trace = @import("gen/protos/perfetto//trace//trace.proto.zig");
pub const Trace = trace.Trace;
pub const TraceReader = trace.TraceReader;

const trace_packet = @import("gen/protos/perfetto/trace/trace_packet.proto.zig");
pub const TracePacket = trace_packet.TracePacket;
pub const TracePacketReader = trace_packet.TracePacketReader;

const trace_packet_defaults = @import("gen/protos/perfetto/trace/trace_packet_defaults.proto.zig");
pub const TracePacketDefaults = trace_packet_defaults.TracePacketDefaults;
pub const TracePacketDefaultsReader = trace_packet_defaults.TracePacketDefaultsReader;

const track_event = @import("gen/protos/perfetto/trace/track_event/track_event.proto.zig");
pub const TrackEvent = track_event.TrackEvent;
pub const TrackEventReader = track_event.TrackEventReader;
pub const TrackEventDefaults = track_event.TrackEventDefaults;
pub const TrackEventDefaultsReader = track_event.TrackEventDefaultsReader;

const debug_annotation = @import("gen/protos/perfetto/trace/track_event/debug_annotation.proto.zig");
const DebugAnnotation = debug_annotation.DebugAnnotation;
const DebugAnnotationReader = debug_annotation.DebugAnnotationReader;

const track_descriptor = @import("gen/protos/perfetto/trace/track_event/track_descriptor.proto.zig");
const TrackDescriptor = track_descriptor.TrackDescriptor;
const TrackDescriptorReader = track_descriptor.TrackDescriptorReader;
