require_relative "./concerns/mass_insertable"

class Square < ActiveRecord::Base
  include MassInsertable

  belongs_to :board
  belongs_to :ship

  def location
    "#{x}#{y}"
  end

  def empty?
    ship_id.nil?
  end
  
  def taken?
    !empty?
  end
  
  def state
    if taken?
      return "hit" if guessed?
      return "taken"
    else
      return "miss" if guessed?
      return "empty"
    end
  end

  def guess
    update(guessed: true)
  end
end
