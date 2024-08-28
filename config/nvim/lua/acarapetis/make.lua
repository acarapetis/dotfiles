local async_make = function()
  local mnotify = require("mini.notify")
  local lines = {""}
  local makeprg = vim.o.makeprg
  if not makeprg then
    local id = mnotify.add("no makeprg for this buffer")
    vim.defer_fn(function() mnotify.remove(id) end, 2000)
    return
  end

  local cmd = vim.fn.expandcmd(makeprg)

  local function on_event(job_id, data, event)
    if event == "stdout" or event == "stderr" then
      if data then
        vim.list_extend(lines, data)
      end
    end

    if event == "exit" then
      local id = mnotify.add("make returned " .. tostring(data))
      vim.defer_fn(function() mnotify.remove(id) end, 2000)
      vim.fn.setqflist({}, " ", {
        title = cmd,
        lines = lines,
        efm = vim.o.errorformat,
      })
      vim.api.nvim_command("doautocmd QuickFixCmdPost")
    end
  end

  local job_id =
    vim.fn.jobstart(
    cmd,
    {
      on_stderr = on_event,
      on_stdout = on_event,
      on_exit = on_event,
      stdout_buffered = true,
      stderr_buffered = true,
    }
  )
end

vim.keymap.set("n", "<leader>m", async_make)
