# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  birthday   :date
#  gender     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Profile < ActiveRecord::Base
  belongs_to :user
  enum gender: [:male,:female]
end
