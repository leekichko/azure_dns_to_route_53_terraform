module CNameRecord
  def process_CNAME_record(resource)
    resource["type"] = "CNAME"
    resource["records"] = build_CNAME_records(resource["properties"])
    resource
  end

  def build_CNAME_records(properties) 
    records = []
    if properties["CNAMERecord"]
      record = properties["CNAMERecord"]
      records.push(record["cname"])             
    end
    records
  end
end