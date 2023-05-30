# Used by the legacy publisher, see SaveAndReturnController for v2
class SaveReturnsController < ApplicationController
  def create
    save_return = SaveReturn.find_by(service_slug: params[:service_slug],
                                     encrypted_email: params[:encrypted_email])

    if save_return
      save_return.update(save_return_hash)

      return render json: {}, status: :ok
    else
      if SaveReturn.create(save_return_hash)
        return render json: {}, status: :created
      else
        return head :internal_server_error
      end
    end
  end

  def delete
    save_returns = SaveReturn.where(service_slug: params[:service_slug],
                                    encrypted_email: params[:encrypted_email])

    emails = Email.where(service_slug: params[:service_slug],
                         encrypted_email: params[:encrypted_email])

    magic_links = MagicLink.where(service_slug: params[:service_slug],
                                  encrypted_email: params[:encrypted_email])

    # ActiveRecord::Base.transaction do
      if save_returns.destroy_all && emails.destroy_all && magic_links.destroy_all
        return render json: {}, status: :ok
      end
    # end
  end

  private

  def save_return_hash
    {
      service_slug: params[:service_slug],
      encrypted_email: params[:encrypted_email],
      encrypted_payload: params[:encrypted_details]
    }
  end
end
