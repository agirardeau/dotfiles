#!/usr/bin/env -S nu --stdin

let notesync_partial_path = "truehome" | path join notesync
let notesync_dir = $env.HOME | path join $notesync_partial_path
let iteration_base_dir = $notesync_dir | path join meta iterations


def main [] {
  print "Subcommands: new, list (ls), push"
  print "Run `iter --help` for details."
}

def "main new" [name: string] {
  if ($name == all) {
    get_iteration_type_names | each {|name|
      new_iteration $name
    }
  } else {
    new_iteration $name
  }
  null  # don't print output of if block (empty list for `each` command)
}

def "main ls" [name?: string] {
  main list $name
}

def "main list" [name?: string] {
  if ($name == null) {
    ls $iteration_base_dir | where type == dir
  } else if ($name == all) {
    get_iteration_type_names | each {|name|
      list_iterations $name
    }
  } else {
    list_iterations $name
  }
  null
}

def "main push" [name?: string] {
  if ($name == all) {
    get_iteration_type_names | each {|name|
      push_iteration $name
    }
  } else {
    push_iteration $name
  }
  null
}

# Shared logic
def new_iteration [name: string] {
  let iteration_dir = $iteration_base_dir | path join $name
  let new_date_formatted = date now | format date %Y.%m.%d
  let new_filename = [$name, -, $new_date_formatted] | str join
  let new_path = $iteration_dir | path join $new_filename
  let symlink_path = $notesync_dir | path join $name

  if ($new_path | path exists) {
    print $"File already exists for ($new_date_formatted)."
    print "Exiting."
    exit 1
  }

  let existing_files = ls $iteration_dir
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
        print $"File at ($notesync_partial_path | path join $name) is not a symlink."
        print "Exiting."
        exit 1
      }
      print $"Unlinking ($name) from ($last_filename)..."
      rm $symlink_path
    }
  }

  print $"Pointing ($name) to ($new_filename)..."
  ln -s $new_path $symlink_path
}

def list_iterations [name: string] {
  ls ($iteration_base_dir | path join $name) | print
  null
}

def push_iteration [name: string] {
  let symlink_path = $notesync_dir | path join $name
  let commit_path = $notesync_dir | path join $"($name).txt"
  print $"Pushing ($name) to ($name).txt"
  cat $symlink_path | save -f $commit_path
}

def get_iteration_type_names [] {
  ls -s $iteration_base_dir | where type == dir | get name
}




