module Locomotive
  module Concerns
    module ContentEntry
      module FileSize

        extend ActiveSupport::Concern

        included do

          ## fields ##
          field :_file_size, type: Integer, default: 0

          ## callbacks ##
          before_save :sync_file_size

        end

        private

        def sync_file_size
          Rails.logger.info "bbbbbbb #{self.file_custom_fields.inspect}"
          
          self._file_size = self.file_custom_fields.inject(0) do |sum, field|
            Rails.logger.info "ooooo #{field} #{sum}"
            file = send(field)&.file
            Rails.logger.info "aaaaaa #{send(field).inspect}"

            _size = file&.exists? ? file.size : 0
            _size + sum
          end
        end

      end
    end
  end
end
