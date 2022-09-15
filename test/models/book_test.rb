# == Schema Information
#
# Table name: books
#
#  id                 :bigint           not null, primary key
#  title              :string
#  content            :text
#  free               :boolean
#  page               :integer
#  isbn               :string
#  getBookOnAmazonUrl :string
#  getBookOnSiteTitle :string
#  getBookOnSiteUrl   :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  subtitle           :string
#  year               :integer
#  slug               :string
#  cover              :string
#  featured           :boolean
#
require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
