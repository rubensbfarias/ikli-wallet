class User < ApplicationRecord
    has_secure_password

    def password=(new_password)
        self.password_digest = BCrypt::Password.create(new_password)
    end
end
