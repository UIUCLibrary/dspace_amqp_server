# DspaceAmqpServer

This is a messaging system based on Advanced Message Queuing Protocol (AMQP), which is an open standard application layer protocol for message-oriented middleware. It works by setting up an AMQP client that receives JSON objects from providers. Then it downloads and unzips the file and save it as a bag so that it can be passed to the packager.  


## Usage

To test how the AMQP server receives message, do the following.
1. To start the server, run ./dspace_amqp_server start
This will build the connection to receive message on port 5672. The connection status of the server and the queue ideals_to_va can be checked on http://localhost:15672/#/queues. 
2. Run new_task.rb from the "test" folder. This will set up a connection, send a test data to the queue va_to_ideals.
3. To stop the server, run the command ./dspace_amqp_server stop 
The interaction can be confirmed from the dspace_amqp_server.log file under the log folder.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/dspace_amqp_server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
