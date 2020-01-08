require 'rails_helper'

RSpec.describe UsersController, type: :controller do 

    describe "GET #index" do 
        it "renders the users index" do 
            get :index 
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do 

        it "renders the show template" do 
            user = User.create!(username: 'hello', password: '123456')
            # debugger
            # get :show, { id: user.id }
            get :show, params: {id: user.id}
            expect(response).to render_template(:show)
        end 

        context 'if user does not exist' do 
            it "is not a success" do 
                begin 
                    get :show, id: -1 
                rescue 
                    ActiveRecord::RecordNotFound
                end

                expect(response).not_to render_template(:show)
            end
        end
    end

    describe "POST #create" do 

        context "with valid params" do
            it "redirects to show page" do 
                post :create, params: {user: {username: 'hello', password: '123456'}}
                expect(response).to redirect_to(user_url(User.find_by(username: 'hello')))
            end
        end

        context "with invalid params" do
            it "renders new template" do 
                post :create, params: {user: {username: 'hello'}}
                expect(response).to render_template(:new)
            end
        end
    end

    describe "DELETE #destroy" do 
 
        it "destroys the user" do
            user = User.create!(username: 'hello', password: '123456')
            delete :destroy, params: {id: user.id}
            expect(User.exists?(id: user.id)).to be(false)
        end

         it "renders new template" do 
            user = User.create!(username: 'hello', password: '123456')
            delete :destroy, params: {id: user.id}
            expect(response).to render_template(:new)
        end
    end
end