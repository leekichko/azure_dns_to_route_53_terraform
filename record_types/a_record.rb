module ARecord
  def process_A_record(resource)
    resource["type"] = "A"
    resource["records"] = build_A_records(resource["properties"])
    resource
  end

  def build_A_records(properties)
    records = []
    properties["ARecords"].each { |record| records.push(record["ipv4Address"])}
    records
  end
end