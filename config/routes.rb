Rails.application.routes.draw do
  Spree::Core::Engine.add_routes do
    # Admin authentication
    devise_for(
      Spree.admin_user_class.model_name.singular_route_key,
      class_name: Spree.admin_user_class.to_s,
      controllers: {
        sessions: 'spree/admin/user_sessions',
        passwords: 'spree/admin/user_passwords'
      },
      skip: :registrations,
      path: :admin_user,
      router_name: :spree
    )
  end
  Spree::Core::Engine.add_routes do
    # Storefront routes
    scope '(:locale)', locale: /#{Spree.available_locales.join('|')}/, defaults: { locale: nil } do
      devise_for(
        Spree.user_class.model_name.singular_route_key,
        class_name: Spree.user_class.to_s,
        path: :user,
        controllers: {
          sessions: 'spree/user_sessions',
          passwords: 'spree/user_passwords',
          registrations: 'spree/user_registrations'
        },
        router_name: :spree
      )
    end
  end
  # Spree provides Admin (/admin) and Storefront (/) via the engine.
  mount Spree::Core::Engine, at: '/'
end
