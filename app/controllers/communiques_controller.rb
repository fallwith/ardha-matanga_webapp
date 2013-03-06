require 'redis'
require 'yaml'
require 'rack/utils'
class CommuniquesController < ApplicationController
  def flash
    begin
      config = YAML.load_file(File.join(Rails.root, 'config', 'webapp.yml'))['redis']
      rhandle = Redis.new(host: config['hostname'], port: config['port'], thread_safe: true, timeout: 5)
      rhandle.client.connect
      render text: "thunder"
    rescue => e
      render text: "ERROR: #{Rack::Utils.escape_html(e.inspect)}"
    end
  end
end