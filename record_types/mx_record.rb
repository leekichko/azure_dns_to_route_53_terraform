module MxRecord
  def process_MX_record(resource)
    # as per aws documentation.  Not sure if its suppose to be the record 
    # 10 mailserver.example.com.
    resource["type"] = "MX"
    resource["records"] = build_MX_Records(resource["properties"])
    resource
  end

  def build_MX_Records(properties) 
    records = []
    if properties["MXRecords"]
      properties["MXRecords"].each do |record|
        records.push("#{record["preference"]} #{record["exchange"]}.")        
      end
    end
    records
  end
end