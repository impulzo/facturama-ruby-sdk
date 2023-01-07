# frozen_string_literal: true

require_relative '../models/exception/facturama_exception'
require_relative '../models/connection_info'

module Facturama
  module Services
    class HttpService
      def initialize(connection_info, uri_resource)
        @connection_info = connection_info
        @uri_resource = uri_resource
      end

      def get(args = '')
        res = RestClient::Request.new(
          method: :get,
          url: url(args),
          user: @connection_info.facturama_user,
          password: @connection_info.facturama_password,
          headers: { accept: :json,
                     content_type: :json,
                     user_agent: '' }
        )

        executor(res)
      end

      def post(message, args = '')
        json = message.to_json

        res = RestClient::Request.new(
          method: :post,
          url: url(args),
          user: @connection_info.facturama_user,
          password: @connection_info.facturama_password,
          payload: json,
          headers: { content_type: :json }
        )

        executor(res)
      end

      def put(message, args = '')
        json = message.to_json

        res = RestClient::Request.new(
          method: :put,
          url: url(args),
          user: @connection_info.facturama_user,
          password: @connection_info.facturama_password,
          payload: json,
          headers: { accept: :json,
                     content_type: :json }
        )

        executor(res)
      end

      def delete(args = '')
        res = RestClient::Request.new(
          method: :delete,
          url: url(args),
          user: @connection_info.facturama_user,
          password: @connection_info.facturama_password,
          headers: { accept: :json,
                     content_type: :json }
        )

        executor(res)
      end

      private

      def url(args = '')
        slash = ''
        args = args.to_s

        if args.length.positive?
          slash = args =~ /^\?/ ? '' : '/'
        end

        @uri_resource = "/#{@uri_resource}" if @uri_resource.length.positive?

        @connection_info.uri_base + @uri_resource + slash + args
      end

      # Executa la peticion y procesa la respuesta decodificando el JSON a un Hash y
      # Conviriendo los errores de la API en FacturamaExceptions
      def executor(request)
        response = request.execute

        JSON[response] if response.code != 204 && response.body != '' # 204 = sin contenido

      # exceptions
      rescue Exception => e
        case e.class.name
        when 'RestClient::NotFound'
          raise FacturamaException, '404 NotFound: Elemento no encontrado'
        when 'RestClient::BadRequest'
          json_response = JSON[e.response]
          model_state = json_response['ModelState']
          unless model_state.nil?
            model_state = json_response['ModelState'].map { |k, v| [k.to_s, v] }
            fact_exception = FacturamaException.new(json_response['Message'])
          end

          fact_exception = FacturamaException.new(json_response['Message'], model_state)
          raise(fact_exception)
        else
          raise StandardError, e.response
        end
      end
    end
  end
end
