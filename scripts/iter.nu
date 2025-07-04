#!/usr/bin/env -S nu --stdin

let notesync_partial_path = "truehome" | path join notesync
let notesync_dir = $env.HOME | path join $notesync_partial_path
let iteration_base_dir = $notesync_dir | path join meta iterations


# Manage iterations
def main [] {
  print "Subcommands: new, list (ls), push"
  print "Run `iter --help` for details."
}

# Create a new instance of a given iteration.
#
# If the iteration has a template, copies the template into the new instance.
# Otherwise, duplicates the previous instance.
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

# Test subcommands
def "main test" [a?: string, b?: string] {
  #print (check_files_equal $a $b)
  print "No test configured"
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

def stat [filename: string] {
  ls -l ($filename | path dirname) | where {($in.name | path basename) == ($filename | path basename)} | first
}

def update_symlink [src: string, dest: string] {
  if ($src | path exists) {
    if ($src | path type) != symlink {
      print $"  File at ($src) is not a symlink."
      print "  Exiting."
      exit 1
    }
    print $"  Unlinking ($src | path basename) from ($src | stat $in | get target | path basename)..."
    rm $src
  }

  print $"  Pointing ($src | path basename) to ($dest | path basename)..."
  ln -s $dest $src
}

# Shared logic
def new_iteration [name: string] {
  print $"Creating new ($name)"
  let iteration_dir = $iteration_base_dir | path join $name
  let new_date_formatted = date now | format date %Y.%m.%d
  let new_filename = [$name, -, $new_date_formatted] | str join
  let new_path = $iteration_dir | path join $new_filename
  let symlink_path = $notesync_dir | path join $name
  let symlink_path_last = $notesync_dir | path join $"($name)-last"
  let template_path = $iteration_base_dir | path join config templates $name
  let has_template = $template_path | path exists

  if ($new_path | path exists) {
    print $"  File already exists for ($new_date_formatted)."
    print "Exiting."
    exit 1
  }

  mkdir $iteration_dir
  let existing_files = ls $iteration_dir
  if ($has_template) {
    print $"  Copying templates/($name) to ($new_filename)..."
    cp $template_path $new_path
  } else if ($existing_files | length) == 0 {
    print $"  Creating ($new_filename)..."
    touch $new_path
  } else {
    let last_record = $existing_files | last
    let last_path = $last_record.name
    let last_filename = $last_path | path basename

    print $"  Copying ($last_filename) to ($new_filename)..."
    cp $last_path $new_path
  }

  update_symlink $symlink_path $new_path

  if ($existing_files | length) >= 1 {
    let previous_iter_path = $existing_files | last | get name
    if ($has_template and (check_files_equal $template_path $previous_iter_path)) {
      print $"  Removing ($previous_iter_path | path basename), it is unchanged from template..."
      rm $previous_iter_path
    } else {
      update_symlink $symlink_path_last $previous_iter_path
    }
  }
}

def check_files_equal [a: string, b: string]: nothing -> bool {
  try {
    ^cmp -s $a $b
  } catch {
    return false
  }
  return true
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
  ls -s $iteration_base_dir | where type == dir | get name | filter {$in != 'test' and $in != 'config'}
}




