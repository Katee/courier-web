FactoryGirl.define do
  factory :drop do
    # find a random locatation or create one if there are none
    location_id { Location.all.sort_by{ rand }.first.id || FactoryGirl.create(:location).id }

    # drops are usually created as part of making a job
    job_id 1
  end
end
