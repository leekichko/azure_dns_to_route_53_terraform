module SrvRecord
  def process_SRV_record(resource)
    # as per aws documentation.  Not sure if its suppose to be the record 
    # [priority] [weight] [port] [server host name]
    resource["type"] = "SRV"
    resource["records"] = build_SRV_records(resource["properties"])
    resource
  end

  def build_SRV_records(properties) 
    records = []
    properties["SRVRecords"].each do |record|
      records.push("#{record["priority"]} #{record["weight"]} #{record["port"]} #{record["target"]}.")
    end
    records
  end
end