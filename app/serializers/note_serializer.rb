class NoteSerializer
  include JSONAPI::Serializer

  set_type :note

  attributes :title, :content, :created_at, :updated_at
end
