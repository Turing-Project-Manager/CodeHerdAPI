module Mutations
  class EditUser < BaseMutation

    argument :user_id, ID, required: true
    argument :name, String, required: false
    argument :slack_handle, String, required: false
    argument :working_styles, String, required: false
    argument :cohort, String, required: false
    argument :pronouns, String, required: false

    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(info)
      user_id = info.delete(:user_id)
      user = User.find(user_id)
      if user.update(info)
        user.working_styles = [info[:working_styles]]
        return_info(user, errors: [])
      else
        return_info(nil, errors: user.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotFound => error
      return_info(nil, errors: ["#{error.message}"])
    end

    private
    def return_info(user, errors: [])
      {
        user: user,
        errors: errors
      }
    end
  end
end