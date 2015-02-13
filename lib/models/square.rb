require_relative "./concerns/mass_insertable"

class Square < ActiveRecord::Base
  include MassInsertable

  belongs_to :board

  def location
    "#{x}#{y}"
  end
end
