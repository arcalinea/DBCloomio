class Note < ActiveRecord::Base

  scope :published, -> { where(is_deleted: false) }

  belongs_to :user
  belongs_to :group
	
  delegate :name, to: :user, prefix: :user

  def published_at
    created_at
  end

  # def author
  #   User.find(self.user_id)
  # end

  # def author_name
  #   author.try(:name)
  # end

  def author_id
    user_id
  end

end
