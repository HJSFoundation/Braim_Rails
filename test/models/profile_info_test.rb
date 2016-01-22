# == Schema Information
#
# Table name: profile_infos
#
#  id         :integer          not null, primary key
#  birthday   :date
#  genre      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'test_helper'

class ProfileInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
