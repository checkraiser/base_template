class CourseBase < ActiveRecord::Base
  self.abstract_class = true

  def self.activate_shard(subdomain, course_id)
    account = Account.activate_shard subdomain
  	course = Course.find(course_id)
  	if course
  	  self.establish_connection course.shard.to_config 
      Course.current_id = course.id
  	  return course
  	else
      return nil
    end
  end

  def self.activate_shard(account_id, course_id)
    account = Account.activate_shard account_id
    course = Course.find(course_id)
    if course
      self.establish_connection course.shard.to_config 
      Course.current_id = course.id
      return course
    else
      return nil
    end
  end
end