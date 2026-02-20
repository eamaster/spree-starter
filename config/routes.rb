Rails.application.routes.draw do
  # Spree provides Admin (/admin) and Storefront (/) via the engine.
  mount Spree::Core::Engine, at: '/'
end
