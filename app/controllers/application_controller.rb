class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Store changes on event to create big data
  def store_changes(old_object, new_object)
    change_att = new_object.difference old_object
    unless change_att == ""
      Event.create(class_name: new_object.class.to_s,object_id: new_object.id, change: change_att)
    end
  end
end
