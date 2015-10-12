class Note < ActiveRecord::Base

  scope :published, -> { where(is_deleted: false) }

  belongs_to :user
  belongs_to :group
  # belongs_to :author, foreign_key: 'user_id'
	# example:
	# delegate :name, to: :user, prefix: :user

  def published_at
    created_at
  end

  # def author_name
  #   author.try(:name)
  # end

  def author_id
    user_id
  end

end
