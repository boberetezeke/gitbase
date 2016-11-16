require 'rails_helper'

describe GitRepository::FileObject do
  let(:page_class_info) do
    double(:page_class_info, 
           git_module_name: 'module', 
           titleize: 'pages', 
           markdown_attributes: [:b])
  end

  let(:test_file_path) { Rails.root / "spec/test_files" }

  before do
    GitRepository.set_root_path(test_file_path)
  end

  after do
    FileUtils::remove_dir(test_file_path)
  end
  
  describe "#filename" do
    it "stores an object in the correct path" do
      page = double(:page, guid: 'abcd', class_info: page_class_info)
      expect(described_class.new(page).filename).to eq("module/pages/abcd.json")
    end
  end
  
  describe "#filename_for_markdown_attribute" do
    it "stores an object's markdown column in the correct path" do
      page = double(:page, guid: 'abcd', class_info: page_class_info)
      expect(described_class.new(page).filename_for_markdown_attribute('body')).to eq("module/pages/body/abcd.md")
    end
  end

  describe "#write" do
    it "writes the object to the relevant files" do
      page = double(:page, guid: 'abcd', class_info: page_class_info, as_json_without_markdown_attributes: {'a' => 1}, b: "2")
      file_object = described_class.new(page)
      expect(file_object.write)
      expect(JSON.parse(File.read(file_object.filename))).to eq(page.as_json_without_markdown_attributes)
      expect(File.read(file_object.filename_for_markdown_attribute(:b))).to eq(page.b)
    end
  end
end