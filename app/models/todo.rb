require 'active_record'

class Todo < ActiveRecord::Base
  validates :title, presence: true, uniqueness: { case_insensitive: true }
end
