class User < ActiveRecord::Base
  if RUBY_ENGINE != 'opal'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  end

  def admin?
    true
  end
end
