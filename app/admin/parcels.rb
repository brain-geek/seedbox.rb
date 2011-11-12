ActiveAdmin.register Parcel do
  #clear all filters
  config.clear_sidebar_sections!

  index do
    column :name
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
end
