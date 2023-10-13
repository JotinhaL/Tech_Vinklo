REGEX_EMAIL = /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+\z/

class User < ApplicationRecord
    validates :email, format: {with: REGEX_EMAIL}
    validates :phone, numericality: { only_integer: true}
    validates :phone, length: {in: 10..14}
    validate :cpf_valid?

    def cpf_valid?
      return if CPF.valid?(cpf)
  
      errors.add(:cpf)
    end
end

