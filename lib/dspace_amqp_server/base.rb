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