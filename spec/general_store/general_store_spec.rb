require 'spec_helper'

describe GeneralStore do
  subject { GeneralStore }

  before :each do
    subject.create project_path do |gs|
      gs.test = 'test'
      gs.token = 'token'
    end
  end

  after :each do
    File.delete(project_path + "/config.yml") if File.exist?(project_path + "/config.yml")
  end

  describe '.create' do
    it 'yields to ostruct' do
      expect {|probe| subject.create(project_path, &probe) }
        .to yield_control
    end

    it 'creates the config.yml file' do
      file = GeneralStore.config_file project_path
      expect(File.exists? file).to be_true
    end

    it 'handles deeply nested folders' do
      expect {
        subject.create('~/nested/folder/path') {}
      }.not_to raise_error
    end
  end

  describe '.read' do
    it 'reads the attributes' do
      expect(subject.read(project_path).test)
        .to eq('test')

      expect(subject.read(project_path).token)
        .to eq('token')
    end
  end

  describe 'world access' do
    it 'is not world readable' do
      file = subject.config_file project_path
      expect(File.world_writable? file).to be_nil
    end

    it 'is not world writable' do
      file = subject.config_file project_path
      expect(File.world_readable? file).to be_nil
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
