module ApplicationCable
  # Base connection for all channels
  #
  # @author [ Kyle Ady, Tyler Hampton ]
  # @since 0.0.1
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      User.find(cookies.permanent[:user])
    rescue
      reject_unauthorized_connection
    end
  end
end
