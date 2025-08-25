# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'application#home', as: :home

  %w[assets debts incomes outgoes charges discharges recipients].each do |thing|
    get "#{thing}/:id/delete", to: "#{thing}#delete", as: "delete_#{thing.singularize}"
  end

  %w[assets debts].each do |thing|
    get "#{thing}/:id/reconcile", to: "#{thing}#reconcile", as: "reconcile_#{thing.singularize}"
  end

  get 'transfer', to: 'assets#transfer', as: :transfer
  post 'transfer', to: 'assets#post_transfer', as: :post_transfer

  get 'payment', to: 'debts#payment', as: :payment
  post 'payment', to: 'debts#post_payment', as: :post_payment

  shallow do
    resources :assets do
      resources :incomes
      resources :outgoes
    end
    resources :debts do
      resources :charges
      resources :discharges
    end
  end

  resources :recipients
end
