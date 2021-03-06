require 'rails_helper'

RSpec.describe ResponsiblePersonsController, type: :controller do
  let(:responsible_person) { create(:responsible_person) }

  before do
    sign_in_as_member_of_responsible_person(responsible_person)
  end

  after do
    sign_out
  end

  describe "GET #show" do
    it "assigns @responsible_person" do
      get :show, params: { id: responsible_person.id }
      expect(assigns(:responsible_person)).to eq(responsible_person)
    end

    it "renders the show template" do
      get :show, params: { id: responsible_person.id }
      expect(response).to render_template('responsible_persons/show')
    end
  end
end
