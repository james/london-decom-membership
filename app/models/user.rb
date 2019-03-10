class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  attr_accessor :last_sign_in_ip, :current_sign_in_ip

  validates :name, presence: true
  validates :accept_principles, acceptance: true
  validates :accept_participation, acceptance: true
  validates :membership_code, presence: true

  before_validation :set_membership_code, on: :create

  has_one :membership_code, dependent: :destroy

  def membership_number
    membership_code.code
  end

  private

  def set_membership_code
    self.membership_code = MembershipCode.available.first || MembershipCode.create!
  end
end
