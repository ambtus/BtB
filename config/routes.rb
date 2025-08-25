# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'application#home', as: :home

  %i[asset debt income outgo charge discharge recipient].each do |thing|
    get "#{thing}s/:id/delete", to: "#{thing}s#delete", as: "delete_#{thing}"
  end

  %i[asset debt].each do |thing|
    get "#{thing}s/:id/reconcile", to: "#{thing}s#reconcile", as: "reconcile_#{thing}"
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
