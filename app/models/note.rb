class Note < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	# example:
	# delegate :name, to: :user, prefix: :user

end
