class Movie < BaseModel
  include Ohm::Timestamps

  attribute :title
  attribute :date
  attribute :description
  attribute :notify, lambda { |value| !!value }

  reference :user, :User

  attribute :liker_count
  attribute :hater_count

  set :likers, :User
  set :haters, :User
end

