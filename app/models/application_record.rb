class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def difference(old)
    array_diffs = []
    old_attr = old.attributes
    new_attr = self.attributes
    diff = new_attr.to_a - old_attr.to_a
    diff.map do |elem|
      attr_name = elem[0]
      if(attr_name == "id" ||
        attr_name == "created_at" ||
        attr_name == "updated_at")
        next
      end
      array_diffs.push("\"#{attr_name}\": \"#{elem[1]}\"")
    end
    difference = array_diffs.join ", "
    unless difference == ""
      difference += "}"
      difference.prepend "{"
      difference
    end
  end
end
