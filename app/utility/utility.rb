module Utility
  def is_empty(arr)
    return false if !arr.kind_of?(Array)
    return arr.empty?
  end

  def generate_token
    SecureRandom.base64.tr('+/=', 'Qrt')
  end

  def current_datetime
    Utility.current_datetime
  end

  def Utility.get_simplified_array(items, keys)
    simplified_array = []
    items.each do |item|
      simplified_item = {}
      keys.each do |key|
        simplified_item[key] = item[key]
      end
      simplified_array << simplified_item
    end
    return simplified_array
  end
  
  def sanitize_filename(filename)
    filename.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub! /\A.*(\\|\/)/, ''
      # Finally, replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end

  # creates a hash object out of a resource array
  # where each resource's id is used as the hash key
  def create_id_hash(resource_array)
    id_hash = {}
    resource_array.each do |resource|
      if !resource.nil?
        id_hash[resource.id] = resource
      end
    end
    return id_hash
  end


  def order_resource_array_by_id_array(resource_array, id_array)
    id_hash = create_id_hash(resource_array)
    ordered_array = []
    id_array.each do |id|
      resource = id_hash[id]
      ordered_array << resource
    end
    return ordered_array
  end

  # creates a hash object out of a resource array
  # where a custom field is used as the hash key
  # override_duplicates - the hash key may not be unique, e.g. [{x: 1, y: 1}, {x: 1, y: 2}]
  # if override_duplicates is false, the hash would be: {1: {x: 1, y: 1}}
  # if override_duplicates is true, the hash would be: {1: {x: 1, y: 2}}
  def create_custom_field_hash(resource_array, field, override_duplicates = false)
    custom_field_hash = {}
    resource_array.each do |resource|
      if !resource.nil?
        key = resource[field]
        # next if override_duplicates is false and key exists in hash
        if !override_duplicates && !custom_field_hash[key].nil?
          next
        end
        custom_field_hash[key] = resource
      end
    end
    return custom_field_hash
  end

  def create_lookup_hash(array)
    lookup_hash = {}
    array.each do |item|
      lookup_hash[item] = true
    end
    return lookup_hash
  end

  def create_frequency_hash(array)
    frequency_hash = Hash.new(0)
    array.each do |item|
      frequency_hash[item] += 1
    end
    return frequency_hash
  end

  def get_array_difference(array_1, array_2, comparison_keys)
    Utility.get_array_difference(array_1, array_2, comparison_keys)
  end

  # returns an array of hashes present in array_1 but not array_2
  # e.g. get_array_difference([{id: 1}, {id: 2}], [{id: 2}], [:id]) = [{id: 1}]
  # assumes that all comparison_keys for the hashes are not blank
  # e.g. {id: 1}[:id] is 1 and is not blank
  def Utility.get_array_difference(array_1, array_2, comparison_keys)
    results = []
    hash_of_array_2 = {}
    separator = "-*x#-"
    array_2.each do |item|
      combined_key_arr = []
      comparison_keys.each do |key|
        combined_key_arr << item[key]
      end
      combined_key = combined_key_arr.join(separator)
      hash_of_array_2[combined_key] = true
    end

    array_1.each do |item|
      combined_key_arr = []
      comparison_keys.each do |key|
        combined_key_arr << item[key]
      end
      combined_key = combined_key_arr.join(separator)
      if hash_of_array_2[combined_key].nil?
        results << item
      end
    end

    return results
  end

  def create_encoded_url(query_base_url, query_values)
    Utility.create_encoded_url(query_base_url, query_values)
  end

  def Utility.create_encoded_url(query_base_url, query_values)
    uri = Addressable::URI.parse(query_base_url)
    uri.query_values = query_values
    return uri.normalize.to_s
  end

  def Utility.current_datetime
    return Time.now.utc
  end

  def Utility.developer_emails
    return ["checkraiser11@gmail.com"]
  end

  def Utility.regex_developer_emails
    regex_emails = []
    Utility.developer_emails.each do |email|
      regex_emails << Regexp.new(email)
    end
    return regex_emails
  end

  def Utility.is_valid_email(email)
    begin
      return EmailVerifier.check(email)
    rescue
      return false
    end
  end

  def remove_duplicates(model, columns)
    return Utility.remove_duplicates(model, columns)
  end

  def Utility.remove_duplicates(model, columns)
    duplicates = model.select(columns).group(columns).having("count(*) > 1")
    duplicates.each do |duplicate|
      filter = {}
      columns.each do |column|
        filter[column] = duplicate[column]
      end
      row_to_preserve = model.find_by(filter)
      rows_to_delete = model.where(filter).where.not(id: row_to_preserve.id)
      rows_to_delete.delete_all
    end

  end
  def push_event(user_ids, event_type, data = nil, guest_ids = [])
    event = {}
    event[:user_ids] = user_ids
    event[:type] = event_type
    event[:data] = data
    event[:guest_ids] = guest_ids
    $redis.publish 'new-event', event.to_json
  end
end