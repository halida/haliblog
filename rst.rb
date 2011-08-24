require 'rbst'

def rst data
  begin
    data = RbST.new(data).to_html
  rescue
  end
  data
end
