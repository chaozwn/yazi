local KEYS_LABLE = {
	"j", "f", "d", "k", "l", "h", "g", "a", "s", "o", "i", "e", "u", "n", "c", "m", "r",
	"p", "b", "t", "w", "v", "x", "y", "q", "z"
}

local INPUT_KEY = {
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
	"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2"
, "3", "4", "5", "6", "7", "8", "9", "-", "_", ".", "<Esc>"
}

local INPUT_CANDS = {
	{ on = "a" }, { on = "b" }, { on = "c" }, { on = "d" }, { on = "e" },
	{ on = "f" }, { on = "g" }, { on = "h" }, { on = "i" }, { on = "j" },
	{ on = "k" }, { on = "l" }, { on = "m" }, { on = "n" }, { on = "o" },
	{ on = "p" }, { on = "q" }, { on = "r" }, { on = "s" }, { on = "t" },
	{ on = "u" }, { on = "v" }, { on = "w" }, { on = "x" }, { on = "y" },
	{ on = "z" }, { on = "0" }, { on = "1" }, { on = "2" }, { on = "3" },
	{ on = "4" }, { on = "5" }, { on = "6" }, { on = "7" }, { on = "8" },
	{ on = "9" }, { on = "-" }, { on = "_" }, { on = "." }, { on = "<Esc>" }
}


local function get_match_position(name, find_str)
	if find_str == "" or find_str == nil then
		return nil, nil
	end

	local startPos, endPos = {}, {}
	local startp, endp

	-- record all match start position and end position
	-- startPos[index],endPos[index],sanme index corresponde a search result
	endp = 0
	while true do
		startp, endp = string.find(string.lower(name), find_str, endp + 1)
		if not startp then
			break
		end
		table.insert(startPos, startp)
		table.insert(endPos, endp)
	end

	if #startPos > 0 then
		return startPos, endPos
	else
		return nil, nil
	end
end

