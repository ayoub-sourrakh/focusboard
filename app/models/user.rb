class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  # Active Storage for profile photo
  has_one_attached :photo

  # Validations (only for new records or when updating these fields)
  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }, on: :create
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }, on: :create
  validates :birth_date, presence: true, on: :create
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-z0-9._]+\z/, message: "only allows lowercase letters, numbers, dots and underscores" }
  validate :birth_date_cannot_be_in_the_future, if: :birth_date_changed?

  # Callbacks
  before_validation :generate_username, on: :create, if: -> { username.blank? }

  # Helper method for full name
  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}".strip
    else
      email.split("@").first.capitalize
    end
  end

  # Helper method for initials
  def initials
    if first_name.present? && last_name.present?
      "#{first_name.first}#{last_name.first}".upcase
    else
      email[0..1].upcase
    end
  end

  private

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

  def generate_username
    if first_name.present? && last_name.present?
      # Generate username from first_name.last_name
      base_username = "#{first_name}.#{last_name}".downcase.gsub(/[^a-z0-9._]/, "")
    else
      # Generate random username
      base_username = "user#{SecureRandom.hex(4)}"
    end

    # Ensure uniqueness
    username_candidate = base_username
    counter = 1
    while User.exists?(username: username_candidate)
      username_candidate = "#{base_username}#{counter}"
      counter += 1
    end

    self.username = username_candidate
  end
end
