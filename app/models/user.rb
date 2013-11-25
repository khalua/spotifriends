# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :text
#  last_name              :text
#  email                  :text
#  image                  :string(255)
#  is_admin               :boolean
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  logged_in_with_pwd     :boolean
#


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :logged_in_with_pwd
  attr_accessible :first_name, :last_name, :email, :image, :password, :password_confirmation, :group_ids
  has_and_belongs_to_many  :songs
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :votes
  # validates :first_name, :last_name, :email, :presence => true
  mount_uploader  :image, ImageUploader
  # has_secure_password

  def password_required?
    super if logged_in_with_pwd
  end

  def after_database_authentication
    self.update_attributes(:logged_in_with_pwd => true)
  end

  def after_password_reset
    self.update_attributes(:logged_in_with_pwd => true)
  end    

  def contests
    groups.map(&:contests).flatten
  end


end
