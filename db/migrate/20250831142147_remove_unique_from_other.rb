# frozen_string_literal: true

class RemoveUniqueFromOther < ActiveRecord::Migration[8.0]
  def change
    remove_index :others, column: :name, unique: true
    add_index :others, %i[type name], unique: true, name: 'index_others_on_type_and_name'
  end
end
