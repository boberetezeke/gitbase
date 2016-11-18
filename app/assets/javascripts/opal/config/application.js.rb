require 'opal/view_models/fields/base_view_model'
require 'opal/view_models/fields/select_view_model'
require 'opal/view_models/fields/static_view_model'
require 'opal/view_models/fields/text_base_view_model'
require 'opal/view_models/fields/text_view_model'
require 'opal/views/fields/_display'
require 'opal/views/fields/_select'
require 'opal/views/fields/_static'
require 'opal/views/fields/_text'

require 'opal/views/table/_table'
require 'opal/views/table/_row'
require 'opal/views/table/_header_column'
require 'opal/views/table/_header'
require 'opal/view_models/table/header_column'
require 'opal/view_models/table/action_column_view_model'
require 'opal/view_models/table/row_view_model'
require 'opal/view_models/table/header_view_model'
require 'opal/view_models/table/table_view_model'

require 'opal/view_models/pages_table/row_view_model'
require 'opal/view_models/pages_table/table_view_model'
require 'opal/views/pages_table/_table'
require 'opal/views/pages/index'
require 'opal/views/pages/show'

require 'opal/view_models/pages/index_view_model'

class MyApplication < Application
  def initialize
    super

    @store.init_new_table("pages")
  end

  def view_root
     "opal/views"
  end

   def get_store
    ActiveRecord::MemoryStore.new
  end

  # this part is needed because of a bug in the opal version I am using
  def launch(initial_objects_json, session={})
    super(initial_objects_json, session, Proc.new{
      puts "in launch"
    })
  end
end

MyApplication.routes.draw do
  resources :pages
end

# this is needed for broken haml implementation
class Template
  class OutputBuffer
    def buffer
      self
    end

    def <<(str)
      @buffer << str
    end
  end
end
