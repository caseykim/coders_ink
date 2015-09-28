require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:tattoos) }
  it { should have_many(:reviews) }
  it { should have_many(:votes) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  it { should have_valid(:username).when("example-postink") }
  it { should_not have_valid(:username).when(nil, "") }

  it { should have_valid(:email).when("casey@inkedgirl.com") }
  it { should_not have_valid(:email).when(nil, "") }

end
