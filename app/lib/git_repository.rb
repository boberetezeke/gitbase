module GitRepository
  def self.root_path
    @root_path
  end

  def self.set_root_path(path)
    @root_path = Pathname.new(path)
  end
end