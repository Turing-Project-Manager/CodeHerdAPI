module Mutations
  class CreateResource < BaseMutation
    argument :user_id, ID, required: true
    argument :name, String, required: true
    argument :project_id, ID, required: true
    argument :resource_type, String, required: true
    argument :content, String, required: true
    argument :tags, [String], required: false

    field :resource, Types::ResourceType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, project_id:, name:, resource_type:, content:, tags: nil)
      if Collaborator.where(user_id: user_id, project_id: project_id).empty?
        return return_info(nil, errors: ['Cant create resource. You are not a collaborator or project doesnt exist'])
      end

      resource = Resource.new(
        name: name,
        project_id: project_id,
        resource_type: resource_type,
        content: content
      )
      resource.tags = tags if tags.present?
      
      if resource.save
        return_info(resource)
      else
        return_info(nil, errors: resource.errors.full_messages)
      end
    rescue ArgumentError => error
      return_info(nil, errors: [error.message])
    end

    private
    def return_info(resource, errors: [])
      {
        resource: resource,
        errors: errors
      }
    end
  end
end
