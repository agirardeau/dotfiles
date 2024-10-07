#!/usr/bin/env -S nu --stdin

let notesync_dir = $env.HOME | path join truehome notesync
let docket_dir = $notesync_dir | path join meta dockets
let docket_files = ls $docket_dir
let symlink_partial_path = "truehome/notesync/docket"
let symlink_path = $env.Home | path join $symlink_partial_path

let docket_info = {
  name: docket
  content_dir: ($notesync_dir | path join meta dockets)
}

let sprint_info = {
  name: sprint
  content_dir: ($notesync_dir | path join meta sprints)
}


def main [] {
  print "Subcommands: docket, sprint"
  print "Run `meta --help` for details."
}

# Docket commands
def "main docket" [] {
  print "Subcommands: new, ls, dir"
  print "Run `meta docket --help` for details."
}

def "main docket new" [] {
  new_iteration $docket_info
}

def "main docket ls" [] {
  list_iterations $docket_info
}

def "main docket dir" [] {
  print $docket_info.content_dir
}

# Sprint commands
def "main sprint" [] {
  print "Subcommands: new, ls, dir"
  print "Run `meta sprint --help` for details."
}

def "main sprint new" [] {
  new_iteration $sprint_info
}

def "main sprint ls" [] {
  list_iterations $sprint_info
}

def "main sprint dir" [] {
  print $sprint_info.content_dir
}

# Shared logic
def new_iteration [info] {
  let new_date_formatted = date now | format date %Y.%m.%d
  let new_filename = [$info.name, -, $new_date_formatted] | str join
  let new_path = $info.content_dir | path join $new_filename
  let symlink_path = $notesync_dir | path join $info.name

  if ($new_path | path exists) {
    print $"File already exists for ($new_date_formatted)."
    print "Exiting."
    exit 1
  }

  let existing_files = ls $info.content_dir
  if ($existing_files | length) == 0 {
    print $"Creating ($new_filename)..."
    touch $new_path
  } else {
    let last_record = $existing_files | last
    let last_path = $last_record.name
    let last_filename = $last_path | path basename

    print $"Copying ($last_filename) to ($new_filename)..."
    cp $last_path $new_path

    if ($symlink_path | path exists) {
      if ($symlink_path | path type) != symlink {
        print $"File at ($symlink_partial_path) is not a symlink."
        print "Exiting."
        exit 1
      }
      print $"Unlinking ($info.name) from ($last_filename)..."
      rm $symlink_path
    }
  }

  print $"Pointing ($info.name) to ($new_filename)..."
  ln -s $new_path $symlink_path
}

def "list_iterations" [info] {
  ls -l $info.content_dir
}





