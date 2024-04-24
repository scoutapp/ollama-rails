require 'ollama-ai'
require 'base64'

class OllamaaiController < ApplicationController
  before_action :create_client

    def create_client
      @client = Ollama.new(
        credentials: { address: 'http://localhost:11434' },
        options: { server_sent_events: true }
      )
    end

    def index
      @result = @client.generate(
        { model: 'llama2',
          prompt: 'Hello llama2!',
          stream: false }
      )
      return @result
    end

    def generate
      @result = @client.generate(
      { model: 'llama2',
        prompt: 'Hello from Ruby on Rails!' }
      )
      render template: "ollamaai/index"
    end

    def chat
      @result = @client.chat(
        { model: 'llama2',
          messages: [
            { role: 'user', content: 'Hi! My name is Ruby on Rails Developer' }
          ] }
      ) do |event, raw|
          # This outputs to stdout but @result also get's the response events
          puts event
        end
      render template: "ollamaai/index"
    end

    def embeddings
      @result = @client.embeddings(
        { model: 'llama2',
          prompt: 'Hello!' }
      )
      render template: "ollamaai/index"
    end

    def model_create
      @result = @client.create(
        { name: 'mickey',
          modelfile: "FROM llama2\nSYSTEM You are Mickey Mouse from Disney." }
      ) do |event, raw|
        puts event
      end
      render template: "ollamaai/index"
    end

    def model_use
     @result = @client.generate(
      { model: params[:name],
        prompt: 'Hi! Who are you?' }
      ) do |event, raw|
          print event['response']
        end
        render template: "ollamaai/index"
    end

    def model_show
      @result = @client.show(
        { name: 'llama2' }
      )
      render template: "ollamaai/index"
    end

    def image
      @result = @client.generate(
      { model: 'llava',
        prompt: 'Please describe this image.',
        images: [Base64.strict_encode64(File.read('public/piano.jpg'))] }
      ) do |event, raw|
          print event['response']
        end
        render template: "ollamaai/index"
    end

end
