const std = @import("std");

///
/// ================================
/// = Implementation of max heap
/// ================================
/// 
/// Given a type T, supports the operations:
///     - push(value: *T, priority: i32) void
///     - pop() ?*T
///     - peek() ?*T
/// 
/// The recursive implementation in the reference material was unrolled into an iterative one.
/// 
/// References:
/// - Foundations of Computer Science C Edition (A. Aho, J. D. Ullman)
/// 
fn MaxHeap(comptime T: type) type {
    return struct {
        const Self = @This();

        const Pair = struct {
            element: *const T,
            priority: i32
        };

        elements: std.ArrayList(Pair),

        pub fn init(allocator: std.mem.Allocator) std.mem.Allocator.Error!Self {
            return .{
                .elements = std.ArrayList(Pair).init(allocator),
            };
        }

        pub fn deinit(self: *Self) void {
            self.elements.deinit();
        }
        
        pub fn push(self: *Self, v: *const T, p: i32) std.mem.Allocator.Error!void {
            try self.elements.append(.{
                .element = v, 
                .priority = p
            });
            const i = self.elements.items.len;
            self.bubbleUp(i-1);
        } 

        pub fn pop(self: *Self) ?*const T {
            if (self.elements.items.len == 0) 
                return null;

            const max = self.elements.items[0].element;
            self.elements.items[0] = self.elements.pop();

            if (self.elements.items.len > 0)
                self.bubbleDown(0);

            return max;
        }

        pub fn peek(self: *Self) ?*const T {
            return self.elements.items[0];
        }

        fn bubbleDown(self: *Self, i: usize) void {
            const A = self.elements.items;
            const n = A.len-1;

            var cur = i;
            while (true) {
                // Get left child
                var child = 2*cur;

                // Check if child exists. If not, return.
                if (child > n) return;

                // Check if right child exists, and if it is larger than left child. If so, select it.
                if (child < n and A[child+1].priority > A[child].priority) 
                    child += 1;

                // Check if current is equal or larger than child. If so, we return. Else, we bubble down.
                if (A[cur].priority >= A[child].priority) return;
                
                self.swap(cur, child);

                cur = child;
            }
        }

        fn bubbleUp(self: *Self, i: usize) void {
            const A = self.elements.items;

            // Check if current is not root and if it is bigger than parent. If so, bubble up:
            var cur = i;
            while (cur > 0 and A[cur].priority > A[cur / 2].priority): (cur /= 2) {
                self.swap(cur, cur / 2);
            }
        }

        fn swap(self: *Self, i: usize, j: usize) void {
            const A = self.elements.items;
            const tmp = A[i];
            A[i] = A[j]; 
            A[j] = tmp;
        }

    };
}

const testing_allocator = std.testing.allocator;

test "heap sort" {
    const Record = struct {
        uuid: u128,
        name: [:0]const u8,
        priority: i32,
    };

    var heap = try MaxHeap(Record).init(testing_allocator);
    defer heap.deinit();

    const records = [_]Record{
        .{.uuid = 965564, .name = "Kernel task", .priority = 3},
        .{.uuid = 233255, .name = "User task", .priority = 1},
        .{.uuid = 7657, .name = "Background task", .priority = 0},
        .{.uuid = 457745, .name = "System task", .priority = 2},
    };

    for (&records) |*v| {
        try heap.push(v, v.priority);
    }

    std.log.warn("Starting test:", .{});
    var cur: ?*const Record = heap.pop();
    var expected: i32 = 3;
    while (cur != null) {
        std.log.warn("Record: {s}", .{cur.?.*.name});
        std.log.warn("expected priority: {} actual priority: {}", .{expected, cur.?.*.priority});
        try std.testing.expect(cur.?.*.priority == expected);
        expected -= 1;
        cur = heap.pop();
    }
}