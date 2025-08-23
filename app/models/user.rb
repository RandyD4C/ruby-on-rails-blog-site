class User < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :dob, presence: true
    validate :dob_validations

    private
        def dob_validations
            if dob == nil
                return
            end

            if dob > Date.today
                errors.add(:dob, "can't exceed current date")
            end

            age = Date.today.year - dob.year

            # ensure the user is not too young or too old
            if age < 12
                errors.add(:dob, "must be at least 12 years old")
            elsif age > 100
                errors.add(:dob, "must be less than 100 years old")
            end
        end
end
