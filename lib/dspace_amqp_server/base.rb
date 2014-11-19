# hack to put the run and log dirs at the base of the app
module SimpleAmqpServer
  class Base < Object

    BASE_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    def log_directory
      File.join(BASE_DIR, 'log')
    end

    def log_file
      File.join(BASE_DIR, 'log', "#{config.server_name}.log")
    end

    def run_directory
      File.join(BASE_DIR, 'run')
    end

    def request_directory
      File.join(BASE_DIR, 'run', "#{config.server_name}_active_requests")
    end
  end
end

module DspaceAmqpServer
  class Base < SimpleAmqpServer::Base

    def handle_ideals_deposit_request(interaction)
      self.logger.info 'Handling upload...'
      location = interaction.request_parameter(:location)
      correlation_id = interaction.request_parameter(:correlation_id)

      self.logger.info "location: #{location}"
      self.logger.info "correlation_id: #{correlation_id}"

      receiver = Receiver.new(location: location, correlation_id: correlation_id, logger: logger)
      bag = receiver.download_bag
      ideals_handle = "2142/5131"

      interaction.succeed(ideals_handle: [ideals_handle])
    end
  end
end