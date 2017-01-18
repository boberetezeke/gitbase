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

class ViewModel
  include PathHandler
  include UrlHelper
end

# this is necessary so that Rails.application works as it calls Application.instance
MyApplication.instance

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
