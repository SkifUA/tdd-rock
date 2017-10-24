 require 'rails_helper'

 describe AchievementsController, type: :controller do
   describe "guest user" do
     describe "GET index" do
       it "renders index template" do
         get :index
         expect(response).to render_template(:index)
       end
       it "assigns only public achievements to template" do
         public_achievement = FactoryGirl.create(:public_achievement)

         get :index
         expect(assigns(:achievements)).to match_array([public_achievement])
       end
     end

     describe "GET show" do
       let(:achievement) { FactoryGirl.create(:public_achievement) }

       it "renders show template" do
         get :show, params: { id: achievement }
         expect(response).to render_template(:show)
       end

       it "assign requested achievement to @achievement" do
         get :show, params: { id: achievement }
         expect(assigns(:achievement)).to eq(achievement)
       end
     end

     describe "GET new" do
       it "redirect to login page" do
         get :new
         expect(response).to redirect_to(new_user_session_url)
       end
     end

     describe "POST create" do
       it "redirect to login page" do
         post :create, params: { achievement: FactoryGirl.attributes_for(:public_achievement) }
         expect(response).to redirect_to(new_user_session_url)
       end
     end

     describe "GET edit" do
       it "redirect to login page" do
         get :edit, params: { id: FactoryGirl.create(:achievement) }
         expect(response).to redirect_to(new_user_session_url)
       end
     end

     describe "PUT update" do
       it "redirect to login page" do
         post :create, params: { id: FactoryGirl.create(:achievement), achievement: FactoryGirl.attributes_for(:public_achievement) }
         expect(response).to redirect_to(new_user_session_url)
       end
     end

     describe "DELETE destroy" do
       it "redirect to login page" do
         delete :create, params: { id: FactoryGirl.create(:achievement) }
         expect(response).to redirect_to(new_user_session_url)
       end
     end
   end

   describe "GET edit" do
     let(:achievement) { FactoryGirl.create(:public_achievement) }
     it "renders :edit template" do
       get :edit, params: { id: achievement.id }
       expect(response).to render_template(:edit)
     end

     it "assigns the requested achievement to temp" do
       get :edit, params: { id: achievement.id }
       expect(assigns(:achievement)).to eq(achievement)
     end
   end

   describe "PUT update" do
     let(:achievement) { FactoryGirl.create(:public_achievement) }

     context "valid date" do
       let(:valid_data) { FactoryGirl.attributes_for(:public_achievement, title: 'New title') }

       it "redirect to achievement#show" do
         put :update, params: { id: achievement, achievement: valid_data }
         expect(response).to redirect_to(achievement_path(assigns[:achievement]))
       end

       it "updates achievement in the database" do
         put :update, params: { id: achievement, achievement: valid_data }
         achievement.reload
         expect(achievement.title).to eq("New title")
       end

     end

     context "invalid date" do
       let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: '', description: "Invalid data") }

       it "renders to :edit template" do
         put :update, params: { id: achievement, achievement: invalid_data }
         expect(response).to render_template(:edit)
       end

       it "doesn't update achievement in the database" do
         put :update, params: { id: achievement, achievement: invalid_data }
         achievement.reload
         expect(achievement.description).not_to eq("Invalid data")
       end
     end
   end


   describe "GET new" do
     it "render :new template" do
       get :new
       expect(response).to render_template(:new)
     end

     it "assigns new Achievement to @achievement" do
       get :new
       expect(assigns(:achievement)).to be_a_new(Achievement)
     end
   end

   describe "POST create" do
     context "valid data" do
        let(:valid_data) { FactoryGirl.attributes_for(:public_achievement) }

       it "redirect to achievement#show" do
         post :create, params: { achievement: valid_data }
         expect(response).to redirect_to(achievement_path(assigns[:achievement]))
       end

       it "creates new achievement in database" do
         expect {
           post :create, params: { achievement: valid_data }
         }.to change(Achievement, :count).by(1)
       end
     end

     context "invalid data" do
       let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: '') }

       it "renders :new template" do
         post :create, params: { achievement: invalid_data }
         expect(response).to render_template(:new)
       end

       it "doesn't create new achievement in the database" do
         expect {
           post :create, params: { achievement: invalid_data }
         }.not_to change(Achievement, :count)
       end
     end
   end

   describe "DELETE destroy" do
     let(:achievement) { FactoryGirl.create(:public_achievement) }

     it "redirect to achievements#index" do
       delete :destroy, params: { id: achievement }
       expect(response).to redirect_to(achievements_path)
     end

     it "deletes achievement from databases" do
       delete :destroy, params: { id: achievement }
       expect(Achievement.exists?(achievement.id)).to be_falsy
     end
   end
 end