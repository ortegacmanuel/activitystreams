module ActivityStreams
  class Link < Base

    attr_optional(
      :id,
      :name,
      :href,
      :hreflang,
      :mediaType,
      :rel,
      :height,
      :width
    )

    def validate_attributes!
      super
    end
  end
end
