#!/usr/bin/env ruby

require 'test_helper'
require 'file/tail'
require 'timeout'
require 'thread'
require 'tempfile'
Thread.abort_on_exception = true

class FileTailGroupTest < Test::Unit::TestCase
  include File::Tail

  def test_create_group
    t, = make_file
    g = Group[t]
    assert_equal t.path, g.each_tailer.first.file.path
    assert_equal t.path, g.each_file.first.path
  end

  def test_stop_group
    t, = make_file
    g = Group[t]
    assert_equal t.path, g.each_tailer.first.file.path
    assert_equal t.path, g.each_file.first.path
    g.stop
    assert_nil g.each_file.first
  end

  def test_add_file_to_group
    g = Group.new
    t, = make_file
    g.add_file t
    assert_equal t.path, g.each_tailer.first.file.path
    assert_equal t.path, g.each_file.first.path
  end

  def test_add_filename_to_group
    g = Group.new
    t, name = make_file
    t.close
    g.add_filename name
    assert_equal name, g.each_tailer.first.file.path
    assert_equal t.path, g.each_file.first.path
  end

  def test_add_generic_to_group
    g = Group.new
    t1, n1 = make_file
    t1.close
    t2, n1 = make_file
    g << n1
    g << t2
    assert g.each_tailer.any? { |t| t.file.path == n1 }
    assert g.each_tailer.any? { |t| t.file.path == t2.path }
    assert g.each_file.any? { |t| t.path == n1 }
    assert g.each_file.any? { |t| t.path == t2.path }
  end

  def test_tail_multiple_files
    t1, = make_file
    t1.max_interval = 0.1
    t2, = make_file
    t2.max_interval = 0.1
    g = Group[t1, t2]
    q = Queue.new
    t = Thread.new do
      g.tail { |l| q << l }
    end
    t1.puts "foo"
    assert_equal "foo\n", q.pop
    t2.puts "bar"
    assert_equal "bar\n", q.pop
  ensure
    t and t.exit
  end

  private

  def make_file
    name = File.expand_path(File.join(Dir.tmpdir, "tmp.#$$"))
    file = File.open(name, 'w+')
    file.extend File::Tail
    return file, name
  end
end
