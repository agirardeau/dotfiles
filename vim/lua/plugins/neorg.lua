require('neorg').setup({
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/truehome/notesync/neorg-test",
          work = "~/truehome/notes",
        },
      },
    },
    ["core.norg.qol.toc"] = {
      config = {
        close_split_on_jump = true,
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "notes",
      },
    },
    ["core.norg.journal"] = {
      config = {
        workspace = "notes",
        journal_folder = "journal",
      },
    },
    ["core.integrations.telescope"] = {},
  },
})
