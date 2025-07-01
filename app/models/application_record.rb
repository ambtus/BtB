# frozen_string_literal: true

# available in every AR model
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
