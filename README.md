# edsl: elaine's data structure library

A library for me to implement data structures and algorithms in Zig. No guarantees! But I like making succint, efficient code. Maybe you'll like it :)

I'll attempt to make the data structures / algorithms generic using comptime, and adopt Zig's conventions in the standard library.

Some things I will explore:
- Standard interview-style data structures
- Graph algorithms, from basic to exotic
- Persistent data structures, and functional algorithms.
- Data structures and algorithms for string processing and analysis.
- Exotic data structures as I encounter them, or as I find a use for them.

The idea is to have all of these in one place, for me to use in all my Zig projects as a supplement to the standard library. Perhaps I will supply build configuration 
options which turn off certain parts you don't need. TBD.

A battery of tests is provided which use the provided data structures & algorithms to solve leetcode and Project Euler problems. These will be subdivided depending
on the DS/algo used. Any problem which uses multiple concepts will be shoved in a "misc" directory. Perhaps a tagging system will be useful here. 

This readme is a WIP. Thanks for your interest <3