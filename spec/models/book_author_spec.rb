require 'rails_helper'

RSpec.describe BookAuthor, type: :model do
  it { should belong_to :book }
  it { should belong_to :author }
end
