require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:username).when("example-postink")}
  it { should_not have_valid(:username).when(nil, "")}

  it { should have_valid(:email).when("casey@inkedgirl.com")}
  it { should_not have_valid(:email).when(nil, "")}

  it { should have_valid(:avatar).when(nil, "", "https://s-media-cache-ak0.pinimg.com/236x/1e/ae/d2/1eaed2edf86246a57f4afe00607dc798.jpg")}

end
