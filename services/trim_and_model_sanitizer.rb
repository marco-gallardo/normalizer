module Services
  module TrimAndModelSanitizer
    def self.call(sanitizable)
      Sanitizer.new(sanitizable).run!
    end

    class Sanitizer
      EMPTY_TRIM_SYNONIM = 'blank'

      def initialize(sanitizable)
        @sanitizable = sanitizable
      end

      def run!
        cleanse_trim
        subtract_trim_from_model
        upcase_trim!
      end

      private

      def cleanse_trim
        return unless @sanitizable.trim

        @sanitizable.trim = nil if trim_blank?
      end

      def trim_blank?
        @sanitizable.trim.downcase == EMPTY_TRIM_SYNONIM
      end

      def subtract_trim_from_model
        model, trim = @sanitizable.model.split(' ')[0..1]

        @sanitizable.model = model
        @sanitizable.trim  = trim if trim
      end

      def upcase_trim!
        return unless @sanitizable.trim

        @sanitizable.trim.upcase!
      end

      def trim_present?
        !@sanitizable.trim.nil?
      end
    end
  end
end
