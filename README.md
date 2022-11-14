# cubelang - a hata project
## Goal
- to make it ergonomic to describe geometry and to manipulate it over time
  * if it's easy to say it should be easy to do
- practically useful for video games and simulations
- strong type system, which is locally configurable w.r.t. strictness
  * "yolo flag"
- useful error messages and easy to inspect

## Current sketch

```cubelang
n cube i = n rect i i
3 cube of width	3
-- returns
--  3 cube of width
--              3
--
2 rect of width height	2 3
-- returns
--  2 rect of width	height
--              2  	  3
--
2 rect 3 2
-- returns
--  2 rect 3 2
--
3 3 matrix of $ i j -> i	2j	i+j
-- returns
--  3⨯3 matrix of   j,i |    1       2       3
--                  ----|------------------------
--                  1   |  1 2 3   2 2 4   3 2 5
--                  2   |  1 4 5   2 4 6   3 4 7
--                  3   |  1 6 7   2 6 8   3 6 9
--
```
