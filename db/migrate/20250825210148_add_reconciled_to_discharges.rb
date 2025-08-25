# frozen_string_literal: true

class AddReconciledToDischarges < ActiveRecord::Migration[8.0]
  def change
    add_column :discharges, :reconciled, :boolean, default: false, null: false
  end
end
