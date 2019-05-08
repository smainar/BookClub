require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :username }
    it { should validate_presence_of :title }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :text }
  end
end
