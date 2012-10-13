require 'spec_helper'

describe Gist do

  describe 'Validations' do

    context 'blank' do
      subject(:gist) { Gist.new }

      it {should be_blank}
      it {should be_invalid}
      it {should have(1).error_on(:blob) }
    end

    context 'non blank' do
      subject(:gist) do
        g = Gist.new
        g.stub!(blank?: false)
        g
      end

      it { should_not be_blank }
      it { should be_valid }
    end

  end

  describe '.gist_blobs' do
    subject(:gist) do
      Gist.new(gist_blobs_attributes: [{blob: "Holla"}])
    end

    it { should be_valid }
    it { should have(1).gist_blob }
  end

  describe '.create' do
    it 'creates gist' do
      lambda do
        Gist.create!(gist_blobs_attributes: [{blob: "Holla"}])
      end.should change(Gist, :count).by(1)
    end
  end


  it "is a git repo" do
    Gist.should < GitRepo
  end
end
