def run(str)
  puts "running: #{str}"
  system(str)
end

def copy(from, to)
  puts "copying from '#{from}' to '#{to}'"
  File.copy(from, to)
end

def chdir
  puts "changing to dir: #{dir}"
  Dir.chdir(dir)
end

namespace :simplemde do
  task :compile => :environment do
    simple_mde_dir = Rails.root.join('vendor/simplemde-markdown-editor')
    chdir(simple_mde_dir) do
      run("gulp browserify:debug")
    end

    copy(simple_mde_dir.join('debug/simplemde.debug.js'), Rails.root.join("vendor/assets/javascripts/simplemde.js"))

    # for some reason, we have to use the minified CSS or it acts really funky
    # copy(simple_mde_dir.join('src/css/simplemde.css'), Rails.root.join("vendor/assets/stylesheets/simplemde.css"))
    copy(simple_mde_dir.join('dist/simplemde.min.css'), Rails.root.join("vendor/assets/stylesheets/simplemde.css"))
  end
end