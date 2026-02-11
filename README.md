# Notes API

Simple Ruby on Rails API for creating and listing notes.

## Stack
- Ruby on Rails (API-only)
- PostgreSQL
- JSON:API Serializer
- RSpec + FactoryBot + Faker + Shoulda Matchers + SimpleCov

## Local setup
```bash
cd notes-api
bundle install
bundle exec rails db:create db:migrate
bundle exec rails server
```

API runs at `http://localhost:3000`.

## Docker setup
```bash
cd notes-api
docker compose up --build
```

In another terminal, prepare the database:
```bash
docker compose exec api bin/rails db:create db:migrate
```

API runs at `http://localhost:3000`.

## Endpoints
### List notes
```
GET /api/v1/notes
```

### Create note
```
POST /api/v1/notes
Content-Type: application/json

{
  "note": {
    "title": "My note",
    "content": "Optional content"
  }
}
```

### Update note
```
PATCH /api/v1/notes/:id
Content-Type: application/json

{
  "note": {
    "title": "Updated title",
    "content": "Optional content"
  }
}
```

### Delete note
```
DELETE /api/v1/notes/:id
```

## Response format
Responses follow JSON:API.
Example:
```json
{
  "data": {
    "id": "1",
    "type": "note",
    "attributes": {
      "title": "My note",
      "content": "Optional content",
      "created_at": "2026-02-11T18:40:00Z",
      "updated_at": "2026-02-11T18:40:00Z"
    }
  }
}
```

## i18n
Send `Accept-Language` with `pt-BR` or `en` to change validation messages.

### Validation errors
Returns `422 Unprocessable Entity` with:
```json
{ "errors": ["Title can't be blank"] }
```

## Quality
Tools configured in the Gemfile:
- `brakeman`
- `bundler-audit`
- `rubocop-rails-omakase`
- `rubycritic`

## Tests
Local:
```bash
bundle exec rspec
```

Docker:
```bash
docker compose run --rm -e RAILS_ENV=test api bundle exec rspec
```

Evidences:
- Bundler Audit
```bash
bundle exec bundler-audit check --update
```
<img width="961" height="425" alt="Screenshot from 2026-02-11 19-40-04" src="https://github.com/user-attachments/assets/c526565a-1686-45f4-9ed9-216dd149621d" />


- SimpleCov report
```bash
bundle exec rspec
open coverage/index.html
```
<img width="1914" height="788" alt="Screenshot from 2026-02-11 19-32-24" src="https://github.com/user-attachments/assets/b97422ac-5a7e-42ad-b57b-5c6bf49c640a" />


- RubyCritic report
```bash
bundle exec rubycritic
open tmp/rubycritic/overview.html
```
<img width="1914" height="955" alt="Screenshot from 2026-02-11 19-37-38" src="https://github.com/user-attachments/assets/4acd5fd1-6f98-429a-8a32-18eb9c99032d" />

