# frozen_string_literal: true

class AddReconciledToIncomes < ActiveRecord::Migration[8.0]
  def change
    add_column :incomes, :reconciled, :boolean, default: false, null: false
  end
end
