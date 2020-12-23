module TxtRecord
  def process_TXT_record(resource)
    resource["type"] = "TXT"
    resource["records"] = build_TXT_records(resource["properties"])
    resource
  end

  def build_TXT_records(properties) 
    records = []
    properties["TXTRecords"].each do |record|
      records = records + record["value"]
    end
    records
  end
end