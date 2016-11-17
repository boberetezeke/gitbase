module ApplicationHelper
  def quote_single_quotes(str)
    str.gsub(/'/, "\\\\'")
  end
end
