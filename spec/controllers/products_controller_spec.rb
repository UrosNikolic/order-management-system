require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  describe "GET #index" do
    before { get 'index' }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    before { get 'show', params: { id: product_id } }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(product_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product/)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { name: 'Head and Shoulders', price: 30 } }

    context 'when the request is valid' do
      before { post 'create', params: { product: valid_attributes } }

      it 'creates a product' do
        expect(json['name']).to eq('Head and Shoulders')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post 'create', params: { product: { name: 'Only name' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match("{\"price\":[\"can't be blank\"]}")
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) { { name: 'New Name', price: 22 } }

    context 'when the record exists' do
      before { put 'update', params: { id: product_id, product: valid_attributes } }

      it 'updates the record' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns status code 204' do
      delete 'destroy', params: { id: product_id }
      expect(response).to have_http_status(204)
    end

    it 'returns 422 if product has associated order ' do
      new_product = Product.new({ name: 'new product', price: 33 })
      new_product.save!
      order = new_product.orders.build({ vat: 20 })
      order.save!
      line_item = new_product.line_items.build({ quantity: 3, order_id: order.id, product_id: new_product.id })
      line_item.save!

      delete 'destroy', params: { id: new_product.id }

      expect(response).to have_http_status(422)
      expect(response.body).to include("{\"product\":[\"Cannot delete product with orders\"]}")
    end
  end
end
