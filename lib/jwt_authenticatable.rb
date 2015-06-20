require 'jwt_authenticatable/strategy'
require 'jwt_authenticatable/helpers'

Warden::Strategies.add :jwt_authenticatable, JwtAuthenticatable::Strategy

Devise.add_module :jwt_authenticatable,
  model: 'jwt_authenticatable/model',
  strategy: true,
  no_input: true
