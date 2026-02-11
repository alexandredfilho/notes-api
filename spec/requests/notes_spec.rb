require 'rails_helper'

RSpec.describe 'Notes API', type: :request do
  def json_body
    JSON.parse(response.body)
  end

  def jsonapi_title
    json_body.dig('data', 'attributes', 'title')
  end

  def jsonapi_count
    json_body.fetch('data').size
  end

  def validation_errors
    json_body.fetch('errors')
  end

  def expect_validation_error(message)
    expect(response).to have_http_status(:unprocessable_content)
    expect(validation_errors).to include(message)
  end

  describe 'GET /api/v1/notes' do
    it 'returns notes' do
      create_list(:note, 2)

      get '/api/v1/notes'

      expect(response).to have_http_status(:ok)
      expect(jsonapi_count).to eq(2)
    end
  end

  describe 'POST /api/v1/notes' do
    it 'creates a note with valid params' do
      payload = { note: { title: 'Minha anotação', content: 'Conteúdo' } }

      post '/api/v1/notes', params: payload

      expect(response).to have_http_status(:created)
      expect(jsonapi_title).to eq('Minha anotação')
    end

    it 'returns validation errors with invalid params' do
      payload = { note: { title: '' } }

      post '/api/v1/notes', params: payload

      expect_validation_error('Título não pode ficar em branco')
    end
  end

  describe 'PATCH /api/v1/notes/:id' do
    it 'updates a note with valid params' do
      note = create(:note)

      patch "/api/v1/notes/#{note.id}", params: { note: { title: 'Atualizado' } }

      expect(response).to have_http_status(:ok)
      expect(jsonapi_title).to eq('Atualizado')
    end

    it 'returns validation errors with invalid params' do
      note = create(:note)

      patch "/api/v1/notes/#{note.id}", params: { note: { title: '' } }

      expect_validation_error('Título não pode ficar em branco')
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    it 'deletes a note' do
      note = create(:note)

      delete "/api/v1/notes/#{note.id}"

      expect(response).to have_http_status(:no_content)
      expect(Note.count).to eq(0)
    end
  end

  describe 'i18n not found' do
    it 'returns localized not found message' do
      delete '/api/v1/notes/999999', headers: { 'Accept-Language' => 'pt-BR' }

      expect(response).to have_http_status(:not_found)
      expect(validation_errors).to include('não encontrado')
    end
  end
end
