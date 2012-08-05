def range (min, max)
  rand * (max-min) + min
end

FactoryGirl.define do
  factory :location_update do
    courier_id 1

    lat {
      location = LocationUpdate.where(:courier_id => courier_id).last
      if location.nil?
        lat = 43.653227
      else
        lat = location.lat
      end
      lat - range(-0.002, 0.002)
    }
    lng {
      location = LocationUpdate.where(:courier_id => courier_id).last
      if location.nil?
        lng = -79.383184
      else
        lng = location.lng
      end
      lng - range(-0.002, 0.002)
    }

    at {DateTime.now}
  end
end
