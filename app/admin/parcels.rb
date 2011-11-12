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
	    f.input :asset
	  end

	  f.buttons
	end

end
