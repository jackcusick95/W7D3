class Goal < ApplicationRecord

    validates_presence_of :title, :details, :user_id
    validates :title, uniqueness: { scope: :user_id}

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

end 