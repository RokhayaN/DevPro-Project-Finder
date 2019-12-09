class Helpers
    def self.current_user(session)
      Engineer.find(session[:engineer_id])
    end
    
    def self.is_logged_in?(session)
      if(session[:engineer_id])
        true
      else
        false
      end
      
    end
  end