# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  last_name              :string
#  country                :string
#

FactoryGirl.define  do
  factory :user do
    name "Bob"
    last_name "Tester"
    country "colombia"
    password "12345678"
    sequence(:email) {|n| "test_email#{n}@example.com"}
    factory :user_with_profile do
      profile 
    end
  end
end
