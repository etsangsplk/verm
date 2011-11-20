require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), 'create_files_tests'))

class CreateFilesRawTest < Verm::TestCase
  def setup
    super
    @raw = true
  end

  include CreateFilesSharedTests

  def test_saves_gzip_content_encoded_files_as_gzipped_but_returns_non_gzipped_path
    location_compressed =
      post_file :path => '/foo',
                :file => 'simple_text_file.gz',
                :type => 'text/plain',
                :encoding => 'gzip',
                :expected_extension => 'txt', # this is the expected extension of the path
                :expected_extension_suffix => 'gz' # but this is further expected on the filename
    
    location_uncompressed =
      post_file :path => '/foo',
                :file => 'simple_text_file',
                :type => 'text/plain',
                :expected_extension => 'txt'

    assert_equal location_compressed, location_uncompressed # hash must be based on the content, not the encoded content
  end
end