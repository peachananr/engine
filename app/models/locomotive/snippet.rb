module Locomotive
  class Snippet

    include Locomotive::Mongoid::Document
    include Concerns::Shared::SiteScope
    include Concerns::Shared::Slug

    ## fields ##
    field :name
    field :slug
    field :template, localize: true

    ## validations ##
    validates_presence_of   :name, :slug, :template
    validates_uniqueness_of :slug, scope: :site_id

    ## named scopes ##
    scope :by_id_or_slug, ->(id_or_slug) { all.any_of({ _id: id_or_slug }, { slug: id_or_slug }) } #monkey patched

    ## behaviours ##
    slugify_from :name

    ## indexes ##
    index site_id: 1, slug: 1

    ## methods ##

    def touch_site_attribute
      :template_version
    end

  end
end
