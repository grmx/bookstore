RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  # config.authorize_with do
  #   redirect_to main_app.root_path unless current_user.is_admin?
  # end

  ## == Cancan ==
  config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard do
      except ['CreditCard', 'Identity']
    end
    index do
      except ['CreditCard', 'Identity']
    end
    new do
      except ['OrderItem']
    end
    export
    bulk_delete
    show
    edit
    delete do
      except ['Order', 'OrderItem']
    end
    show_in_app do
      only ['Book', 'Category']
    end
    state

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Book do
    edit do
      include_all_fields
      exclude_fields :keywords, :ratings, :users
    end
  end

  config.label_methods.unshift(:full_name)
end
