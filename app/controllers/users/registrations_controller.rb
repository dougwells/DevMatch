# Code on this page is used to over-ride Devise's "create" function which would normally happen after
# hitting "Submit" button on new user form".  See files in views/devise/registrations

class Users::RegistrationsController < Devise::RegistrationsController
    before_filter :select_plan, only: :new
    
    def create
        super do|resource|
            if params[:plan]
                resource.plan_id = params[:plan]
                if resource.plan_id
                    resource.save_with_payment
                else
                    resource.save
                end
            end
        end
    end
    
    def cancel
        
    end
    
    private
        def select_plan
            unless params[:plan] && (params[:plan] =='1' || params[:plan] =='2')
                flash[:notice] = "Please select a membership plan to sign up."
                redirect_to root_url
            end
        end
    
end