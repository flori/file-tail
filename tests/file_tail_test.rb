#!/usr/bin/env ruby

require 'test_helper'
require 'file/tail'
require 'timeout'
require 'thread'
Thread.abort_on_exception = true

class FileTailTest < Test::Unit::TestCase
  include File::Tail

  def setup
    @out = File.new("test.#$$", "wb")
    append(@out, 100)
    @in = File.new(@out.path, "rb")
    @in.extend(File::Tail)
    @in.interval            = 0.4
    @in.max_interval        = 0.8
    @in.reopen_deleted      = true # is default
    @in.reopen_suspicious   = true # is default
    @in.suspicious_interval  = 60
  end

  def test_forward
    [ 0, 1, 2, 10, 100 ].each do |lines|
      @in.forward(lines)
      assert_equal(100 - lines, count(@in))
    end
    @in.forward(101)
    assert_equal(0, count(@in))
  end

  def test_backward
    [ 0, 1, 2, 10, 100 ].each do |lines|
      @in.backward(lines)
      assert_equal(lines, count(@in))
    end
    @in.backward(101)
    assert_equal(100, count(@in))
  end

  def test_backward_small_buffer
    [ 0, 1, 2, 10, 100 ].each do |lines|
      @in.backward(lines, 100)
      assert_equal(lines, count(@in))
    end
    @in.backward(101, 100)
    assert_equal(100, count(@in))
  end

  def test_backward_small_buffer2
    @in.default_bufsize = 100
    [ 0, 1, 2, 10, 100 ].each do |lines|
      @in.backward(lines)
      assert_equal(lines, count(@in))
    end
    @in.backward(101)
    assert_equal(100, count(@in))
  end

  def test_tail_with_block_without_n
    timeout(10) do
      lines = []
      @in.backward(1)
      assert_raises(TimeoutError) do
        timeout(1) { @in.tail { |l| lines << l } }
      end
      assert_equal(1, lines.size)
      #
      lines = []
      @in.backward(10)
      assert_raises(TimeoutError) do
        timeout(1) { @in.tail { |l| lines << l } }
      end
      assert_equal(10, lines.size)
      #
      lines = []
      @in.backward(100)
      assert_raises(TimeoutError) do
        timeout(1) { @in.tail { |l| lines << l } }
      end
      assert_equal(100, lines.size)
      #
      lines = []
      @in.backward(101)
      assert_raises(TimeoutError) do
        timeout(1) { @in.tail { |l| lines << l } }
      end
    end
  end

  def test_tail_with_block_with_n
    timeout(10) do
      @in.backward(1)
      lines = []
      timeout(1) { @in.tail(0) { |l| lines << l } }
      assert_equal(0, lines.size)
      #
      @in.backward(1)
      lines = []
      timeout(1) { @in.tail(1) { |l| lines << l } }
      assert_equal(1, lines.size)
      #
      @in.backward(10)
      lines = []
      timeout(1) { @in.tail(10) { |l| lines << l } }
      assert_equal(10, lines.size)
      #
      @in.backward(100)
      lines = []
      @in.backward(1)
      assert_raises(TimeoutError) do
        timeout(1) { @in.tail(2) { |l| lines << l } }
      end
      assert_equal(1, lines.size)
      #
    end
  end

  def test_tail_without_block_with_n
    timeout(10) do
      @in.backward(1)
      lines = []
      timeout(1) { lines += @in.tail(0) }
      assert_equal(0, lines.size)
      #
      @in.backward(1)
      lines = []
      timeout(1) { lines += @in.tail(1) }
      assert_equal(1, lines.size)
      #
      @in.backward(10)
      lines = []
      timeout(1) { lines += @in.tail(10) }
      assert_equal(10, lines.size)
      #
      @in.backward(100)
      lines = []
      @in.backward(1)
      assert_raises(TimeoutError) do
        timeout(1) { lines += @in.tail(2) }
      end
      assert_equal(0, lines.size)
    end
  end

  def test_tail_withappend
    @in.backward
    lines = []
    logger = Thread.new do
      begin
        timeout(1) { @in.tail { |l| lines << l } }
      rescue TimeoutError
      end
    end
    appender = Thread.new { append(@out, 10) }
    appender.join
    logger.join
    assert_equal(10, lines.size)
  end

  def test_tail_truncated
    @in.backward
    lines = []
    logger = Thread.new do
      begin
        timeout(10) do
          @in.tail do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.close
      File.truncate(@out.path, 0)
      @out = File.new(@in.path, "ab")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(10, lines.size)
  end

  def test_tail_remove
    return if File::PATH_SEPARATOR == ';' # Grmpf! Windows...
    @in.backward
    reopened = false
    @in.after_reopen { |f| reopened = true }
    lines = []
    logger = Thread.new do
      begin
        timeout(2) do
          @in.tail do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.close
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(10, lines.size)
    assert reopened
  end

  def test_tail_remove2
    return if File::PATH_SEPARATOR == ';' # Grmpf! Windows...
    @in.backward
    reopened = false
    @in.after_reopen { |f| reopened = true }
    lines = []
    logger = Thread.new do
      begin
        timeout(2) do
          @in.tail do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.close
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
      sleep 1
      append(@out, 10)
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(30, lines.size)
    assert reopened
  end

  def test_tail_remove3
    return if File::PATH_SEPARATOR == ';' # Grmpf! Windows...
    @in.backward
    reopened = false
    @in.after_reopen { |f| reopened = true }
    lines = []
    logger = Thread.new do
      begin
        timeout(2) do
          @in.tail(15) do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.close
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
      sleep 1
      append(@out, 10)
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(15, lines.size)
    assert reopened
  end

  def test_tail_change
    return if File::PATH_SEPARATOR == ';' # Grmpf! Windows...
    @in.forward
    reopened = false
    assert_equal 0, @in.lineno
    @in.after_reopen { |f| reopened = true }
    lines = []
    logger = Thread.new do
      begin
        timeout(2) do
          @in.tail(110) do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.close
      File.unlink(@out.path)
      @out = File.new(@in.path, "wb")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(110, lines.size)
    assert reopened
    assert_equal 10, @in.lineno
  end

  def test_tail_change2
    return if File::PATH_SEPARATOR == ';' # Grmpf! Windows...
    @in.forward
    reopened = false
    assert_equal 0, @in.lineno
    @in.after_reopen { |f| reopened = true }
    lines = []
    logger = Thread.new do
      begin
        timeout(2) do
          @in.tail(110) do |l|
            lines << l
          end
        end
      rescue TimeoutError
      end
    end
    appender = Thread.new do
      until logger.stop?
        sleep 0.1
      end
      @out.truncate 0
      @out.close
      @out = File.new(@in.path, "wb")
      append(@out, 10)
    end
    appender.join
    logger.join
    assert_equal(110, lines.size)
    assert reopened
    assert_equal 10, @in.lineno
  end

  def teardown
    @in.close
    @out.close
    File.unlink(@out.path)
  end

  private

  def count(file)
    n = 0
    until file.eof?
      file.readline
      n += 1
    end
    return n
  end

  def append(file, n, size = 70)
    (1..n).each { |x| file << "#{x} #{"A" * size}\n" }
    file.flush
  end
end
