module ActivityStreams
  class Base
    include AttrRequired, AttrOptional, Validator
    CONTEXT = 'https://www.w3.org/ns/activitystreams'

    attr_optional(:context)

    def initialize(attributes = {})
      (required_attributes + optional_attributes).each do |_attr_|
        self.send :"#{_attr_}=", attributes[_attr_]
      end
      validate_attributes!
      self.context ||= CONTEXT
    end

    def validate_attributes!
      attr_missing!
    end

    def as_json(options = {}, toplevel = true)
      hash = (required_attributes + optional_attributes).inject({}) do |hash, _attr_|
        _value_ = self.send _attr_
        hash.merge!(
          _attr_.to_s.camelize(:lower).to_sym => case _value_
          when Symbol, Addressable::URI
            _value_.to_s
          when Array
            _value_.collect { |v| v.to_s }
          when Time
            _value_.iso8601
          when ActivityStreams::Base
            _value_.as_json({}, false)
          else
            _value_
          end
        )
      end.delete_if do |k,v|
        v.blank?
      end
      # Storing the value of the context attribute in a local variable
      context = hash.delete :context
      # Adding @context attribute only if top-level object
      Hash[toplevel ? {:@context => context} : {} ].merge!(hash)
    end
  end
end
