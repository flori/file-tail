# Changes

## 2024-09-13 v1.3.0

### Significant Changes

* **Improved waiting for log output by counting lines**
	+ Increased timeout from 2 seconds to 10 seconds in multiple places
* **Added Ruby version check in Dockerfile**
	+ Update `gem update --system` and installation to be conditional on Ruby version
	+ Replace `bundle` with `bundle install` in script section
* **Convert CHANGES file to CHANGES\.md**

### Bug Fixes

* **Add exit handler to delete temporary file**
	- Added at_exit block to delete test file created in setup method.
* **Refactor File class for debugging**
	- Remove hardcoded `$DEBUG` variable usage in reopen_file and output_debug_information methods
	- Introduce debug? method to check if `FILE_TAIL_DEBUG` environment variable is set to 1.

### Dependency Updates

* **Update Ruby dependencies and add new development dependencies**
	+ Added `.all_images.yml` file with Dockerfile configuration
	+ Updated Gemfile to use Ruby **3.5.18** instead of **2.7.8**
	+ Updated Rakefile to ignore additional files
	+ Updated `file-tail.gemspec` to include `.all_images.yml` in the list of files
	+ Updated `tests/file_tail_test.rb` to use absolute path for test file
	+ Added new development dependencies: `all_images`, `simplecov`, and `debug`
    + Updated dependency versions: `gem_hadar` to **1.17.1**, `test-unit` to
      **3.0**, and `tins` to **1.0**

## 2016-04-19 v1.2.0

* Make line separator configurable

## 2016-04-19 v1.1.1

* Fix tests on Ruby 2.3.0

## 2014-09-26 v1.1.0

* Depend on tins ~ 1.0

## 2012-05-31 v1.0.10

* Use rewind to force IO#lineno to be reset.

## 2012-05-31 v1.0.9

* Reopen file in :top mode at the beginning.

## 2011-12-24 v1.0.8

* Support simplecov.

## 2011-07-15 v1.0.7

* Use gem_hadar to shorten Rakefile.

## 2011-06-25 v1.0.6

* Create a gem spec file again.
* Added a File::Tail::Group to tail multiple files more easily.

## 2010-03-25 v1.0.5

* Added rtail executable, a nice app to supervise logfiles and logdirs.
* Disabled creation of gem spec file.
* Cleaned up documentation a bit.

## 2009-08-21 v1.0.4

* Fixed the threaded tests for Ruby 1.9.
* Create a gem spec file.
* Some cleanup.

## 2008-04-07 v1.0.3

* Danny Colligan <danny.colligan@sendori.com> reported a memory leak in long
  running scripts using file-tail. I changed file-ta il to only use block.call,
  which seems to improve the memory behaviour. I am still not sure, where the
  problem actually stems f rom, though.

## 2007-04-19 v1.0.2

* make_doc.rb was missing from the source archive. Thanks to Rick Ohnemus
  <rick.ohnemus@systemware.com> for reporting it.

## 2007-04-19 v1.0.1

* Bugfix: File::Tail::Logfile#open with block, now closes the file like
  File#open does. Found by Alex Doan <alex.doan@wachovia. com>,
  ruby-talk:248383.

## 2007-03-30 v1.0.0

* Bugfix: David.Barzilay@swisscom.com reported, that file tails may skip some
  log file lines, after rotating it. I think, that I fixed that problem.
* Added a after_reopen callback as well, that is called after reopening of the
  tailed file has occured.
* Removed rewind/wind methods even earlier than planned: I placed the
  deprecation warning for rewind method in File instead of File::Tail, which
  caused rewind to stop working completely after loading file/tail. Duh! I
  blame vim's matchit, because it jump ed to the wrong end keyword.

## 2007-02-08 v0.1.4

* Renamed rewind method to backward, and wind method to forward, because
  someone already had the good idea to name a method IO# rewind, which was
  overwritten by the mixed in File::Tail methods. The old methods are now
  deprecated and will be removed in a n ew 0.2.x version of the library.
* Added a bit more of documentation.

## 2005-08-20 v0.1.3

* Applied LOAD_PATH patch by Daniel Berger, binary mode changes were already in
  the CVS. Seemed to be like cheating to me, thou gh. ;)
* Skipping one windows test for the moment, too. Sigh!

## 2004-09-30 v0.1.2

* First Rubyforge release
* Added Rakefile
* Supports gem build now.

## 2004-09-01 v0.1.1

* Josh Endries <josh@endries.org> found a bug that caused File::Tail to
  malfunction on FreeBSD. Hotfix: Use a side effect of se ek to clearerr the
  tailed file handle after EOFError has been raised.

## 2004-04-13 v0.1.0

* API documentation with rdoc.
* return_if_eof attribute added.
* Added array return mode for finite tail call without block given.
* install.rb now uses ruby version site_dir.
* Some code and directory structure cleanup.

## 2002-08-02 v0.0.2

* Heavy refactoring, more and smaller methods and expception handling
* Added check for inode and device equality of files as suggested by James
  F.Hranicky <jfh@cise.ufl.edu> and Curt Sampson <cjs@ cynic.net> to cover
  remove rotation
* If filesize shrinks suddenly, File::Tail assumes that copy and truncate
  rotation has happend: The file is reopened and every new line is handled.
* NFS-Fix: Errno::ESTALE is caught.
* wind added to skip the first n lines, as James F.Hranicky's suggested and
  changed name of last-method to rewind, because I li ked his method names
  better than mine ;)
* Renamed next to tail either.
* The API has changed - but I think very few people care at the moment.
* Lots of tests added.

## 2002-07-30 v0.0.1

* Initial Release
