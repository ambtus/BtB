# frozen_string_literal: true

class AddReconciledToOutgoes < ActiveRecord::Migration[8.0]
  def change
    add_column :outgoes, :reconciled, :boolean, default: false, null: false
  end
end
