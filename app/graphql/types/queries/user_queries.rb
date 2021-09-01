# module Queries
#   class User < Queries::BaseQuery
#     def allUsers
#       User.all
#     end

#     field :user, Types::UserType, null: false do
#       description "return a user"
#       argument :id, ID, required: true
#     end

#     def user(id:)
#       User.find(id)
#     end
#   end
# end