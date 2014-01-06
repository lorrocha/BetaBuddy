class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ViewerContacts.contact(@contact).deliver
      redirect_to root_path, notice: "Your contact has been submitted! You should hear back shortly."
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :description, :subject)
  end
end
