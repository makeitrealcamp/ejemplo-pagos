# == Schema Information
#
# Table name: charges
#
#  id             :bigint(8)        not null, primary key
#  uid            :string(50)
#  status         :integer          default("created")
#  payment_method :integer          default("unknown")
#  amount         :decimal(, )
#  error_message  :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  response_data  :jsonb
#

require 'test_helper'

class ChargeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
