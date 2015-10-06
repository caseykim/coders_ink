# require 'spec_helper'
#
# RSpec.describe ReviewMailer, type: :mailer do
#   describe 'instructions' do
#     let!(:user1) { FactoryGirl.create(:user) }
#     let!(:user2) { FactoryGirl.create(:user) }
#     let!(:tattoo) { FactoryGirl.create(:tattoo, user: user1) }
#     let!(:review) { FactoryGirl.create(:review, user: user2, tattoo: tattoo) }
#     let!(:mail) { ReviewMailer.new_review(review) }
#
#     it 'renders the subject' do
#       expect(mail.subject).to eql("New Review for #{review.tattoo.title}")
#     end
#
#     it 'renders the receiver email' do
#       expect(mail.to).to eql([user1.email])
#     end
#
#     it 'renders the sender email' do
#       expect(mail.from).to eql(['no-reply@codersink.com'])
#     end
#
#     it 'assigns @name' do
#       expect(mail.body.encoded).to match(user1.username)
#     end
#   end
# end
