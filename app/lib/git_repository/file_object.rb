require 'fileutils'

module GitRepository
  class FileObject
    def initialize(object)
      @object = object
    end
    
    def filename
      "#{root_path}/#{@object.guid}.json"
    end

    def filename_for_markdown_attribute(attr_name)
      "#{root_path}/#{attr_name}/#{@object.guid}.md"
    end

    def write
      write_file(filename, @object.as_json_without_markdown_attributes.to_json)
      @object.class_info.markdown_attributes.each do |attr_name|
        write_file(filename_for_markdown_attribute(attr_name), @object.send(attr_name))
      end
    end

    private

    def write_file(filename, data)
      create_dirs_for(filename)
      File.open(filename, "w") do |f|
        f.write(data)
      end
    end

    def create_dirs_for(filename)
      FileUtils.mkpath(filename.split(/\//)[0..-2].join('/'))
    end

    def root_path
      klass = @object.class_info
      GitRepository.root_path / klass.git_module_name / klass.titleize
    end
  end
end