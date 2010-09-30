module Gowalla
  class GenericRequest

    def initialize(symbol, arguments, connection)
      parse_resources(symbol.to_s)
      parse_arguments(arguments)
      @connection = connection
    end

    def execute
      response = @connection.get do |req|
        req.url(request_url, query)
      end

      format_response(response)
    end

    private

    def parse_resources(method_name)
      @resource, @child_resource = method_name.split('_', 2)
      @resource = @resource.pluralize
    end

    def parse_arguments(arguments)
      @resource_id = arguments.shift if !arguments.first.is_a?(Hash)
      @query = arguments.shift if arguments.first.is_a?(Hash)
    end

    def request_url
      url = "/#{@resource}"
      url << "/#{@resource_id}" if @resource_id
      url << "/#{@child_resource}" if @child_resource
      url
    end

    def query
      @query || {}
    end

    def format_response(response)
      collection = @resource if !@resource_id
      collection = @child_resource if @child_resource
      if collection
        response.body.send(collection_node_name(collection))
      else
        response.body
      end
    end

    def collection_node_name(resource)
      case resource
        when 'events', 'photos' then :activity
        when 'friends' then :users
        when 'visited_spots_urls' then :urls
        when 'categories' then :spot_categories
        else resource.to_sym
      end
    end

  end
end