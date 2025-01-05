--- @sync entry
local hover_url = ya.sync(function() return tostring(cx.active.current.hovered.url) end)

local function isInList(list, value)
  for i, v in ipairs(list) do
    if v == value then return true end
  end
  return false
end

local exclude = { ".DS_Store" }

return {
  entry = function(_, job)
    local h = cx.active.current.hovered
    if h then
      if h.cha.is_dir then
        ya.manager_emit("shell", { block = true, confirm = true, "nvim" })
      else
        local absolute_path = tostring(hover_url())
        if not isInList(exclude, tostring(h.name)) then
          ya.manager_emit("open", { ya.quote(absolute_path) })
        else
          ya.manager_emit("shell", { block = true, confirm = true, "nvim" })
        end
      end
    end
  end,
}
