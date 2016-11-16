class Page < ActiveRecord::Base
  
  after_save do
    write_to_git(self)
  end

  def write_to_git(object)
    GitRepository::FileObject.new(object).save
  end
end