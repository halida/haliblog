require 'sqlite3'
require 'data_mapper'
require 'date'
require 'tempfile'

DataMapper.setup(:default, "sqlite3:tmp/data.db")

class Article
  include DataMapper::Resource
  property :id,    Serial
  property :title, String
  property :raw_content, Text
  property :content, Text

  property :created, DateTime
  property :updated, DateTime

#  before :save, :update_content

  def S5?
    false
  end

  def show_title
    @title.gsub('_', ' ')
  end

  def get_content
    if (@content.nil? or @content.empty?) 
      @content = create_content self.raw_content
    end
    @content
  end

end

def create_content source
  file = Tempfile.new('content')
  file.write(source)
  file.flush.close
  cmd = "python #{File.dirname(__FILE__)}/rst.py #{file.path}"
  content = `#{cmd}`
  file.unlink
  content
end

DataMapper.finalize
DataMapper.auto_upgrade!

