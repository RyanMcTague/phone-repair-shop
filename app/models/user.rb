class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :phones

  state_machine :state, initial: :active do
    state :active
    state :closed

    event :activate do
      transition :closed => :active
    end

    event :close do
      transition :active => :closed
    end
  end
end
