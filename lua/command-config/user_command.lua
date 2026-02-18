-- 自定义命令

-- 查看lua路径
vim.api.nvim_create_user_command(
  "MyShowPath",
  function()
    vim.notify(vim.inspect(package.path), vim.log.levels.INFO)
  end,
  {}
)

vim.api.nvim_create_user_command(
  'SelectEmoji',
  function()
    local emoji_categories = {
      'Choose an option:',
      'face_1',
      'hand_2',
      'title_3',
      "show_all_4",
      "print_all_5"
    }

    local choice = vim.fn.inputlist(emoji_categories)
    if choice <= 0 or choice >= #emoji_categories then
      vim.notify("无效选择项.", vim.log.levels.ERROR)
      return
    end

    local others = {}
    vim.cmd('redraw!')
    if choice == 1 then
      others = {
        'Choose an option:',
        "smile_1", "wink_2", "blush_3", "grin_4", "sweat_smile_5",
        "joy_6", "relaxed_7", "kiss_8", "open_mouth_9", "grinning_10",
        "sunglasses_11", "thinking_12"
      }
    elseif choice == 2 then
      others = {
        'Choose an option:',
        "thumbsup_1", "clap_2", "v_3", "ok_hand_4", "fist_5", "pray_6",
        "point_up_7", "point_right_8", "point_left_9", "wave_10", "muscle_11",
        "open_hands_12", "crossed_fingers_13"
      }
    elseif choice == 3 then
      others = {
        'Choose an option:',
        "rocket_1", "star_2", "rainbow_3", "computer_4", "iphone_5",
        "sun_with_face_6", "snowflake_7", "snowman_8", "zap_9", "bus_10",
        "herb_11", "cactus_12", "bamboo_13", "cookie_14", "panda_face_15"
      }
    elseif choice == 4 then
      local totals = {
        "smile", "wink", "blush", "grin", "sweat_smile", "joy", "relaxed",
        "kiss", "open_mouth", "grinning", "sunglasses", "thinking", "thumbsup",
        "clap", "v", "ok_hand", "fist", "pray", "point_up", "point_right",
        "point_left", "wave", "muscle", "open_hands", "crossed_fingers",
        "rocket", "star", "rainbow", "computer", "iphone", "sun_with_face",
        "snowflake", "snowman", "zap", "bus", "herb", "cactus", "bamboo",
        "cookie", "panda_face"
      }
      local row_limit = 7
      local lines = {}
      for i = 1, #totals, row_limit do
        local row = {}
        for j = i, math.min(i + row_limit - 1, #totals) do
          table.insert(row, ":" .. totals[j] .. ":")
        end
        table.insert(lines, table.concat(row, " "))
      end

      local emoji_str = table.concat(lines, "\n")
      vim.notify(emoji_str, vim.log.levels.INFO)
      return
    elseif choice == 5 then
      local totals = {
        "smile", "wink", "blush", "grin", "sweat_smile", "joy", "relaxed",
        "kiss", "open_mouth", "grinning", "sunglasses", "thinking", "thumbsup",
        "clap", "v", "ok_hand", "fist", "pray", "point_up", "point_right",
        "point_left", "wave", "muscle", "open_hands", "crossed_fingers",
        "rocket", "star", "rainbow", "computer", "iphone", "sun_with_face",
        "snowflake", "snowman", "zap", "bus", "herb", "cactus", "bamboo",
        "cookie", "panda_face"
      }

      local row_limit = 7
      local lines = {}
      for i = 1, #totals, row_limit do
        local row = {}
        for j = i, math.min(i + row_limit - 1, #totals) do
          table.insert(row, ":" .. totals[j] .. ":")
        end
        table.insert(lines, table.concat(row, " "))
      end

      for _, line in ipairs(lines) do
        vim.api.nvim_put({ line }, 'c', true, true)
      end
      return
    else
      vim.notify("无效选择项.", vim.log.levels.ERROR)
      return
    end

    local another_choice = vim.fn.inputlist(others)
    if another_choice <= 0 or another_choice >= #others then
      vim.notify("无效选择项.", vim.log.levels.ERROR)
      return
    end

    local selected_emoji = others[another_choice + 1]
    local emoji_name = string.gsub(selected_emoji, "_%d+$", "")

    local emoji_ = ":" .. emoji_name .. ":"
    vim.api.nvim_put({ emoji_ }, 'c', true, true)
  end,
  {}
)

vim.api.nvim_create_user_command(
  'WriteAuthorAndTime',
  function(opts)
    local pram = opts.args ~= "" and opts.args or "";

    local emsp = "&emsp;"
    local author = "@author 巷北"
    local time = "@time "
    local real_time = os.date("%Y-%m-%d %H:%M:%S")

    local lines
    if pram == "" then
      lines = {
        string.format("%s%s%s  ", emsp, emsp, author),
        string.format("%s%s%s%s  ", emsp, emsp, time, real_time),
        ""
      }
    else
      lines = {
        string.format("%s  ", author),
        string.format("%s%s  ", time, real_time),
        ""
      }
    end

    vim.api.nvim_put(lines, 'c', true, true)
  end,
  { nargs = "?" }
)

vim.api.nvim_create_user_command(
  'GenerateCodeBlock',
  function(opts)
    local pram = opts.args
    local block = "~~~"
    local lines = {
      string.format("%s%s", block, pram),
      "",
      block,
    }
    vim.api.nvim_put(lines, 'c', true, true)

    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(0, { row - 1, 0 })
    vim.cmd("startinsert")
  end,
  { nargs = 1 }
)
