module ActivityStreams
  class Object < Base
    include ExtProperties

    attr_optional(
      :id,
      :type,
      :attachment,
      :attributedTo,
      :audience,
      :content,
      :contentMap,
      :name,
      :nameMap,
      :endTime,
      :generator,
      :icon,
      :image,
      :inReplyTo,
      :location,
      :preview,
      :published,
      :replies,
      :startTime,
      :summary,
      :summaryMap,
      :tag,
      :updated,
      :url,
      :to,
      :bto,
      :cc,
      :bcc,
      :mediaType,
      :duration
    )

    def initialize(attributes = {})
      _type_ = if self.class.superclass == Object
        self.class.name.demodulize.camelize
      end
      attributes = {:type => _type_}.merge(attributes)
      super attributes
    end

    def validate_attributes!
      super
      [:id, :type, :url].each do |_attr_|
        to_iri _attr_
      end
      [:startTime, :endTime, :published, :updated].each do |_attr_|
        to_time _attr_
      end
      validate_attribute! :attachment, [Object, ActivityStreams::Link]
      validate_attribute! :attributedTo, [Object, ActivityStreams::Link]
      validate_attribute! :audience, [Object, ActivityStreams::Link]
      validate_attribute! :context, [Object, ActivityStreams::Link]
      validate_attribute! :generator, [Object, ActivityStreams::Link]
      validate_attribute! :icon, [Image, ActivityStreams::Link]
      validate_attribute! :image, [Image, ActivityStreams::Link]
      validate_attribute! :inReplyTo, [Object, ActivityStreams::Link]
      validate_attribute! :location, [Object, ActivityStreams::Link]
      validate_attribute! :preview, [Object, ActivityStreams::Link]
      validate_attribute! :replies, [ActivityStreams::Collection]
      validate_attribute! :tag, [Object, ActivityStreams::Link]

      [:to, :bto, :cc, :bcc].each do |_attr_|
        to_iri _attr_, :arrayed!
      end

      # TODO:
      # - name MUST NOT include HTML
      # - duration MUST be expressed as an xsd:duration
      #   example: 5 seconds is represented as "PT5S"
    end

    def recommended_verbs
      self.class.recommended_verbs
    end

    def self.recommended_verbs(*verbs)
      @recommended_verbs ||= []
      @recommended_verbs += verbs
    end
  end
end

Dir[File.dirname(__FILE__) + '/object/*.rb'].each do |file|
  require file
end
