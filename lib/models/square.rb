class Square < ActiveRecord::Base
  belongs_to :board

  def location
    "#{x}#{y}"
  end
end
