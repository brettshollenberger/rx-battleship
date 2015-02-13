require "active_support/concern"

module MassInsertable
  extend ActiveSupport::Concern
  
  included do
    extend ClassMethods
  end

  module ClassMethods
    def mass_insert(&block)
      records = block.call
      keys    = records.first.keys.join(", ")
      values  = records.map do |record|
        "(#{record.values.map { |v| "'#{v}'" }.join(", ")})"
      end.join(", ")

      bulk_insert = <<-SQL
        INSERT INTO #{table_name} (#{keys}) VALUES #{values};
      SQL

      ActiveRecord::Base.connection.execute bulk_insert
    end
  end
end
