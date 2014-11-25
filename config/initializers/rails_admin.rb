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
  [Cart, Donation, ReasonImage, PostType].each do |klass|
  # [ReasonImage, PostType].each do |klass|
    config.model klass do
      visible false
    end
  end

  config.model PostType do
    edit do
      field :name
    end
  end

  config.model Page do
    list do
      field :title
      field :published
    end
    edit do
      field :title
      field :published
      field :image
      field :content, :ck_editor
    end
  end

  config.model SupporterType do
    edit do
      field :title
    end
  end

  config.model Supporter do
    list do
      field :title
      field :supporter_type
      field :url
    end
    edit do
      field :title
      field :url
      field :logo
      field :supporter_type
    end
  end

  config.model Post do
    list do
      sort_by :post_date
      sort_reverse true
      field :title
      field :post_type
      field :post_date
      field :published
    end
    edit do
      field :title
      field :post_type
      field :published
      field :icon, :enum do
        default_value 'text'
      end
      field :post_date
      field :content, :ck_editor
    end
  end


  config.model Reason do
    weight -1

    list do
      sort_by :post_date
      field :title
      field :total_donated
      field :total_needed
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
      # field :recipient_category
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
      configure :reason_images do
        active true
        associated_collection_scope do
          Proc.new { |scope|
            scope = scope.order('position ASC')
          }
        end
      end

      group :success_story do
       active do
         bindings[:object].is_success == true
       end
       label 'Success Story'
       field :is_success
       
       field :reason_images do
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
