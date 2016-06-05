require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  Category.delete_all

  let(:valid_attributes) {{name: 'cinema'}}
  let(:invalid_attributes) {}

  describe "GET #index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, :format => :json
      expect(assigns(:categories)).to eq([category])
    end
  end

  # Categorias não poderá ser criada pelos usuários, logo, não terá a página new => erro esperado: MissingTemplate
  describe "GET #new" do
    it "assigns a new category as @category" do
      expect{get :new, {}}.to raise_error(ActionView::MissingTemplate)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, {:category => valid_attributes}
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, {:category => valid_attributes}
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, {:category => valid_attributes}
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        expect{ post :create, {:category => invalid_attributes}}
        .to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{name: 'arte'}}

      it "updates the requested category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => new_attributes}
        category.reload
        expect(category.name).to eq('arte')
      end

      it "assigns the requested category as @category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        put :update, {:id => category.to_param, :category => valid_attributes}
        expect(response).to redirect_to(category)
      end
    end

    context "with invalid params" do
      it "assigns the category as @category" do
        category = Category.create! valid_attributes
        expect{ put :update, {:id => category.to_param, :category => invalid_attributes}}
        .to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete :destroy, {:id => category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categories list" do
      category = Category.create! valid_attributes
      delete :destroy, {:id => category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end

end
