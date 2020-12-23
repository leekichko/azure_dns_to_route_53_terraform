class AWSRoute53Zone
  @domain   
  def initialize(azure_json)
    set_domain_name(azure_json)    
  end

  def domain 
    @domain
  end

  def render
    {
      "resource": {
        "aws_route53_zone": {
          "primary": {
            "name": @domain
          }
        }
      }
    }
  end

  private
  
  def set_domain_name(azure_json)
    azure_json["parameters"].each do |k, v|
      @domain = v["defaultValue"]
    end
  end
  
end
