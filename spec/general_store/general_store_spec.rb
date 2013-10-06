require 'spec_helper'

describe GeneralStore do
  subject { GeneralStore }

  describe 'private methods' do
    let(:dir) { '~/.test-dir' }

    describe 'class methods' do
      def test_if_private_class method
        expect { subject.public_send method }
        .to raise_error NoMethodError, /private method/
      end

      it '.new' do
        test_if_private_class :new
      end

      it '.config_file' do
        test_if_private_class :config_file
      end

      it '.config_dir' do
        test_if_private_class :config_dir
      end

      it '.create_config_file' do
        test_if_private_class :create_config_file
      end

      it '.write_file' do
        test_if_private_class :write_file
      end

      it '.check_dir_existence' do
        test_if_private_class :check_dir_existence
      end

      it '.check_file_existence' do
        test_if_private_class :check_file_existence
      end
    end

    describe 'instance methods' do
      def test_if_private_instance method
        expect { subject.send(:new,{}).public_send method }
        .to raise_error NoMethodError, /private method/
      end

      it '#set' do
        test_if_private_instance :set
      end
    end
  end
end
