#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require "uri"
require 'json'
require 'open-uri'
require 'fileutils'
require 'rubygems'
require 'zip'
require 'bagit'

require 'simple_amqp_server'

module DspaceAmqpServer
  class Receiver
    
    attr_accessor :location, :correlation_id, :logger
    
    def initialize(args ={})
      self.logger = args[:logger]
      self.logger.info 'Initializing Receiver...'
      self.location = args[:location]
      self.correlation_id = args[:correlation_id]
    end
  
    # Download the bag, store it on the file system, return the path to the bag
    def download_bag
      self.logger.info "Downloading bag to data/#{correlation_id}..."
      #download and save the zip file 
      bag_path = "data/#{correlation_id}"
      FileUtils::mkdir_p bag_path
  
      open(location){|f|
        File.open("#{bag_path}/download.zip", "wb") do |file|
          file.puts f.read
        end
      }

      self.logger.info "Unzipping bag to #{bag_path}/download.zip..."
      
      #unzip the downloaded file
      Zip::File.open("#{bag_path}/download.zip") { |zip_file|
         zip_file.each { |f|
           f_path=File.join("#{bag_path}", f.name)
           FileUtils.mkdir_p(File.dirname(f_path))
           zip_file.extract(f, f_path) unless File.exist?(f_path)
         }
      }
    
      # delete the zip file; we don't need it any more
      File.delete "#{bag_path}/download.zip"
    
      # return new bag 
      BagIt::Bag.new bag_path
    end
  end
end