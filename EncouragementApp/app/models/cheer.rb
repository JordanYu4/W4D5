# == Schema Information
#
# Table name: cheers
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  comment_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cheer < ApplicationRecord
end
