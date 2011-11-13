ActiveAdmin.register Parcel do
  #clear all filters
  config.clear_sidebar_sections!

  index do
    column :name
    column :state do |a| I18n.t("state.#{a.state.status}") end
    column :eta do |a| (a.state.eta.seconds > 0) ? time_ago_in_words(Time.zone.now - a.state.eta.seconds) : '-' end
    column '' do |resource| 
      if resource.state.status.to_i == 0
        link_to I18n.t('state.start'), change_state_parcel_url(resource, :state => :start), :class => "member_link"
      else
        link_to I18n.t('state.stop'), change_state_parcel_url(resource, :state => :stop), :class => "member_link"
      end
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :asset if f.object.new_record?
    end

    f.buttons
  end

  show do
    panel I18n.t('active_admin.details', :model => active_admin_config.resource_name) do
      attributes_table_for resource, :name
    end
  end

  member_action :change_state do
    case params[:state]
    when 'stop'
      resource.stop
    when 'start'
      resource.start
    end



    redirect_to :action => :index
  end

end
