class Report < ActiveRecord::Base
  belongs_to :reportee, class_name: 'User'
  belongs_to :reported_event, class_name: 'Event'
end
