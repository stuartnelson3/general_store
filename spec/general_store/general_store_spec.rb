require 'spec_helper'

describe GeneralStore do
  subject { GeneralStore }

  after :each do
    File.delete(project_path + "/config.yml") if File.exist?(project_path + "/config.yml")
  end

  describe '.create' do
    it 'yields to ostruct' do
      expect {|probe| subject.create(project_path, &probe) }
        .to yield_control
    end
  end

  describe '.read' do
    it 'reads the attributes' do
      subject.create project_path do |gs|
        gs.test = 'test'
      end

      result = subject.read project_path
      expect(result.test).to eq('test')
    end
  end

  describe 'private methods' do
    let(:dir) { '~/.test-dir' }

    describe 'class methods' do
      it '.new' do
        expect { subject.public_send :new }
          .to raise_error NoMethodError, /private method/
      end
    end
  end
end
