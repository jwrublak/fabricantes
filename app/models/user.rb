class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :omniauthable, 
         omniauth_providers: [:google_oauth2]
                    
	def self.find_for_google_oauth2(auth, _signed_in_resource = nil)
	  # Localize o usuário que já existe por provedor e o ID do usuário
	  user = User.where(provider: auth.provider, uid: auth.uid).first
	  unless user
	     # Localize o usuário que já existe por email
	     user = User.where(email: auth.info['email']).first
	     unless user
	        # O usuário não existe. Portanto, crie um novo usuário
	        logger.info auth.to_json
	        user = User.create(
	           uid: auth.uid,
	           first_name: auth.info.first_name,
	           last_name: auth.info.last_name,
	           name: auth.info.name,
	           gender: auth.extra.raw_info.gender,
	           email: auth.info.email,
	           password: Devise.friendly_token[0, 20],
	           provider: auth.provider,
	           image_url: auth.info.image)
	        logger.info("Criando Novo Usuário: #{user.to_json}")
	     end
	   end
	   user
	end
end
