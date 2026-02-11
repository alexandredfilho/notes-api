require 'rails_helper'

RSpec.describe Note, type: :model do
  subject(:note) { build(:note) }

  it { is_expected.to validate_presence_of(:title) }
end
