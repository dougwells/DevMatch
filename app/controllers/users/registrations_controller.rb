# Code on this page is used to over-ride Devise's "create" function which would normally happen after
# hitting "Submit" button on new user form".  See files in views/devise/registrations

class Users::RegistrationsController < Devise::RegistrationsController
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
end