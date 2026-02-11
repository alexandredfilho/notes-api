module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_note, only: %i[update destroy]

      def index
        notes = Note.order(created_at: :desc)
        render json: NoteSerializer.new(notes).serializable_hash
      end

      def create
        note = Note.new(note_params)

        if note.save
          render json: NoteSerializer.new(note).serializable_hash, status: :created
        else
          render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @note.update(note_params)
          render json: NoteSerializer.new(@note).serializable_hash, status: :ok
        else
          render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @note.destroy
        head :no_content
      end

      private

      def set_note
        @note = Note.find(params[:id])
      end

      def note_params
        params.require(:note).permit(:title, :content)
      end
    end
  end
end
