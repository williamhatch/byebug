require_relative 'test_helper'

class TestMethod < TestDsl::TestCase
  temporary_change_hash Byebug::Command.settings, :autolist, 0

  describe 'show instance method of a class' do
    it 'must show using full command name' do
      enter 'break 15', 'cont', 'method MethodEx'
      debug_file 'method'
      check_output_includes /bla/
      check_output_doesnt_include /foo/
    end

    it 'must show using shortcut' do
      enter 'break 15', 'cont', 'm MethodEx'
      debug_file 'method'
      check_output_includes /bla/
    end

    it 'must show an error if specified object is not a class or module' do
      enter 'break 15', 'cont', 'm a'
      debug_file 'method'
      check_output_includes 'Should be Class/Module: a'
    end
  end

  describe 'show methods of an object' do
    it 'must show using full command name' do
      enter 'break 15', 'cont', 'method instance a'
      debug_file 'method'
      check_output_includes /bla/
      check_output_doesnt_include /foo/
    end

    it 'must show using shortcut' do
      enter 'break 15', 'cont', 'm i a'
      debug_file 'method'
      check_output_includes /bla/
    end
  end

  describe 'show signature of a method' do
    it 'must work' do
      skip('TODO, can\'t install ruby-internal gem')
    end
  end

  describe 'show instance variables of an object' do
    it 'must show using full name command' do
      enter 'break 15', 'cont', 'method iv a'
      debug_file 'method'
      check_output_includes '@a = "b"', '@c = "d"'
    end

    it 'must show using shortcut' do
      enter 'break 15', 'cont', 'm iv a'
      debug_file 'method'
      check_output_includes '@a = "b"', '@c = "d"'
    end
  end

  describe 'Post Mortem' do
    it 'must work in post-mortem mode' do
      enter 'cont', 'm i self'
      debug_file 'post_mortem'
      check_output_includes /to_s/
    end
  end

end
