RailsAdmin.config do |config|

  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # Hide these models from the navigation:
  [Cart, DonationItem, PostType, SupporterType, PaymentRecord].each do |klass|
    config.model klass do
      visible false
    end
  end

  config.model Page do
    configure :banner_title, :text
    list do
      field :title
      field :title_override
      field :banner_title
      field :description
      field :published
    end
    edit do
      field :title
      field :published
      field :image do
        label 'Banner Image'
      end
      field :banner_title do
        html_attributes rows: 3, cols: 40
        help "Used for text in middle of featured image"
      end
      field :content, :ck_editor
      group :advanced do
        field :title_override do
          help "Optional override for SEO page title and Facebook sharing"
        end
        field :description do
          help "Used for SEO description tag and Facebook sharing"
        end
        field :page_images do
          active true
          associated_collection_scope do
            Proc.new { |scope|
              scope = scope.order('position ASC')
            }
          end
          label 'Slideshow Images'
          help 'Only used on select pages. Drag images into desired order.'
        end
        field :quotes do
          active true
          associated_collection_scope do
            Proc.new { |scope|
              scope = scope.order('position ASC')
            }
          end
          help 'Only used on select pages. Drag quotes into desired order.'
        end
      end
    end
  end

  config.model Supporter do
    list do
      field :title
      field :supporter_type
      field :url
      field :logo_file_name
    end
    edit do
      field :title
      field :url
      field :logo
      field :supporter_type do
        inline_add false
        inline_edit false
      end
    end
  end

  config.model Quote do
    visible false
    object_label_method do
      :quote_short
    end
    edit do
      field :quote
      field :quotee
      field :title
      field :location
      field :position, :hidden do
        help '' # no caption
      end
    end
  end

  config.model Post do
    list do
      sort_by :post_date
      sort_reverse true
      field :title
      field :post_type
      field :icon
      field :url
      field :post_date
      field :published
    end
    edit do
      field :title
      field :post_type do
        inline_add false
        inline_edit false
      end
      field :published
      field :icon, :enum do
        default_value 'text'
      end
      field :post_date
      field :url do
        help '"View Page" button will link to this instead of single Post page if this is set.'
      end
      field :content, :ck_editor
    end
  end

  config.model Applicant do
    list do
      field :first_name
      field :last_name
      field :phone
      field :email
      field :form
      field :subject
    end
  end

  config.model Donation do
    show do
      field :full_address
      field :email
      field :found_text
      field :newsletter
      field :donation_items
      field :total do
        formatted_value do
          "$%.2f" % bindings[:object].total
        end
      end
    end
    list do
      filters [:reasons]
      field :first_name
      field :last_name
      field :email
      field :found do
        pretty_value do
          bindings[:object].found == 'Other' ? bindings[:object].found_other : bindings[:object].found
        end
      end
      field :reasons do
        searchable ["title"]
      end
      field :total do
        formatted_value do
          "$%g" % bindings[:object].total
        end
      end

    end
  end

  config.model ReasonImage do
    visible false
    edit do
      field :image
      field :caption
      field :position, :hidden do
        help '' # no caption
      end
    end
  end

  config.model PageImage do
    visible false
    edit do
      field :image
      field :caption
      field :position, :hidden do
        help '' # no caption
      end
    end
  end

  config.model Reason do
    weight -1

    list do
      sort_by :post_date
      field :title
      field :total_donated do
        formatted_value do
          "$%g" % bindings[:object].total_donated
        end
      end
      field :total_needed do
        formatted_value do
          "$%g" % bindings[:object].total_needed
        end
      end
      field :is_success
      field :fulfilled
      field :post_date
      field :promoted
    end
    edit do
      field :title do
        help do
          if bindings[:object].id
            help + ' (/reasons/' + bindings[:object].slug + ')'
          else
            help
          end
        end
      end
      field :total_donated
      field :total_needed
      field :donation_prompt do
        # help "e.g. Why not support Madeline by giving whatever you can"
      end
      field :published
      field :promoted do
        help 'Will stick Reason to top of homepage'
      end
      field :post_date do
        help 'Reasons are sorted by this date field.'
        visible do
          !bindings[:object].post_date.nil?
        end
      end
      field :featured_video do
        help 'Paste in either YouTube normal link (e.g. https://www.youtube.com/watch?v=yYNC5kvihnk), or short share link (e.g. https://youtu.be/yYNC5kvihnk).'
      end
      field :image
      field :secondary_image
      field :excerpt, :ck_editor do
        help do
          help + ' This is the text shown in the listing view.'
        end
      end
      field :content, :ck_editor do
        help do
          help + ' To embed YouTube videos, just paste the short share link (e.g. https://youtu.be/yYNC5kvihnk).'
        end
      end
      group :success_story do
        active do
          bindings[:object].is_success == true
        end
        label 'Success Story'
        field :is_success
        field :success_donation_prompt do
          help 'Prompt for donations once Reason is a Success'
        end
        field :reason_images do
          active true
          associated_collection_scope do
            Proc.new { |scope|
              scope = scope.order('position ASC')
            }
          end
          label 'Slideshow Images'
          help 'Drag images into desired order.'
        end
       
       field :success_excerpt, :ck_editor do
         help do
           help + ' This is the text shown in the listing view.'
         end
       end
       field :success_content, :ck_editor do
         help do
           help + ' To embed YouTube videos, just paste the short share link (e.g. http://youtu.be/yYNC5kvihnk).'
         end
       end
     end
    end
  end
end
