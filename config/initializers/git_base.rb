Rails.application.config.to_prepare do
  GitRepository.set_root_path(Rails.root / 'git_files')
end
