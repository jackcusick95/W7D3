
class User < ApplicationRecord

    validates :username, :password_digest, :session_token, presence: true
    validates :password, length: { minimum: 6, allow_nil: true}

    has_many :goals,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Goal

    attr_reader :password 

    after_initialize :ensure_session_token


    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user 
        else
            return nil
        end
    end

    def generate_unique_session_token
        token = SecureRandom.urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
        self.save!
        self.session_token 
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

end 