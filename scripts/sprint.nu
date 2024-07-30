#!/usr/bin/env -S nu --stdin

let notesync_dir = $env.HOME | path join truehome/notesync
let sprint_dir = $notesync_dir | path join meta/sprints
let sprint_files = ls $sprint_dir
let symlink_partial_path = "truehome/notesync/sprint"
let symlink_path = $env.Home | path join $symlink_partial_path

def main [] {
  print "Subcommands: new, ls"
}

def "main new" [] {
  let new_sprint_date_formatted = date now | format date %Y.%m.%d
  let new_sprint_filename = [sprint-, $new_sprint_date_formatted] | str join
  let new_sprint_path = $sprint_dir | path join $new_sprint_filename

  if ($new_sprint_path | path exists) {
    print $"Sprint file already exists for ($new_sprint_date_formatted)."
    print "Exiting."
    exit 1
  }

  if ($sprint_files | length) == 0 {
    print $"Creating ($new_sprint_filename)..."
    touch $new_sprint_path
  } else {
    let last_sprint_record = $sprint_files | last
    let last_sprint_path = $last_sprint_record.name
    let last_sprint_filename = $last_sprint_path | path basename

    print $"Copying ($last_sprint_filename) to ($new_sprint_filename)..."
    cp $last_sprint_path $new_sprint_path

    if ($symlink_path | path exists) {
      if ($symlink_path | path type) != symlink {
        print $"File at ($symlink_partial_path) is not a symlink."
        print "Exiting."
        exit 1
      }
      print $"Unlinking ($symlink_partial_path)..."
      rm $symlink_path
    }
  }

  print $"Pointing ($symlink_partial_path) to ($new_sprint_filename)..."
  ln -s $new_sprint_path $symlink_path
}

def "main ls" [] {
  ls -l $sprint_dir
}






