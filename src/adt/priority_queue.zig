const std = @import("std");

const heap = @import("../ds/heap.zig");

const Order = enum {
    ASC,
    DESC
};

const Implementation = enum {
    HEAP,
    AVL_TREE,
    RED_BLACK_TREE,
};

const Options = struct {
    order: Order = .ASC,
    impl: Implementation = .HEAP,
}; 

pub fn PriorityQueue(comptime T: type, opt: Options) type {
    if (opt.impl == .HEAP) {
        return HeapPriorityQueue(T);
    }
    @compileError(std.fmt.comptimePrint("PriorityQueue with options {order={}, impl={}} not implemented.", .{opt.order, opt.impl}));
}

fn HeapPriorityQueue(T: type) type {
    return struct {
        const Self = @This();

        heap: heap.MaxHeap(T),

        pub fn init(allocator: std.mem.Allocator) Self {
            return .{
                .heap = heap.MaxHeap(T).init(allocator, null)
            };
        }

        pub fn enqueue(_: *Self, _: T) !void {
            return;
        }

        pub fn dequeue(_: *Self) ?T {
            return null;
        }

        pub fn top(_: *Self) ?T {
            return null;
        }
    };
}

