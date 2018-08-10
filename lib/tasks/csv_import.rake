require 'csv'

namespace :data_import do
  desc "Import product data from the CSV file"
  task :csv, [:filename] => :environment do |task, args|
    csv_text = File.read(args[:filename])
    csv = CSV.parse(csv_text, headers: true)
    csv.each do |row|
      investigation = create_row_investigation(row)
      business = create_row_business(row)
      create_row_address(row, business[:id])
      InvestigationBusiness.create(business_id: business[:id], investigation_id: investigation[:id])
      create_row_activity(row, investigation[:id])
    end
  end
end

def create_row_investigation(row)
  Investigation.where(title:row["company_name"]).first_or_create(
      title: row["company_name"],
      source: Source.new(name: "CSV"),
      description: "",
      is_closed: false
  )
end

def create_row_business(row)
  filtered_row = row.to_hash.select { |k,_| Business.column_names.include? k }
  business = Business.create(filtered_row)
  business.update(source: Source.new(name: "CSV"))
  business
end

def create_row_address(row, business_id)
  filtered_row = row.to_hash.select { |k,_| Address.column_names.include? k }
  filtered_row[:business_id] = business_id
  address = Address.first_or_create(filtered_row)
  address.update(business_id: business_id, source: Source.new(name: "CSV"))
  address
end

def create_row_activity(row, investigation_id)
  filtered_row = row.to_hash.select { |k,_| Activity.column_names.include? k }
  filtered_row[:activity_type_id] = ActivityType.find_by(name: row.to_hash["activity_type"])[:id]
  activity = Activity.create(filtered_row)
  activity.update(investigation_id: investigation_id, source: Source.new(name: "CSV"))
  activity
end
