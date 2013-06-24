class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  respond_to :html, :js #exercise 11.5.2
  
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_with @user
=begin
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    http://blog.plataformatec.com.br/2009/08/embracing-rest-with-mind-body-and-soul/
=end

  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
=begin
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
    http://blog.plataformatec.com.br/2009/08/embracing-rest-with-mind-body-and-soul/
=end
  end
end
=begin
This code uses respond_to to take the appropriate action depending on the kind
of request. 
(There is no relationship between this respond_to and the respond_to
used in the RSpec examples.)

It's important to understand that only one of the lines gets executed

In the case of an Ajax request, Rails automatically calls a JavaScript
Embedded Ruby (.js.erb) file with the same name as the action,
i.e., create.js.erb or destroy.js.erb

<!--
dollar-sign syntax to access a DOM element based in its unique CSS id 
.html updates the HTML inside the relevant element with the contents of its argument
-->
=end
