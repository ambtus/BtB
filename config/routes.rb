# frozen_string_literal: true

Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'application#home', as: :home

  %w[assets debts incomes outgoes charges discharges others].each do |thing|
    get "#{thing}/:id/delete", to: "#{thing}#delete", as: "delete_#{thing.singularize}"
  end

  %w[incomes outgoes charges discharges].each do |thing|
    post "#{thing}/:id/reconcile", to: "#{thing}#reconcile", as: "reconcile_#{thing.singularize}"
    post "#{thing}/:id/unreconcile", to: "#{thing}#unreconcile", as: "unreconcile_#{thing.singularize}"
  end

  get 'payoff', to: 'application#payoff', as: :payoff
  post 'payoff', to: 'application#post_payoff', as: :post_payoff

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

  resources :others
end
