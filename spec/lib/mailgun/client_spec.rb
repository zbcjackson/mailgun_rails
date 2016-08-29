require 'spec_helper'
require 'mailgun/client'

describe Mailgun::Client do
  let(:client){Mailgun::Client.new(:some_api_key, :some_domain)}
  let(:log){double(info: 0, debug: 0, error: 0)}
  before {Mailgun::Logging.logger = log}

  describe "#send_message" do
    it 'should make a POST rest request passing the parameters to the mailgun end point' do
      expected_url = "https://api:some_api_key@api.mailgun.net/v3/some_domain/messages"
      RestClient.should_receive(:post).with(expected_url, foo: :bar)
      client.send_message foo: :bar
    end
    it 'log response for errors' do
      allow(RestClient).to receive(:post).and_raise(RestClient::ServerBrokeConnection)
      client.send_message foo: :bar
      log.should have_received(:error).with('Server broke connection')
      log.should have_received(:error).with(nil)
    end
  end
end
