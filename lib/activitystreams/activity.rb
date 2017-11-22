module ActivityStreams
  class Activity < Base
    include ExtProperties

    attr_required :actor
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
      :instrument,
      :image,
      :inReplyTo,
      :location,
      :object,
      :origin,
      :preview,
      :published,
      :replies,
      :result,
      :startTime,
      :summary,
      :summaryMap,
      :tag,
      :target,
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
      _type_ = if self.class.superclass == Activity
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
      #validate_attribute! :attachment, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :attributedTo, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :audience, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :context, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :generator, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :icon, [ActivityStreams::Object::Image, ActivityStreams::Link]
      #validate_attribute! :image, [ActivityStreams::Object::Image, ActivityStreams::Link]
      #validate_attribute! :inReplyTo, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :location, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :preview, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :replies, [ActivityStreams::Collection]
      #validate_attribute! :tag, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :to, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :bto, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :cc, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :bcc, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :actor, VALID_ACTOR_TYPES
      #validate_attribute! :object, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :target, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :origin, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :result, [ActivityStreams::Object, ActivityStreams::Link]
      #validate_attribute! :instrument, [ActivityStreams::Object, ActivityStreams::Link]

      # TODO:
      # - name MUST NOT include HTML
      # - duration MUST be expressed as an xsd:duration
      #   example: 5 seconds is represented as "PT5S"
    end
  end
end

Dir[File.dirname(__FILE__) + '/activity/*.rb'].each do |file|
  require file
end
