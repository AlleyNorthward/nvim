# 简介
@author 巷北  
@time 2025.11.16 21:25  

想了想, 还是将api都给记录下来吧, 这样方便后续查找. 目前这算是什么呢?各种接口什么的, 确实看不太明确, 楞头去写, 也十分难办.不过好在, 之前写了很多的python, 有了很多动态语言的编写基础和理念, 所以运用在lua语言这里, 也是手到擒来的. 关于vim相关的api, 很多基础的东西, 我都打算是自己先去了解一下, 看看这种插件编写的基本方法是什么, 后续能更好的自定义vim.

目前而言呢, 也只能从ai问起, 从中了解neovim相关的api, 然后先明确, 我能干什么, 并且借此深入学习一下lua相关的语法, 日积月累, 最后能达到自己主动配置的目的.

- [Debug方式](#Debug方式)
- [获取光标位置](#获取光标位置)
- [获取文件类型](#获取文件类型)

## Debug方式
主要是有两个文件, 一个是init.lua, 另一个是debugging.lua文件.debugging文件中编写对应实现逻辑, init.lua中一般捆绑按键, 没有固定的按键. 例子如下:
~~~lua
local map = vim.keymap.set
local opts = {noremap = true, silent = true}

local Debugging = require("debugging")
local _Debug = Debugging:new()
map("n", "<leader>/", function() _Debug:debugging() end, opts)
~~~
**注意** 这个绑定按键是我写注释绑定时的, 等后面要考虑怎么绑定.

## 获取光标位置
- `uppack(vim.api.nvim_win_get_cursor(0))` 这个是获取光标的函数.从1开始的.返回row, col
- `vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]` 这个是获取光标当前行的内容.
- `vim.fn.col(".")`这个是获取col
- `vim.fn.getline(".")` 这个也是获取光标当前行的内容.
- `line:sub(1, col)` 获取光标前的内容(line是光标当前行的字符)

## 获取文件类型
- `vim.bo.filetype` 获取当前文件的类型


