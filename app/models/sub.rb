# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :string           not null
#  user_id     :integer          not null
#
class Sub < ApplicationRecord
    validates :title, :description, :user_id, presence: true

    belongs_to :moderator,
    foreign_key: :user_id,
    class_name: :User

end
