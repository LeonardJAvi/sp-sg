# User Model
class User < ActiveRecord::Base
  include ActivityHistory

  before_save :create_permalink, if: :new_record?
  rolify
  # validates_presence_of :name, :last_name, :identification, :email, :password, :password_confirmation, :birthdate, :phone, :address 
  after_create :role_automatic
  after_create :user_rol
  after_create :send_mail_create
  after_update :send_mail_update
  # has_many :posts, dependent: :destroy relation posts

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def rol
    roles.first.name
  end

  def role_automatic
    self.role_ids = "1"
  end

  def user_rol
    if self.id == 1
      self.role_ids = '1'
    else
      self.role_ids = '2'
    end
  end
  #para el correo
  def after_rol=(value)
    @create_rol = value
  end
  def before_rol=(value)
    @before_rol = value
  end
  
  def send_mail_create
    UserMailer.rol(self).deliver_later
  end

 def send_mail_update
  unless @before_rol == @after_rol
      UserMailer.rol(self).deliver_later
  end
 end

  # Get the page number that the object belongs to
  def page(order = :id)
    ((self.class.order(order => :desc)
      .pluck(order).index(send(order)) + 1)
        .to_f / self.class.default_per_page).ceil
  end

  def self.search_field
    :name_or_username_or_email_cont
  end

  private

  def create_permalink
    self.permalink = name.downcase.parameterize + '-' + SecureRandom.hex(4)
  end
end
