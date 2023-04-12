# encoding: utf-8

module Locomotive
  class EditableFileUploader < BaseUploader

    def store_dir
      self.build_store_dir('sites', model.page.site_id, 'pages', model.page.id, 'files')
      
    end

    def image?
      Rails.logger.info "xxxxxxxxxxxxxxx #{self}"
    end

  end
end
