require 'securerandom'

class Page < ActiveRecord::Base
  before_create { self.guid = SecureRandom.uuid }
  after_save { GitRepository::FileObject.new(self).write }

  def class_info
    OpenStruct.new({
      git_module_name: 'module',
      markdown_attributes: [:body],
      titleize: self.class.to_s.titleize
    })
  end

  def as_json_without_markdown_attributes
    {title: title}
  end
end