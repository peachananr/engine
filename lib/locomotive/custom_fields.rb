# Custom options for CustomFields
CustomFields.options = {
  reserved_names: Mongoid.destructive_fields + %w(id _id send created_at updated_at)
}

module CustomFields

  class Field

    field :ui_enabled, type: Boolean, default: true
    field :group

    def class_name_to_content_type
      self._parent.send :class_name_to_content_type, self.class_name
    end

    protected

    def ensure_class_name_security
      self._parent.send :ensure_class_name_security, self
    end
  end

  module Types

    module File

      class FileUploader < ::CarrierWave::Uploader::Base

        # TODO: (Did), not needed anymore? issue?
        # include ::CarrierWave::MimeTypes

        # process :set_content_type

        # Set correct paths
        def store_dir
          "sites/#{model.site_id}/#{model._type.demodulize.underscore}/#{model.id}/files"
        end

        def image?
          "true" #monkey patched
          #!(self =~ /jpg|png|webp|jpeg|gif/).nil?
          #!(content_type =~ /image/).nil?
        rescue Exception => e
          Rails.logger.error("[CustomFields][FileUploader][#{model._id}] can't access the uploaded file, reason: #{e.message}")
        end

        # In some situations, for instance, for the notification email when a content entry is created,
        # we need to know the url of the file without breaking the upload process.
        # Actually, the uploaded file will be written on the filesystem after the email is sent.
        #
        # @param [ String ] host Required to build the full url in the Filesystem is used (optional)
        #
        # @return [ String ] The url to the soon uploaded file
        #
        def guess_url(host = nil)
          this = self.class.new(model, mounted_as)
          this.retrieve_from_store!(model.read_uploader(mounted_as))

          if this.url =~ /^http/ || host.blank?
            this.url
          else
            URI.join("http://#{host}", this.url).to_s
          end
        end

        def cache_dir
          "#{Rails.root}/tmp/uploads"
        end

      end

    end

  end
end
