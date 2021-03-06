class User < ActiveRecord::Base
  before_save :ensure_authentication_token
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   
  belongs_to :condo
  has_many :join_events, :dependent => :destroy
  has_many :events, dependent: :destroy
  has_many :bookings
  has_many :facilities , dependent: :destroy
  has_many :feedbacks

  has_many :user_roles , dependent: :destroy
  has_many :roles , :through => :user_roles
  has_many :permissions , :through => :roles
  has_many :functions, :through => :permissions

  has_many :privileges, dependent: :destroy
  has_many :privilege_user, dependent: :destroy

  has_many :course_users, dependent: :destroy

  has_many :group_chats
  has_many :group_chat_members
  scope :antiad ,-> {
joins("LEFT JOIN `user_roles` ON `user_roles`.`user_id` = `users`.`id` LEFT JOIN `roles` ON `roles`.`id` = `user_roles`.`role_id`").where("roles.role_name is null or role_name != 'Admin' ").group("users.id")
}


#setup avartar
  has_attached_file :avatar, :styles => {:medium => "200x200#", :small => "140x140#", :big => "250x250#"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar,
                       :size => {:in => 0..3.megabytes},
                       :content_type => {:content_type => /^image\/(jpeg|png|gif|tiff)$/}
  validates :email, uniqueness: true

  validates :username, presence: true
  # validates :phone, presence: true
 # validates :postal_code, presence: true
 # validates :enquiry, presence: true
#  validates :username, length: {minimum: 4, maximun: 14}
#  validates :username, uniqueness: true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where([" lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end
   def self.search(search=nil)
    if search
    where('email LIKE ?', "%#{search}%")
    else
    where('1 = 1')
    end
    end


  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.find_by(authentication_token: token)
    end
  end


end

