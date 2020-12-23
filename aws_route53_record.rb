require_relative './record_types/a_record'
include ARecord
require_relative './record_types/c_name_record'
include CNameRecord
require_relative './record_types/txt_record'
include TxtRecord
require_relative './record_types/srv_record'
include SrvRecord
require_relative './record_types/mx_record'
include MxRecord

class AWSRoute53Record

  @domain
  @ttl   
  def initialize(domain, ttl = 300)
    @domain = domain
    @ttl = ttl
  end

  def render(resource)
    flat_resource = process(resource)
    if flat_resource
      template_to_render(flat_resource)
    else
      nil
    end
  end

  private

  def template_to_render(flat_resource) 
    {
      "resource": {
        "aws_route53_record": {
          "#{flat_resource["subdomain"]}": {
            "zone_id": '${aws_route53_zone.primary.zone_id}',
            "name": flat_resource["name"],
            "type": flat_resource["type"],
            "ttl": flat_resource["ttl"],
            "records": flat_resource["records"]
          }
        }
      }
    }
  end

  def process(resource)
    set_name(resource, @domain)
    set_ttl(resource)

    if resource["type"] == "Microsoft.Network/dnszones/CNAME"
      process_CNAME_record(resource)
    elsif resource["type"] == "Microsoft.Network/dnszones/A"
      process_A_record(resource)
    elsif resource["type"] == "Microsoft.Network/dnszones/TXT"
      process_TXT_record(resource)
    elsif resource["type"] == "Microsoft.Network/dnszones/SRV"
      process_SRV_record(resource)
    elsif resource["type"] == "Microsoft.Network/dnszones/MX"
      process_MX_record(resource)
    elsif resource["type"] == "Microsoft.Network/dnszones/NS"
      nil
    elsif resource["type"] == "Microsoft.Network/dnszones/SOA"
      nil    
    elsif resource["type"] == "Microsoft.Network/dnszones"
      nil    
    end
  end

  def set_name(resource, domain)
    name = resource["name"]
    name = name.delete("/")
    subdomain = "#{name.split("'")[3]}"
    resource["name"] = "#{subdomain}#{domain}"
    resource["subdomain"] = subdomain
    resource
  end

  def set_ttl(resource)
    resource["ttl"] = @ttl  
  end
end