module Glass
  module Config
    class << self
      attr_accessor :app_name
      attr_accessor :models
      attr_accessor :format
      attr_accessor :mounted_at
      attr_accessor :routes
      attr_accessor :adapter

      def reset
        @app_name = ''
        @mounted_at = '/api'
        @models = []
        @format = :json
        @routes = {}
      end

      def models_with_routes
        @models.each do |model|
          @routes[model.downcase.to_sym] = create_routes(model)
        end
      end

      def pluralize_downcase(model)
        model.pluralize.downcase
      end

      def capitalize_singularize(model)
        model.capitalize.singularize
      end

      def create_routes(model)
        model_scope = pluralize_downcase(model)
        model_name = capitalize_singularize(model)

        return_routes(model_name, model_scope)
      end

      def return_routes(model_name, model_scope)
        return {
            "index"   => { "type" => "get",   "path" => "/#{model_scope}"      },
            "show"    => { "type" => "get",   "path" => "/#{model_scope}/:id"  },
            "create"  => { "type" => "post",  "path" => "/#{model_scope}"      },
            "update"  => { "type" => "put",   "path" => "/#{model_scope}/:id"  },
            "destroy" => { "type" => "delete","path" => "/#{model_scope}/:id"  } }
      end

      def setup
        models_with_routes
      end

    end

    self.reset
  end
end