-- apply search result to show
local set_match_lable = ya.sync(function(state, url, name, file)
	local span = {}
	local key = {}
	local i = 1
	if state.match[url].key and #state.match[url].key > 0 then
		key = state.match[url].key
	end

	local startPos = state.match[url].startPos
	local endPos = state.match[url].endPos

	if file:is_hovered() then
		table.insert(span, ui.Span(name:sub(1, startPos[1] - 1)))
	else
		table.insert(span, ui.Span(name:sub(1, startPos[1] - 1)):fg(state.opt_unmatch_fg))
	end

	while i <= #startPos do
		table.insert(span, ui.Span(name:sub(startPos[i], endPos[i])):fg(state.opt_match_str_fg):bg(state.opt_match_str_bg))
		if i <= #key then
			table.insert(span, ui.Span(key[i]):fg(state.opt_lable_fg):bg(state.opt_lable_bg))
		end
		if i + 1 <= #startPos then
			if file:is_hovered() then
				table.insert(span, ui.Span(name:sub(endPos[i] + 1, startPos[i + 1] - 1)))
			else
				table.insert(span, ui.Span(name:sub(endPos[i] + 1, startPos[i + 1] - 1)):fg(state.opt_unmatch_fg))
			end
		end
		i = i + 1
	end

	if file:is_hovered() then
		table.insert(span, ui.Span(name:sub(endPos[i - 1] + 1, #name)))
	else
		table.insert(span, ui.Span(name:sub(endPos[i - 1] + 1, #name)):fg(state.opt_unmatch_fg))
	end

	return span
end)

-- update the match data after input a str
local update_match_table = ya.sync(function(state, folder, find_str)
	if not folder then
		return
	end

	local i

	for _, file in ipairs(folder.window) do
		local name = file.name:gsub("\r", "?", 1)
		local url = tostring(file.url)
		local startPos, endPos = get_match_position(name, find_str)
		if startPos then
			state.match[url] = {
				key = {},
				startPos = startPos,
				endPos = endPos,
			}
			i = 1
			while i <= #startPos do -- the next char of match string can't be used as lable for supporing further search
				state.next_char[#state.next_char + 1] = string.lower(name:sub(endPos[i] + 1, endPos[i] + 1))
				i = i + 1
			end
		end
	end
end)

local record_match_file = ya.sync(function(state, find_str)
	local exist_match = false

	if state.match == nil then
		state.match = {}
	end

	if state.next_char == nil then
		state.next_char = {}
	end

	-- record match file from current window
	update_match_table(Folder:by_kind(Folder.CURRENT), find_str)

	-- record match file from parent window
	update_match_table(Folder:by_kind(Folder.PARENT), find_str)

	-- record match file from preview window
	update_match_table(Folder:by_kind(Folder.PREVIEW), find_str)

	-- get valid key list (KEYS_LABLE but exclude state.next_char table)
	local valid_lable = {}
	for _, value in ipairs(KEYS_LABLE) do
		local found = false
		for _, v in ipairs(state.next_char) do
			if value == v then
				found = true
				break
			end
		end

		if not found then
			table.insert(valid_lable, value)
		end
	end

	-- assign valid key to each match file
	local i = 1
	local j
	for url, _ in pairs(state.match) do
		exist_match = true
		j = 1
		while j <= #state.match[url].startPos do -- some file may match multi position
			table.insert(state.match[url].key, valid_lable[i])
			i = i + 1
			j = j + 1
		end
	end

	-- flush page
	ya.manager_emit("peek", { force = true })
	ya.render()

	return exist_match
end)

local toggle_ui = ya.sync(function(st)
	if st.highlights or st.mode then
		File.highlights, Status.mode, st.highlights, st.mode = st.highlights, st.mode, nil, nil
		ya.manager_emit("peek", { force = true })
		ya.render()
		return
	end

	st.highlights, st.mode = File.highlights, Status.mode

	File.highlights = function(self, file)
		local span = {}
		local name = file.name:gsub("\r", "?", 1)
		local url = tostring(file.url)

		if st.match and st.match[url] then
			span = set_match_lable(url, name, file)
		elseif file:is_hovered() then
			span = ui.Span(name)
		else
			span = ui.Span(name):fg(st.opt_unmatch_fg)
		end

		return span
	end

	Status.mode = function(self)
		local style = self.style()
		return ui.Line {
			ui.Span(THEME.status.separator_open):fg(style.bg),
			ui.Span(" SJ-" .. tostring(cx.active.mode):upper() .. " "):style(style),
		}
	end

	ya.manager_emit("peek", { force = true })
end)


local set_target_str = ya.sync(function(state, input_str)
	local is_match_key = false
	local final_input_str = input_str:sub(#input_str, #input_str)
	local found = false
	if state.match then
		for url, _ in pairs(state.match) do
			for _, value in ipairs(state.match[url].key) do
				if value == final_input_str then
					found = true
					break
				end
			end

			if found then -- if the last str match is a lable key, not a search char, toggle jump action
				ya.manager_emit(url:match("[/\\]$") and "cd" or "reveal", { url })
				is_match_key = true
				break
			end
		end
	end

	-- clears the previously calculated data when input change
	state.match = nil
	state.next_char = nil

	-- calculate match data
	local exist_match = record_match_file(input_str)

	-- apply match data to render
	ya.render()

	if is_match_key or not exist_match then
		return true -- hit lable key or no match file
	else
		return false
	end
end)

local clear_state_str = ya.sync(function(state)
	state.match = nil
	state.next_char = nil
	ya.render()
end)

local set_opts_default = ya.sync(function(state)
	if (state.opt_unmatch_fg == nil) then
		state.opt_unmatch_fg = "#928374"
	end
	if (state.opt_match_str_fg == nil) then
		state.opt_match_str_fg = "#000000"
	end
	if (state.opt_match_str_bg == nil) then
		state.opt_match_str_bg = "#73AC3A"
	end
	if (state.opt_lable_fg == nil) then
		state.opt_lable_fg = "#EADFC8"
	end
	if (state.opt_lable_bg == nil) then
		state.opt_lable_bg = "#BA603D"
	end
end)


return {
	setup = function(state, opts)
		-- Save the user configuration to the plugin's state
		if (opts ~= nil and opts.opt_unmatch_fg ~= nil) then
			state.opt_unmatch_fg = opts.opt_unmatch_fg
		end
		if (opts ~= nil and opts.opt_match_str_fg ~= nil) then
			state.opt_match_str_fg = opts.opt_match_str_fg
		end
		if (opts ~= nil and opts.opt_match_str_bg ~= nil) then
			state.opt_match_str_bg = opts.opt_match_str_bg
		end
		if (opts ~= nil and opts.opt_lable_fg ~= nil) then
			state.opt_lable_fg = opts.opt_lable_fg
		end
		if (opts ~= nil and opts.opt_lable_bg ~= nil) then
			state.opt_lable_bg = opts.opt_lable_bg
		end
	end,

	entry = function(_, args)
		set_opts_default()

		toggle_ui()

		local input_str = ""
		while true do
			local cand = ya.which { cands = INPUT_CANDS, silent = true }
			if cand == nil then
				goto continue
			end

			if INPUT_KEY[cand] == "<Esc>" then
				break
			end

			input_str = input_str .. INPUT_KEY[cand]

			local want_exit = set_target_str(input_str)
			if want_exit then
				break
			end
			::continue::
		end

		clear_state_str()
		toggle_ui()
	end
}
