# WARNING ABOUT GENERATED CODE
#
# This file is generated. See the contributing for info on making contributions:
# https://github.com/aws/aws-sdk-ruby/blob/master/CONTRIBUTING.md
#
# WARNING ABOUT GENERATED CODE

module Aws
  module SNS
    class PlatformEndpoint

      extend Aws::Deprecations

      # @overload def initialize(arn, options = {})
      #   @param [String] arn
      #   @option options [Client] :client
      # @overload def initialize(options = {})
      #   @option options [required, String] :arn
      #   @option options [Client] :client
      def initialize(*args)
        options = Hash === args.last ? args.pop.dup : {}
        @arn = extract_arn(args, options)
        @data = options.delete(:data)
        @client = options.delete(:client) || Client.new(options)
      end

      # @!group Read-Only Attributes

      # @return [String]
      def arn
        @arn
      end

      # Attributes include the following:
      #
      # * `CustomUserData` -- arbitrary user data to associate with the
      #   endpoint. Amazon SNS does not use this data. The data must be in
      #   UTF-8 format and less than 2KB.
      #
      # * `Enabled` -- flag that enables/disables delivery to the endpoint.
      #   Amazon SNS will set this to false when a notification service
      #   indicates to Amazon SNS that the endpoint is invalid. Users can set
      #   it back to true, typically after updating Token.
      #
      # * `Token` -- device token, also referred to as a registration id, for
      #   an app and mobile device. This is returned from the notification
      #   service when an app and mobile device are registered with the
      #   notification service.
      # @return [Hash<String,String>]
      def attributes
        data.attributes
      end

      # @!endgroup

      # @return [Client]
      def client
        @client
      end

      # Loads, or reloads {#data} for the current {PlatformEndpoint}.
      # Returns `self` making it possible to chain methods.
      #
      #     platform_endpoint.reload.data
      #
      # @return [self]
      def load
        resp = @client.get_endpoint_attributes(endpoint_arn: @arn)
        @data = resp.data
        self
      end
      alias :reload :load

      # @return [Types::GetEndpointAttributesResponse]
      #   Returns the data for this {PlatformEndpoint}. Calls
      #   {Client#get_endpoint_attributes} if {#data_loaded?} is `false`.
      def data
        load unless @data
        @data
      end

      # @return [Boolean]
      #   Returns `true` if this resource is loaded.  Accessing attributes or
      #   {#data} on an unloaded resource will trigger a call to {#load}.
      def data_loaded?
        !!@data
      end

      # @!group Actions

      # @example Request syntax with placeholder values
      #
      #   platform_endpoint.delete()
      # @param [Hash] options ({})
      # @return [EmptyStructure]
      def delete(options = {})
        options = options.merge(endpoint_arn: @arn)
        resp = @client.delete_endpoint(options)
        resp.data
      end

      # @example Request syntax with placeholder values
      #
      #   platform_endpoint.publish({
      #     topic_arn: "topicARN",
      #     phone_number: "String",
      #     message: "message", # required
      #     subject: "subject",
      #     message_structure: "messageStructure",
      #     message_attributes: {
      #       "String" => {
      #         data_type: "String", # required
      #         string_value: "String",
      #         binary_value: "data",
      #       },
      #     },
      #   })
      # @param [Hash] options ({})
      # @option options [String] :topic_arn
      #   The topic you want to publish to.
      #
      #   If you don't specify a value for the `TopicArn` parameter, you must
      #   specify a value for the `PhoneNumber` or `TargetArn` parameters.
      # @option options [String] :phone_number
      #   The phone number to which you want to deliver an SMS message. Use
      #   E.164 format.
      #
      #   If you don't specify a value for the `PhoneNumber` parameter, you
      #   must specify a value for the `TargetArn` or `TopicArn` parameters.
      # @option options [required, String] :message
      #   The message you want to send to the topic.
      #
      #   If you want to send the same message to all transport protocols,
      #   include the text of the message as a String value.
      #
      #   If you want to send different messages for each transport protocol,
      #   set the value of the `MessageStructure` parameter to `json` and use a
      #   JSON object for the `Message` parameter.
      #
      #   Constraints: Messages must be UTF-8 encoded strings at most 256 KB in
      #   size (262144 bytes, not 262144 characters).
      #
      #   JSON-specific constraints:
      #
      #   * Keys in the JSON object that correspond to supported transport
      #     protocols must have simple JSON string values.
      #
      #   * The values will be parsed (unescaped) before they are used in
      #     outgoing messages.
      #
      #   * Outbound notifications are JSON encoded (meaning that the characters
      #     will be reescaped for sending).
      #
      #   * Values have a minimum length of 0 (the empty string, "", is
      #     allowed).
      #
      #   * Values have a maximum length bounded by the overall message size
      #     (so, including multiple protocols may limit message sizes).
      #
      #   * Non-string values will cause the key to be ignored.
      #
      #   * Keys that do not correspond to supported transport protocols are
      #     ignored.
      #
      #   * Duplicate keys are not allowed.
      #
      #   * Failure to parse or validate any key or value in the message will
      #     cause the `Publish` call to return an error (no partial delivery).
      # @option options [String] :subject
      #   Optional parameter to be used as the "Subject" line when the message
      #   is delivered to email endpoints. This field will also be included, if
      #   present, in the standard JSON messages delivered to other endpoints.
      #
      #   Constraints: Subjects must be ASCII text that begins with a letter,
      #   number, or punctuation mark; must not include line breaks or control
      #   characters; and must be less than 100 characters long.
      # @option options [String] :message_structure
      #   Set `MessageStructure` to `json` if you want to send a different
      #   message for each protocol. For example, using one publish action, you
      #   can send a short message to your SMS subscribers and a longer message
      #   to your email subscribers. If you set `MessageStructure` to `json`,
      #   the value of the `Message` parameter must:
      #
      #   * be a syntactically valid JSON object; and
      #
      #   * contain at least a top-level JSON key of "default" with a value
      #     that is a string.
      #
      #   You can define other top-level keys that define the message you want
      #   to send to a specific transport protocol (e.g., "http").
      #
      #   For information about sending different messages for each protocol
      #   using the AWS Management Console, go to [Create Different Messages for
      #   Each Protocol][1] in the *Amazon Simple Notification Service Getting
      #   Started Guide*.
      #
      #   Valid value: `json`
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/sns/latest/gsg/Publish.html#sns-message-formatting-by-protocol
      # @option options [Hash<String,Types::MessageAttributeValue>] :message_attributes
      #   Message attributes for Publish action.
      # @return [Types::PublishResponse]
      def publish(options = {})
        options = options.merge(target_arn: @arn)
        resp = @client.publish(options)
        resp.data
      end

      # @example Request syntax with placeholder values
      #
      #   platform_endpoint.set_attributes({
      #     attributes: { # required
      #       "String" => "String",
      #     },
      #   })
      # @param [Hash] options ({})
      # @option options [required, Hash<String,String>] :attributes
      #   A map of the endpoint attributes. Attributes in this map include the
      #   following:
      #
      #   * `CustomUserData` -- arbitrary user data to associate with the
      #     endpoint. Amazon SNS does not use this data. The data must be in
      #     UTF-8 format and less than 2KB.
      #
      #   * `Enabled` -- flag that enables/disables delivery to the endpoint.
      #     Amazon SNS will set this to false when a notification service
      #     indicates to Amazon SNS that the endpoint is invalid. Users can set
      #     it back to true, typically after updating Token.
      #
      #   * `Token` -- device token, also referred to as a registration id, for
      #     an app and mobile device. This is returned from the notification
      #     service when an app and mobile device are registered with the
      #     notification service.
      # @return [EmptyStructure]
      def set_attributes(options = {})
        options = options.merge(endpoint_arn: @arn)
        resp = @client.set_endpoint_attributes(options)
        resp.data
      end

      # @deprecated
      # @api private
      def identifiers
        { arn: @arn }
      end
      deprecated(:identifiers)

      private

      def extract_arn(args, options)
        value = args[0] || options.delete(:arn)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :arn"
        else
          msg = "expected :arn to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      class Collection < Resources::Collection

        # @return [Enumerator<PlatformEndpoint>]
        def each(&block)
          enum = super
          enum.each(&block) if block
          enum
        end

      end
    end
  end
end