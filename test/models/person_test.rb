# == Schema Information
#
# Table name: people
#
#  id                  :integer          not null, primary key
#  birthday            :date
#  country             :string
#  desc_ext            :string
#  email               :string
#  name                :string
#  photo_ext           :string
#  rating              :integer
#  subscribe_to_emails :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
