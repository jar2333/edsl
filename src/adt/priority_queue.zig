const std = @import("std");

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
    order: Order = .DESC,
    impl: Implementation = .HEAP,
}; 

fn PriorityQueue(comptime T: type, _: Options) type {
    const Self = @This();

    return struct {
        pub fn init() Self {
            return .{};
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

