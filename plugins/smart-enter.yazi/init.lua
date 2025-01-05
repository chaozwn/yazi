--- @sync entry

local function setup(self, opts) self.open_multi = opts.open_multi end

local function isInList(list, value)
  for i, v in ipairs(list) do
    if v == value then return true end
  end
  return false
end

local exclude = { ".DS_Store" }

local function entry(self)
  local h = cx.active.current.hovered
  if h then
    if h.cha.is_dir then
      ya.manager_emit("enter", { hovered = not self.open_multi })
    else
      if not isInList(exclude, tostring(h.name)) then
        ya.manager_emit("open", { hovered = not self.open_multi })
      else
        ya.manager_emit("shell", { block = true, confirm = true, "nvim" })
      end
    end
  end
end

return { entry = entry, setup = setup }
