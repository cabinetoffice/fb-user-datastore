require 'rails_helper'

RSpec.describe HealthController do
  describe '#show' do
    it 'returns 200 OK' do
      get :show
      expect(response.status).to eq(200)
      expect(response.body).to eq('healthy')
    end
  end

  describe '#readiness' do
    it 'returns 200 OK' do
      get :readiness
      expect(response.status).to eq(200)
      expect(response.body).to eq('ready')
    end
  end
end
