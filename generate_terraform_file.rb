#!/usr/bin/env ruby

require 'json'
require './aws_route53_zone.rb'
require './aws_route53_record.rb'

file_path = ARGV[0] || './template.json' 
output_path = ARGV[1] || './records.tf.json'

class TransformToTerraform

    @file_path
    @output_path
    @domain
    @terraform_resources
    def initialize(file_path, output_path)
      @file_path = file_path
      @output_path = output_path
      process
    end

    def process
      json = read_azure_json_file
      
      add_route_zone(json)
      add_records(json)
            
      write_terraform_json_file
    end

    def add_route_zone(json)
      route53_zone = AWSRoute53Zone.new(json)
      @domain = route53_zone.domain
      @terraform_resources = [route53_zone.render]
    end

    def add_records(json)
      route53_record = AWSRoute53Record.new(@domain)
      json["resources"].each do |resource|
        terraform_record = route53_record.render(resource)
        if terraform_record
          @terraform_resources.push(terraform_record) 
        end
      end      
    end

    def read_azure_json_file
      file = File.read(@file_path)
      JSON.parse(file)
    end

    def write_terraform_json_file
      File.write(@output_path, JSON.dump(@terraform_resources))
      puts JSON.pretty_generate(@terraform_resources)  
    end

end

TransformToTerraform.new(file_path, output_path)