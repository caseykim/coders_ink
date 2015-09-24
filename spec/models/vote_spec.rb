require 'rails_helper'

RSpec.describe Vote, type: :model do

  it { should belong_to(:user) }
  it { should belong_to(:review) }

  it { should validate_presence_of(:score) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:review) }

  it { should have_valid(:score).when(0, 1, -1) }
  it { should_not have_valid(:score).when(nil, 6, -50, 5.5) }

end
