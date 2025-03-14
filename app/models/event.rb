# == Schema Information
#
# Table name: events
#
#  id              :bigint           not null, primary key
#  description     :text
#  end_time        :datetime
#  image           :string
#  location        :string
#  start_time      :datetime
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_events_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
class Event < ApplicationRecord
  belongs_to :organization
  
  validates :title, :start_time, :location, presence: true
end
