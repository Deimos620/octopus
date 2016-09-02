require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
 
   describe 'BEFORE FILTER #set_current_user_participation' do
     before do 
       @meal_delivery_project = FactoryGirl.create(:project, :new_baby_meal_delivery)
       @organizer_participant = FactoryGirl.create(:participant, :organizer_participant)#
       @meal_delivery_project.update_attributes(organizer_participant_id: @organizer_participant.id)
       @user = User.find( @organizer_participant.user_id)#
       @organizer_participant_role = FactoryGirl.create(:organizer_participant_role)
       @organizer_participant_role.update_attributes(participant_id: @organizer_participant.id, project_id: @meal_delivery_project.id)

    end
      it "has a valid NEW BABY MEAL DELIVERY factory" do 
        expect(@meal_delivery_project.valid?).to be true
      end
      xit "active participant can view it" do
        sign_in @user
        get :projects, :index, project_id: @meal_delivery_project.id
        expect(response).to have_http_status(:success)
      end
      xit "finds  participant participation" do
        @current_user_participation = @user.current_project_participation(@meal_delivery_project.id)
        expect(@current_user_participation.valid?).to be true

      end

     
  end




# RSpec.describe Company, type: :model do


#   before do
#     @p = Product.new(title: 'CliffLaunchSkill', display_title: 'Cliff Launch Skill', sport_code: 'HG',
#                  category: 'Ratings', price_cents: 100)
#     @c = Contact.new(first_name: 'a', last_name: 'b')
#   end
#   describe "A company with a NoviceFlightRating" do
#     before do
#       @c.ratings << NoviceFlightRating.new(sport_code: 'HG')
#     end
#     it "is valid" do
#       expect(@c.valid?).to be true
#     end
#     it "can be assigned a cliff launch rating" do
#       @c.ratings << CliffLaunchSkill.new(sport_code: 'HG')
#       expect(@c.valid?).to be true
#     end
#     describe "with a shopping cart, item, and product" do
#       before do
#         @sc = ShoppingCart.new(contact: @c)
#         @sci = ShoppingCartItem.new(shopping_cart: @sc, product: @p)
#       end
#       it "the product is valid" do
#         expect(@p.valid?).to be true
#       end
#       it "the item is valid" do
#         expect(@sci.valid?).to be true
#       end
#       it "the shopping cart item knows about its product" do
#         expect(@sci.product.title).to eq('CliffLaunchSkill')
#       end
#       it "the cart is valid" do
#         expect(@sc.valid?).to be true
#       end
#     end
  end